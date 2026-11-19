import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/adhkar_data.dart';
import '../services/storage_service.dart';
import 'settings_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/dhikr_selector.dart';
import '../widgets/progress_ring.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.storage, required this.themeMode, required this.onThemeChanged});
  final StorageService storage;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late int count, target;
  late String dhikr;
  late bool haptics;
  late final AnimationController _glowController;
  late final AnimationController _heartController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    count = widget.storage.count;
    target = widget.storage.target;
    dhikr = widget.storage.dhikr;
    haptics = widget.storage.haptics;
    _glowController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _heartController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150), lowerBound: 0.0, upperBound: 0.08);
  }

  @override
  void dispose() {
    _glowController.dispose();
    _heartController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  double get heartScale {
    final v = _heartController.value;
    if (v < 0.15) return 1.0 + v * 0.35;
    if (v < 0.30) return 1.05 - (v - 0.15) * 0.25;
    if (v < 0.45) return 1.0 + (v - 0.30) * 0.35;
    return 1.05 - (v - 0.45) * 0.08;
  }

  Future<void> increment() async {
    // يوقف عند الهدف - ما يكمل بعد الهدف
    if (count >= target) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('أتممت وِردك: $target مرة - $dhikr، صفّر العداد لتبدأ من جديد.')),
        );
      }
      return;
    }
    setState(() => count++);
    await widget.storage.saveCount(count);
    if (widget.storage.haptics) HapticFeedback.selectionClick();
    if (count == target && mounted) {
      if (widget.storage.haptics) HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ما شاء الله، أتممت وِردك! $target مرة - $dhikr')));
    }
  }

  Future<void> onBigButtonTap() async {
    if (widget.storage.haptics) HapticFeedback.mediumImpact();
    _pulseController.forward().then((_) => _pulseController.reverse());
    await increment();
    if (widget.storage.haptics && count >= target) HapticFeedback.vibrate();
  }

  Future<void> reset() async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('تصفير العداد؟'),
        content: const Text('سيتم تصفير العدد الحالي.'),
        actions: [TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('إلغاء')), FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('تصفير'))],
      ),
    );
    if (yes == true) { setState(() => count = 0); await widget.storage.saveCount(0); }
  }

  Future<void> chooseTarget() async {
    final v = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 38, height: 4, decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(5))),
          const SizedBox(height: 20), const Text('اختر وِردك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8), Text('الذكر المختار: $dhikr', style: const TextStyle(color: AppTheme.emerald, fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4), const Text('حدد عدد التسبيحات التي ترغب بإكمالها، سيتوقف العداد عندها', style: TextStyle(color: AppTheme.muted, fontSize: 12)),
          const SizedBox(height: 16),
          for (final n in targets) ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            title: Center(child: Text('$n مرة - $dhikr', style: const TextStyle(fontWeight: FontWeight.w600))),
            trailing: target == n ? const Icon(Icons.check_circle, color: AppTheme.gold) : const Icon(Icons.circle_outlined, color: Colors.black26),
            onTap: () => Navigator.pop(c, n),
          ),
        ]),
      )),
    );
    if (v != null) { setState(() { target = v; count = 0; }); await widget.storage.saveTarget(v); await widget.storage.saveCount(0); }
  }

  Future<void> chooseDhikr(String value) async {
    if (value == dhikr) return;
    setState(() { dhikr = value; count = 0; });
    await widget.storage.saveDhikr(value);
    await widget.storage.saveCount(0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MisbahatiColors>()!;
    final finished = count >= target;
    return Scaffold(
    drawer: AppDrawer(storage: widget.storage, themeMode: widget.themeMode, onThemeChanged: widget.onThemeChanged),
    appBar: AppBar(
      title: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.spa_rounded, color: AppTheme.gold, size: 21),
        const SizedBox(width: 9), const Text('سَكِينة'),
      ]),
      actions: [IconButton(tooltip: 'الإعدادات', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen(storage: widget.storage, themeMode: widget.themeMode, onThemeChanged: widget.onThemeChanged))), icon: const Icon(Icons.tune_rounded, color: AppTheme.muted, size: 21))],
    ),
    body: Stack(children: [
      Positioned(top: -100, right: -100, child: AnimatedBuilder(animation: _glowController, builder: (_, __) => Container(width: 260, height: 260, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [AppTheme.gold.withOpacity(.07 + _glowController.value * .045), Colors.transparent]))))),
      SafeArea(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 30),
        child: Column(children: [
          const SizedBox(height: 7),
          const Text('السَّكِينَةُ تَبْدَأُ بِذِكْرِ الله', style: TextStyle(color: AppTheme.gold, fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          const Text('اجعل لروحك نصيبًا من الطمأنينة', style: TextStyle(color: AppTheme.muted, fontSize: 13)),
          const SizedBox(height: 25),
          DhikrSelector(selected: dhikr, onSelected: chooseDhikr),
          const SizedBox(height: 27),
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _heartController,
                builder: (_, __) => Transform.scale(
                  scale: heartScale,
                  child: Container(
                    width: 295, height: 295,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF7FB3D5).withOpacity(0.12),
                          const Color(0xFF10B981).withOpacity(0.10),
                          const Color(0xFF14B8A6).withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _heartController,
                builder: (_, __) => Transform.scale(
                  scale: 1.0 + (_heartController.value < 0.3 ? _heartController.value * 0.04 : 0.0),
                  child: Container(
                    width: 255, height: 255,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.gold.withOpacity(0.18), width: 1.2),
                    ),
                  ),
                ),
              ),
              ProgressRing(count: count, target: target, onTap: increment),
            ],
          ),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.touch_app_rounded, size: 16, color: AppTheme.gold.withOpacity(.8)),
            const SizedBox(width: 7),
            Text(finished ? 'أتممت وِردك - صفّر لتبدأ من جديد' : 'المس الدائرة أو الزر للتسبيح', style: TextStyle(color: AppTheme.muted, fontSize: 12)),
          ]),
          const SizedBox(height: 24),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, child) => Transform.scale(scale: 1.0 - _pulseController.value, child: child),
            child: SizedBox(width: double.infinity, height: 59, child: FilledButton(
              onPressed: onBigButtonTap,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.fingerprint_rounded, size: 24),
                const SizedBox(width: 10),
                Text(finished ? 'أتممت - $dhikr' : dhikr, style: const TextStyle(fontSize: 17, letterSpacing: .3)),
              ]),
            )),
          ),
          const SizedBox(height: 13),
          Row(children: [
            Expanded(child: _UtilityButton(icon: Icons.flag_rounded, title: 'الهدف', value: '$target - $dhikr', onTap: chooseTarget)),
            const SizedBox(width: 12),
            Expanded(child: _UtilityButton(icon: Icons.restart_alt_rounded, title: 'إعادة العداد', value: 'تصفير', onTap: reset)),
          ]),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 22, height: 1, color: AppTheme.gold.withOpacity(.35)),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('وَاذْكُرُوا اللَّهَ كَثِيرًا', style: TextStyle(color: AppTheme.muted, fontSize: 11))),
            Container(width: 22, height: 1, color: AppTheme.gold.withOpacity(.35)),
          ]),
        ]),
      )),
    ]),
  );
  }
}

class _UtilityButton extends StatelessWidget {
  const _UtilityButton({required this.icon, required this.title, required this.value, required this.onTap});
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MisbahatiColors>()!;
    return Material(
    color: colors.surface,
    borderRadius: BorderRadius.circular(17),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), border: Border.all(color: Colors.black12)),
        child: Row(children: [
          Container(width: 37, height: 37, decoration: BoxDecoration(color: AppTheme.gold.withOpacity(.10), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: AppTheme.gold, size: 19)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(color: colors.muted, fontSize: 11)), const SizedBox(height: 3), Text(value, style: TextStyle(color: colors.text, fontWeight: FontWeight.w700, fontSize: 14))])),
          const Icon(Icons.chevron_left_rounded, color: Colors.black38, size: 18),
        ]),
      ),
    ),
  );
  }
}