import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.storage, required this.themeMode, required this.onThemeChanged});
  final StorageService storage;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  @override State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool enabled;
  late ThemeMode selectedMode;
  @override void initState() { super.initState(); enabled = widget.storage.haptics; selectedMode = widget.themeMode; }
  @override Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MisbahatiColors>();
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(appBar: AppBar(title: const Text('الإعدادات')), body: ListView(padding: const EdgeInsets.all(20), children: [
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0F1B2D), Color(0xFF1A2E4A)])),
        child: const Row(children: [Icon(Icons.tune_rounded, color: Color(0xFFA8CBE8), size: 28), SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('تجربتك، كما تحب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)), SizedBox(height: 4), Text('خصص مظهر التطبيق وطريقة التفاعل', style: TextStyle(color: Colors.white70, fontSize: 12))]))])),
      const SizedBox(height: 22), _section('المظهر'),
      Card(child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('اختر النمط المناسب لك', style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onSurface)), const SizedBox(height: 12),
        Row(children: [Expanded(child: _ThemeChoice(icon: Icons.light_mode_rounded, label: 'نهاري', selected: selectedMode == ThemeMode.light, onTap: () { setState(() => selectedMode = ThemeMode.light); widget.onThemeChanged(ThemeMode.light); })), const SizedBox(width: 10), Expanded(child: _ThemeChoice(icon: Icons.dark_mode_rounded, label: 'ليلي', selected: selectedMode == ThemeMode.dark, onTap: () { setState(() => selectedMode = ThemeMode.dark); widget.onThemeChanged(ThemeMode.dark); }))]),
        const SizedBox(height: 8), Text('يُحفظ اختيارك تلقائيًا حتى بعد إغلاق التطبيق.', style: TextStyle(color: colors?.muted, fontSize: 11)),
      ]))),
      const SizedBox(height: 22), _section('التفاعل'),
      Card(child: SwitchListTile(value: enabled, activeColor: AppTheme.emerald, secondary: const Icon(Icons.vibration_rounded), title: const Text('الاهتزاز عند التسبيح', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)), subtitle: const Text('اهتزاز خفيف مع كل ضغطة'), onChanged: (v) async { setState(() => enabled = v); await widget.storage.saveHaptics(v); })),
      const SizedBox(height: 22), _section('حول التطبيق'),
      Card(child: const ListTile(leading: Icon(Icons.spa_rounded), title: Text('مسبحتي', style: TextStyle(fontWeight: FontWeight.w700)), trailing: Text('1.4.0'))),
    ]));
  }
  Widget _section(String title) => Padding(padding: const EdgeInsetsDirectional.only(start: 5, bottom: 10), child: Text(title, style: const TextStyle(color: AppTheme.emerald, fontWeight: FontWeight.w700, fontSize: 12)));
}

class _ThemeChoice extends StatelessWidget {
  const _ThemeChoice({required this.icon, required this.label, required this.selected, required this.onTap});
  final IconData icon; final String label; final bool selected; final VoidCallback onTap;
  @override Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(15), child: AnimatedContainer(duration: const Duration(milliseconds: 220), padding: const EdgeInsets.symmetric(vertical: 15), decoration: BoxDecoration(color: selected ? AppTheme.emerald.withOpacity(.12) : Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(15), border: Border.all(color: selected ? AppTheme.emerald : Theme.of(context).colorScheme.outline, width: selected ? 1.6 : 1)), child: Column(children: [Icon(icon, color: AppTheme.emerald, size: 24), const SizedBox(height: 7), Text(label, style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface)), if (selected) const Padding(padding: EdgeInsets.only(top: 4), child: Icon(Icons.check_circle, color: AppTheme.emerald, size: 16))])));
}
