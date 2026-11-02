import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_view.dart';
import 'question_views.dart';

/// 08 Temukan bug: baris bermasalah ditandai, pilih perbaikannya.
class SpotBugView extends StatefulWidget {
  final SpotBugQuestion q;
  final bool locked;
  final ValueChanged<QAnswer> onChanged;
  const SpotBugView({super.key, required this.q, required this.locked, required this.onChanged});

  @override
  State<SpotBugView> createState() => _SpotBugViewState();
}

class _SpotBugViewState extends State<SpotBugView> with ChoiceLogic<SpotBugView> {
  @override
  ChoiceQuestion get cq => widget.q;
  @override
  bool get locked => widget.locked;
  @override
  ValueChanged<QAnswer> get onChanged => widget.onChanged;

  @override
  Widget build(BuildContext context) {
    final q = widget.q;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.code, borderRadius: BorderRadius.circular(AppTheme.radius)),
          child: Column(
            children: [
              for (var i = 0; i < q.code.length; i++)
                Container(
                  constraints: const BoxConstraints(minHeight: 46),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: i == q.bugLine ? AppColors.negSoft : null,
                    border: Border.all(color: i == q.bugLine ? AppColors.neg : Colors.transparent, width: 1.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22,
                        child: Text('${i + 1}', style: codeStyle.copyWith(color: AppColors.codeComment)),
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: codeStyle.copyWith(
                              height: 1.5,
                              color: i == q.bugLine ? AppColors.negInk : AppColors.codeInk,
                            ),
                            // baris bermasalah ditulis polos agar terbaca di latar merah muda
                            children: i == q.bugLine ? [TextSpan(text: q.code[i])] : highlightPython(q.code[i]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        options(),
      ],
    );
  }
}