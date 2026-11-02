import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_view.dart';
import '../../widgets/common.dart';
import 'question_views.dart';

/// 07 Isi bagian kosong: pilih kata, kotak di kode ikut terisi.
class FillView extends StatefulWidget {
  final FillQuestion q;
  final bool locked;
  final ValueChanged<QAnswer> onChanged;
  const FillView({super.key, required this.q, required this.locked, required this.onChanged});

  @override
  State<FillView> createState() => _FillViewState();
}

class _FillViewState extends State<FillView> with ChoiceLogic<FillView> {
  @override
  ChoiceQuestion get cq => widget.q;
  @override
  bool get locked => widget.locked;
  @override
  ValueChanged<QAnswer> get onChanged => widget.onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CodeBlock(widget.q.code, blank: selected == null ? null : widget.q.choices[selected!]),
        const SizedBox(height: 16),
        const Text('Pilih jawaban untuk kotak kosong', style: AppText.small),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var i = 0; i < widget.q.choices.length; i++)
              SizedBox(
                width: 104,
                child: OptionTile(
                  minHeight: 48,
                  state: stateOf(i),
                  onTap: () => pick(i),
                  child: Center(child: Text(widget.q.choices[i], style: AppText.mono)),
                ),
              ),
          ],
        ),
      ],
    );
  }
}