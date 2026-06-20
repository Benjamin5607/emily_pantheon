import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'l10n.dart';

class TarotConsultationResult {
  final String text;
  final bool isAi;
  const TarotConsultationResult({required this.text, required this.isAi});
}

class RoutingService {
  static Future<TarotConsultationResult> getConsultation({
    required List<String> cards,
    required String topic,
    required String query,
    required String lang,
    AppLanguage? appLang,
  }) async {
    final resolvedLang = appLang ?? _langFromServerCode(lang);
    String cleanQuery = query.trim();
    print("🔍 [Router] 타로 분석 시작: '$cleanQuery'");

    // Only skip AI for empty/trivial input (1-2 chars)
    if (cleanQuery.length < 3) {
      print("🚀 [Filter] 질문이 너무 짧음 -> Tier 1 (기본 해석)");
      return TarotConsultationResult(
        text: await _getTier1BasicResponse(cards, topic, lang, appLang, includeHeader: true),
        isAi: false,
      );
    }

    String cacheKey = "tarot_${cleanQuery.replaceAll(' ', '')}_${cards.join()}";
    String? cached = await _checkCache(cacheKey);
    if (cached != null) {
      print("🚀 [Cache] 저장된 AI 답변 재사용");
      return TarotConsultationResult(text: cached, isAi: true);
    }

    print("🔮 [AI] 에밀리 AI 소환!");
    try {
      String result = await ApiService.readTarot(
        cards: cards,
        topic: topic,
        query: cleanQuery,
        lang: lang,
      );
      await _saveToCache(cacheKey, result);
      return TarotConsultationResult(text: result, isAi: true);
    } catch (e) {
      print("⚠️ AI 호출 실패: $e");
      final notice = AppLocalizations.get('ai_fallback_notice', resolvedLang);
      final fallback = await _getTier1BasicResponse(cards, topic, lang, appLang, includeHeader: true);
      return TarotConsultationResult(text: "$notice\n\n$fallback", isAi: false);
    }
  }

  static Future<String> _getTier1BasicResponse(
    List<String> cards,
    String topic,
    String lang,
    AppLanguage? appLang, {
    bool includeHeader = true,
  }) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/tier1_data.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);

      final resolvedLang = appLang ?? _langFromServerCode(lang);
      StringBuffer result = StringBuffer();

      if (includeHeader) {
        result.writeln(AppLocalizations.get('tier1_header', resolvedLang));
      }

      String key = appLang != null
          ? AppLocalizations.topicToTier1Key(topic, appLang)
          : _topicToKey(topic);

      for (String cardName in cards) {
        String desc = data[cardName]?[key] ?? "No description.";
        result.writeln("🎴 **$cardName**: $desc\n");
      }
      return result.toString();
    } catch (e) {
      final resolvedLang = appLang ?? _langFromServerCode(lang);
      return AppLocalizations.get('tier1_error', resolvedLang);
    }
  }

  static AppLanguage _langFromServerCode(String lang) {
    switch (lang) {
      case 'English':
        return AppLanguage.english;
      case '中文':
        return AppLanguage.chinese;
      case '日本語':
        return AppLanguage.japanese;
      case 'Vietnamese':
        return AppLanguage.vietnamese;
      default:
        return AppLanguage.korean;
    }
  }

  static String _topicToKey(String topic) {
    if (topic.contains('연애') || topic == 'Love' || topic.contains('爱情') || topic.contains('恋')) return 'love';
    if (topic.contains('금전') || topic == 'Money' || topic.contains('金钱') || topic.contains('金')) return 'money';
    if (topic.contains('건강') || topic == 'Health' || topic.contains('健康')) return 'health';
    return 'work';
  }

  static Future<String?> _checkCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonStr = prefs.getString(key);
    if (jsonStr == null) return null;

    Map<String, dynamic> cachedData = jsonDecode(jsonStr);
    if (DateTime.now().millisecondsSinceEpoch > cachedData['expiry']) {
      await prefs.remove(key);
      return null;
    }
    return cachedData['result'];
  }

  static Future<void> _saveToCache(String key, String result) async {
    final prefs = await SharedPreferences.getInstance();
    int oneWeekLater = DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch;
    await prefs.setString(key, jsonEncode({"result": result, "expiry": oneWeekLater}));
  }
}
