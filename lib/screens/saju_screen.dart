import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart'; 
import '../api_service.dart';
import '../l10n.dart';
import '../main.dart'; 

class SajuScreen extends StatefulWidget {
  final AppLanguage lang;
  const SajuScreen({super.key, required this.lang});

  @override
  State<SajuScreen> createState() => _SajuScreenState();
}

class _SajuScreenState extends State<SajuScreen> {
  int _step = 0;
  DateTime? _birthDate;
  TimeOfDay? _birthTime;
  String _calendarType = 'Solar'; 
  final TextEditingController _queryController = TextEditingController();
  
  bool _isLoading = false;
  String _result = '';

  // 신점 보기
  Future<void> _getSajuResult() async {
    if (_birthDate == null || _birthTime == null) return;

    setState(() {
      _isLoading = true;
      _step = 3; 
    });

    try {
      // 1. 현재 앱에 설정된 언어 이름 가져오기 (예: "English", "Vietnamese", "Korean")
      String targetLang = AppLocalizations.getLangName(widget.lang);
      
      // 🔥 [핵심 수정] 복잡한 조건문 삭제! 그냥 무조건 "이 언어로 대답해"라고 명령 추가.
      // 이렇게 하면 AI가 사주 데이터(한자)를 보고 헷갈려도, 마지막 명령을 따르게 됩니다.
      String finalQuery = "${_queryController.text}\n\n(IMPORTANT: You must answer strictly in $targetLang.)";

      final result = await ApiService.getSajuReading(
        year: _birthDate!.year,
        month: _birthDate!.month,
        day: _birthDate!.day,
        hour: _birthTime!.hour,
        minute: _birthTime!.minute,
        calendarType: _calendarType,
        query: finalQuery, // 🔥 강제 명령이 포함된 질문 전송
        lang: targetLang,  // 서버 페르소나 설정용
      );

      if (!mounted) return;
      setState(() {
        _result = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // 날짜 선택 팝업
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: Colors.amber)), child: child!),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  // 시간 선택 팝업
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
      builder: (context, child) => Theme(data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: Colors.amber)), child: child!),
    );
    if (picked != null) setState(() => _birthTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_shaman.jpg'), 
          fit: BoxFit.cover, 
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
        ),
      ),
      child: Column(
        children: [
          LinearProgressIndicator(value: (_step + 1) / 4, backgroundColor: Colors.black, color: Colors.amber),
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
      case 1: return _buildStep1_BirthDate();
      case 2: return _buildStep2_Query();
      case 3: return _buildStep3_Result();
      default: return const SizedBox();
    }
  }

  Widget _buildStep0_Intro() {
    return Column(
      children: [
        const SizedBox(height: 40),
        GoldAvatar(asset: 'assets/images/shaman.png'),
        const SizedBox(height: 20),
        Text("Shaman Cheon-Myeong", style: GoogleFonts.cinzel(fontSize: 26, color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          widget.lang == AppLanguage.korean 
          ? "신령님의 목소리로 당신의 운명을 꿰뚫어 봅니다." 
          : "Piercing your destiny with the voice of the spirits.",
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

  Widget _buildStep1_BirthDate() {
    return Column(
      children: [
        Text(AppLocalizations.get('birth_date', widget.lang), style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 20),
        GoldCard(
          child: Column(
            children: [
              ListTile(
                title: Text(_birthDate == null ? (widget.lang == AppLanguage.korean ? "날짜 선택" : "Pick Date") : "${_birthDate!.year}-${_birthDate!.month}-${_birthDate!.day}", style: const TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.calendar_today, color: Colors.amber),
                onTap: _pickDate,
              ),
              const Divider(color: Colors.white24),
              ListTile(
                title: Text(_birthTime == null ? (widget.lang == AppLanguage.korean ? "시간 선택" : "Pick Time") : "${_birthTime!.hour}:${_birthTime!.minute}", style: const TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.access_time, color: Colors.amber),
                onTap: _pickTime,
              ),
              const Divider(color: Colors.white24),
              DropdownButtonFormField<String>(
                value: _calendarType,
                dropdownColor: Colors.grey.shade900,
                style: const TextStyle(color: Colors.white),
                items: ['Solar', 'Lunar'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (val) => setState(() => _calendarType = val!),
                decoration: InputDecoration(
                  labelText: widget.lang == AppLanguage.korean ? "양력/음력" : "Calendar Type",
                  labelStyle: TextStyle(color: Colors.amber.shade200),
                  border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16)
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () { if (_birthDate != null && _birthTime != null) setState(() => _step = 2); },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: Text(AppLocalizations.get('btn_next', widget.lang), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildStep2_Query() {
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
              hintText: widget.lang == AppLanguage.korean ? "무엇이 궁금하십니까?" : "What troubles you?",
              hintStyle: TextStyle(color: Colors.grey.shade500), border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () { if (_queryController.text.isNotEmpty) _getSajuResult(); },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          child: Text(AppLocalizations.get('shaman_summon', widget.lang), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildStep3_Result() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          GoldAvatar(asset: 'assets/images/shaman.png')
              .animate(onPlay: (controller) => controller.repeat())
              .shake(duration: 500.ms, hz: 6) 
              .shimmer(duration: 1000.ms, color: Colors.amberAccent),
          
          const SizedBox(height: 30),
          const CircularProgressIndicator(color: Colors.amber),
          const SizedBox(height: 20),
          Text(
            widget.lang == AppLanguage.korean 
              ? "신령님이 작두를 타고 계십니다..." 
              : "The Shaman is performing a ritual...", 
            style: const TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.bold)
          )
          .animate(onPlay: (c) => c.repeat())
          .fadeIn(duration: 600.ms).fadeOut(delay: 600.ms), 
        ],
      );
    }

    return Column(
      children: [
        GoldAvatar(asset: 'assets/images/shaman.png')
            .animate().scale(duration: 500.ms, curve: Curves.elasticOut), 
        const SizedBox(height: 20),
        Text("공수 (Oracle)", style: GoogleFonts.cinzel(fontSize: 26, color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        
        GoldCard(
          child: Text(
            _result,
            style: const TextStyle(color: Colors.white, height: 1.6, fontSize: 15),
          ),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0),

        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => setState(() { _step = 0; _queryController.clear(); _result = ''; _birthDate = null; _birthTime = null; }),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: Text(AppLocalizations.get('btn_reset', widget.lang), style: const TextStyle(color: Colors.black)),
        )
      ],
    );
  }
}