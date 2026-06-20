import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://benjamin5607-my-fortune-project.hf.space";

  // 1. 타로 덱 가져오기
  static Future<List<dynamic>> getTarotDeck() async {
    final url = Uri.parse('$baseUrl/tarot/deck');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // 2. 타로 점
  static Future<String> readTarot({
    required List<String> cards,
    required String topic,
    required String query,
    required String lang,
  }) async {
    final url = Uri.parse('$baseUrl/tarot/read');
    
    // 🔥 [수정] 이제 복잡한 프롬프트 주입 없이 깔끔하게 보냅니다.
    // 서버가 'lang'을 보고 알아서 판단하기 때문입니다.
    final response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "cards": cards,
            "topic": topic,
            "query": query,
            "lang": lang,
          }),
        )
        .timeout(const Duration(seconds: 120));

    if (response.statusCode == 200) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      final result = body["result"];
      if (result == null || result.toString().isEmpty) {
        throw Exception("Tarot Error: empty response from server");
      }
      return result.toString();
    } else {
      final detail = utf8.decode(response.bodyBytes);
      throw Exception("Tarot Error ${response.statusCode}: $detail");
    }
  }

  // 3. 풍수 분석
  static Future<String> getFengShuiReading({
    required int year,
    required String gender,
    required String doorDir,
    required String headDir,
    required String query,
    required String lang,
    String? address,
    String? familyInfo,
  }) async {
    final url = Uri.parse('$baseUrl/fengshui/analyze');
    
    // 추가 정보만 살짝 합쳐서 보냄
    String fullQuery = "$query";
    if (address != null) fullQuery += " / Addr: $address";
    if (familyInfo != null) fullQuery += " / Fam: $familyInfo";

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "year": year,
        "gender": gender,
        "door_dir": doorDir,
        "head_dir": headDir,
        "query": fullQuery,
        "lang": lang,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))["result"];
    } else {
      throw Exception("FengShui Error: ${response.statusCode}");
    }
  }

  // 4. 신점
  static Future<String> getSajuReading({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    required String calendarType,
    required String query,
    required String lang,
  }) async {
    final url = Uri.parse('$baseUrl/shaman/read');
    
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "year": year,
        "month": month,
        "day": day,
        "hour": hour,
        "minute": minute,
        "calendar_type": calendarType,
        "query": query,
        "lang": lang,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))["result"];
    } else {
      throw Exception("Shaman Error: ${response.statusCode}");
    }
  }
}