import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class RoutingService {
  // 🛡️ [Filter 2] 뻔한 키워드 리스트
  static const List<String> clicheKeywords = [
    '구남친', '전남친', '재회', '연락', // 연애
    '이직', '합격', '면접', '승진',     // 직장
    '돈', '로또', '대출', '투자'      // 금전
  ];

  // ---------------------------------------------------------------------------
  // 🃏 [타로 전용] 3단계 필터: 길이 -> 키워드 -> 캐시 -> AI
  // ---------------------------------------------------------------------------
  static Future<String> getConsultation({
    required List<String> cards,
    required String topic,
    required String query,
    required String lang,
  }) async {
    String cleanQuery = query.trim();
    print("🔍 [Router] 타로 분석 시작: '$cleanQuery'");

    // 1. [길이 필터] 질문이 너무 짧으면 (10자 미만) -> 기본 DB 사용
    if (cleanQuery.length < 10) {
      print("🚀 [Filter 1] 짧은 질문 -> Tier 1 (기본 해석)");
      return await _getTier1BasicResponse(cards, topic, lang);
    }

    // 2. [키워드 필터] 뻔한 질문이면 -> 기본 DB 사용
    for (String keyword in clicheKeywords) {
      if (cleanQuery.contains(keyword)) {
        print("🚀 [Filter 2] 뻔한 키워드('$keyword') -> Tier 1 (기본 해석)");
        return await _getTier1BasicResponse(cards, topic, lang);
      }
    }

    // 3. [캐시 필터] 1주일 내에 똑같은 질문 했으면 -> 저장된 AI 답변 재사용
    String cacheKey = "tarot_${cleanQuery.replaceAll(' ', '')}_${cards.join()}";
    String? cached = await _checkCache(cacheKey);
    if (cached != null) {
      print("🚀 [Filter 3] 캐시 적중 -> 저장된 답변 사용");
      return cached;
    }

    // 4. [Final Tier] 다 통과하면 -> 비싼 AI 호출
    print("🔮 [Tier 2] AI 무당 소환!");
    try {
      String result = await ApiService.readTarot(cards: cards, topic: topic, query: cleanQuery, lang: lang);
      // 답변 받으면 캐시에 저장 (다음번엔 돈 안 쓰게)
      await _saveToCache(cacheKey, result);
      return result;
    } catch (e) {
      // AI 에러나면 비상용 DB 사용
      print("⚠️ AI 호출 실패 -> 비상용 Tier 1 데이터 사용");
      return await _getTier1BasicResponse(cards, topic, lang);
    }
  }

  // ===========================================================================
  // 🛠️ 내부 지원 함수들
  // ===========================================================================

  // 📂 로컬 JSON 파일 읽기 (0원짜리 답변)
  static Future<String> _getTier1BasicResponse(List<String> cards, String topic, String lang) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/tier1_data.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      
      StringBuffer result = StringBuffer();
      
      // 언어별 인사말
      result.writeln(lang.contains("한국어") || lang.contains("Korean") 
          ? "💡 에밀리 노트(기본 해석)를 참고하여 답변드립니다.\n" 
          : "💡 Reading from Emily's Basic Notes.\n");

      // 주제 매핑
      String key = "work";
      if (topic.contains("연애") || topic == "Love") key = "love";
      else if (topic.contains("금전") || topic == "Money") key = "money";
      else if (topic.contains("건강") || topic == "Health") key = "health";

      // 카드별 해석
      for (String cardName in cards) {
        String desc = data[cardName]?[key] ?? "No description.";
        result.writeln("🎴 **$cardName**: $desc\n");
      }
      return result.toString();
    } catch (e) {
      return lang.contains("한국어") ? "데이터를 불러올 수 없습니다." : "Error loading data.";
    }
  }

  // 💾 캐시 확인
  static Future<String?> _checkCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonStr = prefs.getString(key);
    if (jsonStr == null) return null;

    Map<String, dynamic> cachedData = jsonDecode(jsonStr);
    if (DateTime.now().millisecondsSinceEpoch > cachedData['expiry']) {
      await prefs.remove(key); // 만료되면 삭제
      return null;
    }
    return cachedData['result'];
  }

  // 💾 캐시 저장 (7일)
  static Future<void> _saveToCache(String key, String result) async {
    final prefs = await SharedPreferences.getInstance();
    int oneWeekLater = DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch;
    await prefs.setString(key, jsonEncode({"result": result, "expiry": oneWeekLater}));
  }
}