import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart';
import 'l10n.dart'; 
import 'screens/tarot_screen.dart';
import 'screens/fengshui_screen.dart';
import 'screens/saju_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLanguage _currLang = AppLanguage.korean;

  void _changeLanguage(AppLanguage lang) {
    setState(() {
      _currLang = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Emily's Pantheon",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0510),
        colorScheme: const ColorScheme.dark(primary: Colors.amber, secondary: Colors.cyanAccent),
        textTheme: GoogleFonts.nanumMyeongjoTextTheme(ThemeData.dark().textTheme),
      ),
      home: MainLayoutScreen(
        key: ValueKey(_currLang), 
        currLang: _currLang,
        onLangChanged: _changeLanguage,
      ),
    );
  }
}

class MainLayoutScreen extends StatefulWidget {
  final AppLanguage currLang;
  final Function(AppLanguage) onLangChanged;
  const MainLayoutScreen({super.key, required this.currLang, required this.onLangChanged});
  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      CyberTarotScreen(lang: widget.currLang),
      FengShuiScreen(lang: widget.currLang),
      SajuScreen(lang: widget.currLang),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.get('title', widget.currLang), style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, color: Colors.amber)),
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton<AppLanguage>(
            icon: const Icon(Icons.language, color: Colors.amber),
            onSelected: widget.onLangChanged,
            itemBuilder: (context) => AppLanguage.values.map((l) => PopupMenuItem(value: l, child: Text(AppLocalizations.getLangName(l)))).toList(),
          )
        ],
      ),
      body: IndexedStack(index: _idx, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        backgroundColor: Colors.black,
        destinations: [
          NavigationDestination(icon: const Icon(Icons.style), label: AppLocalizations.get('tab_tarot', widget.currLang)),
          NavigationDestination(icon: const Icon(Icons.compass_calibration), label: AppLocalizations.get('tab_fengshui', widget.currLang)),
          NavigationDestination(icon: const Icon(Icons.auto_fix_high), label: AppLocalizations.get('tab_saju', widget.currLang)),
        ],
      ),
    );
  }
}

class GoldCard extends StatelessWidget {
  final Widget child;
  const GoldCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border.all(color: Colors.amber.shade700, width: 2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.15), blurRadius: 15, spreadRadius: 2)],
      ),
      child: child,
    );
  }
}

// 🔥 [수정완료] 외부에서 들어온 이미지(asset)를 정확히 사용하도록 수정
class GoldAvatar extends StatelessWidget {
  final String asset;
  // 기본값은 타로지만, 외부에서 값을 주면 그걸 우선으로 씀
  const GoldAvatar({super.key, this.asset = 'assets/images/tarot.png'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, 
      height: 120,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle, 
        color: Colors.black,
        border: Border.all(color: Colors.amber, width: 3), 
        boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 20)]
      ),
      child: ClipOval(
        child: Image.asset(
          asset, // 🔥 [핵심 수정] emilyImage 변수 삭제하고 this.asset을 바로 사용!
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.face_3, size: 60, color: Colors.amber));
          },
        ),
      ),
    );
  }
}