import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/code_view.dart';
import 'question_views.dart';

/// 09 Prediksi output: tebak apa yang dicetak kode.
class OutputView extends StatefulWidget {
  final OutputQuestion q;
  final bool locked;
  final ValueChanged<QAnswer> onChanged;
  const OutputView({super.key, required this.q, required this.locked, required this.onChanged});

  @override
  State<OutputView> createState() => _OutputViewState();
}

class _OutputViewState extends State<OutputView> with ChoiceLogic<OutputView> {
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
      children: [CodeBlock(widget.q.code), const SizedBox(height: 16), options()],
    );
  }
}