import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api_service.dart';
import '../l10n.dart';
import '../main.dart'; 

class FengShuiScreen extends StatefulWidget {
  final AppLanguage lang;
  const FengShuiScreen({super.key, required this.lang});

  @override
  State<FengShuiScreen> createState() => _FengShuiScreenState();
}

class _FengShuiScreenState extends State<FengShuiScreen> {
  int _step = 0;
  final _birthYearController = TextEditingController();
  String _gender = 'Male';
  String _doorDir = 'North';
  String _headDir = 'North';
  final _addressController = TextEditingController();
  final _familyController = TextEditingController();
  final _queryController = TextEditingController();
  
  bool _isLoading = false;
  String _result = '';

  Future<void> _analyze() async {
    if (_birthYearController.text.isEmpty) return;
    
    setState(() => _isLoading = true);

    try {
      // 🔥 [수정 완료] 기존에는 한국어 아니면 무조건 "English"로 고정했으나,
      // 이제는 AppLocalizations를 통해 "Vietnamese", "Japanese" 등 실제 언어 이름을 가져옵니다.
      String langParam = AppLocalizations.getLangName(widget.lang); 

      final resultJson = await ApiService.getFengShuiReading(
        year: int.parse(_birthYearController.text),
        gender: _gender,
        doorDir: _doorDir,
        headDir: _headDir,
        address: _addressController.text,
        familyInfo: _familyController.text,
        query: _queryController.text,
        lang: langParam, // 이제 서버가 이 값을 보고 해당 언어로 답변합니다.
      );
      
      if (!mounted) return;

      setState(() {
        _result = resultJson; 
        _step = 4; 
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_fengshui.jpg'), 
          fit: BoxFit.cover, 
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
        ),
      ),
      child: Column(
        children: [
          LinearProgressIndicator(value: (_step + 1) / 5, backgroundColor: Colors.black, color: Colors.amber),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_step) {
      case 0: return _buildStep0_Intro();
      case 1: return _buildStep1_BirthData();
      case 2: return _buildStep2_HouseData();
      case 3: return _buildStep3_Query();
      case 4: return _buildStep4_Result();
      default: return const SizedBox();
    }
  }

  Widget _buildStep0_Intro() {
    return Column(
      children: [
        const SizedBox(height: 40),
        GoldAvatar(asset: 'assets/images/fengshui.png'), 
        const SizedBox(height: 20),
        Text(widget.lang == AppLanguage.korean ? "풍수지리 철학관" : "Feng Shui Master", 
            style: GoogleFonts.cinzel(fontSize: 28, color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          widget.lang == AppLanguage.korean 
          ? "당신의 공간에 흐르는 기운을 읽어드립니다." 
          : "I analyze the energy flow of your space.",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () => setState(() => _step = 1),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          child: Text(AppLocalizations.get('btn_next', widget.lang), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildStep1_BirthData() {
    return Column(
      children: [
        Text(AppLocalizations.get('birth_date', widget.lang), style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 20),
        GoldCard(
          child: Column(
            children: [
              TextField(
                controller: _birthYearController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: widget.lang == AppLanguage.korean ? "출생년도 (예: 1990)" : "Birth Year (ex: 1990)",
                  labelStyle: TextStyle(color: Colors.amber.shade200),
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _gender,
                dropdownColor: Colors.grey.shade900,
                style: const TextStyle(color: Colors.white),
                items: ['Male', 'Female'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => setState(() => _gender = val!),
                decoration: InputDecoration(
                  labelText: widget.lang == AppLanguage.korean ? "성별" : "Gender",
                  labelStyle: TextStyle(color: Colors.amber.shade200),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () { if (_birthYearController.text.isNotEmpty) setState(() => _step = 2); },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: Text(AppLocalizations.get('btn_next', widget.lang), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildStep2_HouseData() {
    final dirs = ['North', 'South', 'East', 'West', 'NE', 'NW', 'SE', 'SW'];
    return Column(
      children: [
        Text(widget.lang == AppLanguage.korean ? "집 정보" : "House Info", 
            style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 20),
        GoldCard(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _doorDir,
                dropdownColor: Colors.grey.shade900,
                style: const TextStyle(color: Colors.white),
                items: dirs.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (val) => setState(() => _doorDir = val!),
                decoration: InputDecoration(
                  labelText: widget.lang == AppLanguage.korean ? "현관 방향" : "Front Door Direction",
                  labelStyle: TextStyle(color: Colors.amber.shade200),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _headDir,
                dropdownColor: Colors.grey.shade900,
                style: const TextStyle(color: Colors.white),
                items: dirs.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (val) => setState(() => _headDir = val!),
                decoration: InputDecoration(
                  labelText: widget.lang == AppLanguage.korean ? "잠잘 때 머리 방향" : "Sleeping Head Direction",
                  labelStyle: TextStyle(color: Colors.amber.shade200),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _addressController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: widget.lang == AppLanguage.korean ? "거주 지역" : "Location (City)",
                  labelStyle: TextStyle(color: Colors.amber.shade200),
                  hintText: widget.lang == AppLanguage.korean ? "예: 서울시 강남구" : "ex: Seoul, New York",
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => setState(() => _step = 3),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: Text(AppLocalizations.get('btn_next', widget.lang), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildStep3_Query() {
    return Column(
      children: [
        Text(AppLocalizations.get('label_query', widget.lang), style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 20),
        GoldCard(
          child: TextField(
            controller: _queryController,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.lang == AppLanguage.korean 
                ? "인테리어, 가구 배치 등 궁금한 점을 적어주세요." 
                : "Ask about interior, layout, etc.",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 30),
        if (_isLoading) ...[
           const CircularProgressIndicator(color: Colors.amber),
           const SizedBox(height: 10),
           Text(widget.lang == AppLanguage.korean ? "기운을 분석 중입니다..." : "Analyzing Energy...", style: const TextStyle(color: Colors.amber))
        ]
        else
          ElevatedButton.icon(
            onPressed: () { if (_queryController.text.isNotEmpty) _analyze(); },
            icon: const Icon(Icons.analytics, color: Colors.black),
            label: Text(widget.lang == AppLanguage.korean ? "분석하기" : "Analyze", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          )
      ],
    );
  }

  Widget _buildStep4_Result() {
    return Column(
      children: [
        GoldAvatar(asset: 'assets/images/fengshui.png'),
        const SizedBox(height: 20),
        Text(widget.lang == AppLanguage.korean ? "분석 결과" : "Analysis Result", 
             style: GoogleFonts.cinzel(fontSize: 24, color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        GoldCard(
          child: Text(
            _result,
            style: const TextStyle(color: Colors.white, height: 1.6, fontSize: 15),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => setState(() { _step = 0; _queryController.clear(); _result = ''; }),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: Text(AppLocalizations.get('btn_reset', widget.lang), style: const TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}