import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../l10n.dart';
import '../main.dart';

class WelcomeScreen extends StatelessWidget {
  final AppLanguage lang;
  final ValueChanged<AppLanguage> onLangChanged;
  final VoidCallback onEnter;

  const WelcomeScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
    required this.onEnter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A0A2E), Color(0xFF0A0510), Color(0xFF050208)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: _LanguageChip(lang: lang, onLangChanged: onLangChanged),
                ),
                const SizedBox(height: 12),
                GoldAvatar(asset: 'assets/images/tarot.png'),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.get('title', lang),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cinzel(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.get('welcome_tagline', lang),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nanumMyeongjo(
                    fontSize: 15,
                    color: Colors.amber.shade200,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  AppLocalizations.get('welcome_subtitle', lang),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 32),
                _ServiceCard(
                  icon: Icons.style,
                  title: AppLocalizations.get('tab_tarot', lang),
                  desc: AppLocalizations.get('welcome_tarot_desc', lang),
                  color: Colors.deepPurpleAccent,
                ),
                const SizedBox(height: 12),
                _ServiceCard(
                  icon: Icons.compass_calibration,
                  title: AppLocalizations.get('fs_intro_title', lang),
                  desc: AppLocalizations.get('welcome_fengshui_desc', lang),
                  color: Colors.tealAccent,
                ),
                const SizedBox(height: 12),
                _ServiceCard(
                  icon: Icons.auto_fix_high,
                  title: AppLocalizations.get('sj_intro_title', lang),
                  desc: AppLocalizations.get('welcome_shaman_desc', lang),
                  color: Colors.orangeAccent,
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onEnter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 8,
                      shadowColor: Colors.amber.withOpacity(0.4),
                    ),
                    child: Text(
                      AppLocalizations.get('welcome_enter', lang),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.get('welcome_footer', lang),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  final AppLanguage lang;
  final ValueChanged<AppLanguage> onLangChanged;

  const _LanguageChip({required this.lang, required this.onLangChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppLanguage>(
      onSelected: onLangChanged,
      offset: const Offset(0, 40),
      color: const Color(0xFF1A1025),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber.shade700),
          borderRadius: BorderRadius.circular(20),
          color: Colors.black45,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, color: Colors.amber, size: 18),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.getLangDisplayName(lang, lang),
              style: const TextStyle(color: Colors.amber, fontSize: 13),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.amber, size: 18),
          ],
        ),
      ),
      itemBuilder: (context) => AppLanguage.values.map((l) {
        return PopupMenuItem(
          value: l,
          child: Text(
            AppLocalizations.getLangDisplayName(l, lang),
            style: TextStyle(
              color: l == lang ? Colors.amber : Colors.white70,
              fontWeight: l == lang ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
