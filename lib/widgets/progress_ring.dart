import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({super.key, required this.count, required this.target, required this.onTap});
  final int count;
  final int target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final progress = target <= 0 ? 0.0 : (count / target).clamp(0.0, 1.0);
    final colors = Theme.of(context).extension<MisbahatiColors>()!;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 286,
        height: 286,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: 278,
            height: 278,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [AppTheme.gold.withOpacity(.09), colors.background.withOpacity(0)]),
            ),
          ),
          SizedBox.expand(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (_, value, __) => CircularProgressIndicator(
                value: value,
                strokeWidth: 5.5,
                strokeCap: StrokeCap.round,
                backgroundColor: colors.outline.withOpacity(.65),
                valueColor: const AlwaysStoppedAnimation(AppTheme.gold),
              ),
            ),
          ),
          Container(
            width: 246,
            height: 246,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surface,
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [colors.surface, colors.raised]),
              border: Border.all(color: AppTheme.gold.withOpacity(.20)),
              boxShadow: [BoxShadow(color: AppTheme.gold.withOpacity(.13), blurRadius: 34, spreadRadius: 1), const BoxShadow(color: Color(0x1A244D3F), blurRadius: 24, offset: Offset(0, 12))],
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                decoration: BoxDecoration(color: AppTheme.gold.withOpacity(.09), borderRadius: BorderRadius.circular(30)),
                child: const Text('وِرْدُكَ الْيَوْم', style: TextStyle(color: AppTheme.goldLight, fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 12),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: ScaleTransition(scale: Tween<double>(begin: .88, end: 1).animate(animation), child: child)),
                child: Text('$count', key: ValueKey(count), style: TextStyle(fontSize: 66, height: 1.05, fontWeight: FontWeight.w300, color: colors.text, fontFeatures: [])),
              ),
              const SizedBox(height: 7),
              Text('من $target تسبيحة', style: TextStyle(color: colors.muted, fontSize: 13)),
              const SizedBox(height: 13),
              Text('${(progress * 100).round()}% مكتمل', style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.w700, fontSize: 12)),
            ]),
          ),
          Positioned(top: 7, child: Container(width: 9, height: 9, decoration: BoxDecoration(color: AppTheme.goldLight, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppTheme.gold.withOpacity(.7), blurRadius: 10)]))),
        ]),
      ),
    );
  }
}
