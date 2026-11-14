import 'package:flutter/material.dart';
import '../data/adhkar_data.dart';
import '../theme/app_theme.dart';

class DhikrSelector extends StatelessWidget {
  const DhikrSelector({super.key, required this.selected, required this.onSelected});
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MisbahatiColors>()!;
    return PopupMenuButton<String>(
    onSelected: onSelected,
    color: colors.raised,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: Colors.black12)),
    itemBuilder: (_) => adhkar.map((v) => PopupMenuItem(value: v, child: Text(v, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 15)))).toList(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppTheme.gold.withOpacity(.18)),
      ),
      child: Row(children: [
        Container(width: 38, height: 38, decoration: BoxDecoration(color: AppTheme.gold.withOpacity(.11), borderRadius: BorderRadius.circular(13)), child: const Icon(Icons.auto_awesome, color: AppTheme.gold, size: 19)),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('الذِّكْر الحالي', style: TextStyle(color: colors.muted, fontSize: 11)), const SizedBox(height: 4), Text(selected, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: colors.text), maxLines: 1, overflow: TextOverflow.ellipsis)])),
        const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.gold, size: 24),
      ]),
    ),
  );
  }
}
