import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../screens/info_screens.dart';
import '../screens/settings_screen.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.storage, required this.themeMode, required this.onThemeChanged});
  final StorageService storage;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  void go(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  void shareApp() {
    Share.share('سَكِينة - رفيق الذكر والطمأنينة 📿\nحمّل التطبيق وابدأ الذكر معنا.\nhttps://t.me/U_S5S');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MisbahatiColors>()!;
    return Drawer(
    backgroundColor: colors.surface,
    child: SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(16, 18, 16, 18), children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0F1B2D), Color(0xFF1A2E4A)]),
          border: Border.all(color: AppTheme.gold.withOpacity(.20)),
        ),
        child: Column(children: [
          Container(width: 62, height: 62, decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.gold.withOpacity(.12), border: Border.all(color: AppTheme.gold.withOpacity(.35))), child: const Icon(Icons.nightlight_round, color: AppTheme.goldLight, size: 29)),
          const SizedBox(height: 12),
          const Text('سَكِينة', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 4),
          const Text('رفيق الذكر والطمأنينة', style: TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 12),
          const Text('ᯓN-A-Qᯓ', style: TextStyle(color: Color(0xFFA8CBE8), fontSize: 12, fontWeight: FontWeight.w600)),
        ]),
      ),
      const SizedBox(height: 20),
      const Padding(padding: EdgeInsetsDirectional.only(start: 12, bottom: 8), child: Text('القائمة الرئيسية', style: TextStyle(color: AppTheme.muted, fontSize: 11, fontWeight: FontWeight.w600))),
      _DrawerItem(icon: Icons.home_rounded, title: 'الرئيسية', onTap: () => Navigator.pop(context)),
      _DrawerItem(icon: Icons.tune_rounded, title: 'الإعدادات', onTap: () => go(context, SettingsScreen(storage: storage, themeMode: themeMode, onThemeChanged: onThemeChanged))),
      _DrawerItem(icon: Icons.share_rounded, title: 'مشاركة التطبيق', onTap: shareApp),
      const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),
      const Padding(padding: EdgeInsetsDirectional.only(start: 12, bottom: 8), child: Text('عن التطبيق', style: TextStyle(color: AppTheme.muted, fontSize: 11, fontWeight: FontWeight.w600))),
      _DrawerItem(icon: Icons.support_agent_rounded, title: 'المساعدة والدعم', onTap: () => go(context, const HelpScreen())),
      _DrawerItem(icon: Icons.info_outline_rounded, title: 'عن سَكِينة', onTap: () => go(context, const AboutScreen())),
      const SizedBox(height: 20),
      const Center(child: Text('الإصدار 1.5.0', style: TextStyle(color: AppTheme.muted, fontSize: 10))),
    ])),
  );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.icon, required this.title, required this.onTap});
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: Icon(icon, color: AppTheme.gold, size: 21),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_left_rounded, color: AppTheme.muted, size: 19),
    ),
  );
}