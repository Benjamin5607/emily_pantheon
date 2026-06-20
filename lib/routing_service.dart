import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'l10n.dart';

class RoutingService {
  static const List<String> clicheKeywords = [
    '구남친', '전남친', '재회', '연락',
    '이직', '합격', '면접', '승진',
    '돈', '로또', '대출', '투자',
    'ex', 'boyfriend', 'lottery', 'job', 'money',
  ];

  static Future<String> getConsultation({
    required List<String> cards,
    required String topic,
    required String query,
    required String lang,
    AppLanguage? appLang,
  }) async {
    String cleanQuery = query.trim();
    print("🔍 [Router] 타로 분석 시작: '$cleanQuery'");

    if (cleanQuery.length < 10) {
      print("🚀 [Filter 1] 짧은 질문 -> Tier 1 (기본 해석)");
      return await _getTier1BasicResponse(cards, topic, lang, appLang);
    }

    for (String keyword in clicheKeywords) {
      if (cleanQuery.toLowerCase().contains(keyword.toLowerCase())) {
        print("🚀 [Filter 2] 뻔한 키워드('$keyword') -> Tier 1 (기본 해석)");
        return await _getTier1BasicResponse(cards, topic, lang, appLang);
      }
    }

    String cacheKey = "tarot_${cleanQuery.replaceAll(' ', '')}_${cards.join()}";
    String? cached = await _checkCache(cacheKey);
    if (cached != null) {
      print("🚀 [Filter 3] 캐시 적중 -> 저장된 답변 사용");
      return cached;
    }

    print("🔮 [Tier 2] AI 에밀리 소환!");
    try {
      String result = await ApiService.readTarot(cards: cards, topic: topic, query: cleanQuery, lang: lang);
      await _saveToCache(cacheKey, result);
      return result;
    } catch (e) {
      print("⚠️ AI 호출 실패 -> 비상용 Tier 1 데이터 사용");
      return await _getTier1BasicResponse(cards, topic, lang, appLang);
    }
  }

  static Future<String> _getTier1BasicResponse(
    List<String> cards,
    String topic,
    String lang,
    AppLanguage? appLang,
  ) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/tier1_data.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);

      final resolvedLang = appLang ?? _langFromServerCode(lang);
      StringBuffer result = StringBuffer();
      result.writeln(AppLocalizations.get('tier1_header', resolvedLang));

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
