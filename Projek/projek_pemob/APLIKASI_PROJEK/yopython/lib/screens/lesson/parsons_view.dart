import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'question_views.dart';

/// 06 Susun kode: ketuk baris dari bank untuk mengisi slot.
class ParsonsView extends StatefulWidget {
  final ParsonsQuestion q;
  final bool locked; // true setelah Periksa: tidak bisa diubah, warna hasil tampil
  final ValueChanged<QAnswer> onChanged;
  const ParsonsView({super.key, required this.q, required this.locked, required this.onChanged});

  @override
  State<ParsonsView> createState() => _ParsonsViewState();
}

class _ParsonsViewState extends State<ParsonsView> {
  final List<int> placed = [];

  void _emit() {
    final q = widget.q;
    widget.onChanged(
      QAnswer(
        ready: placed.length == q.answer.length,
        correct: q.isCorrect(placed),
        text: placed.map((i) => q.bank[i]).join(' → '),
      ),
    );
  }

  void _place(int i) {
    if (widget.locked || placed.contains(i) || placed.length >= widget.q.answer.length) return;
    setState(() => placed.add(i));
    _emit();
  }

  void _remove(int slot) {
    if (widget.locked) return;
    setState(() => placed.removeAt(slot));
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.q;
    final ok = widget.locked && q.isCorrect(placed);
    final OptState placedState = !widget.locked ? OptState.selected : (ok ? OptState.correct : OptState.wrong);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CardBox(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              for (final line in q.fixedTop) ...[
                _CodeLine(line, state: OptState.dim, fill: AppColors.raised),
                const SizedBox(height: 8),
              ],
              for (var s = 0; s < q.answer.length; s++) ...[
                if (s < placed.length)
                  _CodeLine(q.bank[placed[s]], state: placedState, onTap: () => _remove(s))
                else
                  const _Slot(),
                if (s < q.answer.length - 1) const SizedBox(height: 8),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text('Ketuk baris untuk memindahkannya ke atas. Ketuk lagi untuk mengeluarkannya.', style: AppText.small),
        const SizedBox(height: 12),
        for (var i = 0; i < q.bank.length; i++) ...[
          if (placed.contains(i)) const _Slot(dotted: true) else _CodeLine(q.bank[i], onTap: () => _place(i)),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String text;
  final OptState state;
  final VoidCallback? onTap;
  final Color? fill;
  const _CodeLine(this.text, {this.state = OptState.idle, this.onTap, this.fill});

  @override
  Widget build(BuildContext context) {
    if (fill != null) {
      return Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(AppTheme.radius)),
        child: Text(text, style: AppText.mono),
      );
    }
    return OptionTile(
      minHeight: 48,
      state: state == OptState.dim ? OptState.idle : state,
      onTap: onTap,
      child: Text(text, style: AppText.mono),
    );
  }
}

class _Slot extends StatelessWidget {
  final bool dotted;
  const _Slot({this.dotted = false});

  @override
  Widget build(BuildContext context) => Container(
    height: 48,
    decoration: BoxDecoration(
      color: dotted ? AppColors.ground : null,
      border: Border.all(color: AppColors.control, width: 1.5),
      borderRadius: BorderRadius.circular(AppTheme.radius),
    ),
  );
}