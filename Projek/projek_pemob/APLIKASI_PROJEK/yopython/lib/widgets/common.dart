import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Logo YoPython
class YoMark extends StatelessWidget {
  final double size;
  final Color color;
  const YoMark({super.key, this.size = 28, this.color = AppColors.accent});

  @override
  Widget build(BuildContext context) => CustomPaint(size: Size.square(size), painter: _MarkPainter(color));
}

class _MarkPainter extends CustomPainter {
  final Color color;
  _MarkPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 32;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    // sama dengan path SVG: M5 26h13a5 5 0 0 0 0-10h-4a5 5 0 0 1 0-10h9
    final p = Path()
      ..moveTo(5 * s, 26 * s)
      ..lineTo(18 * s, 26 * s)
      ..arcToPoint(Offset(18 * s, 16 * s), radius: Radius.circular(5 * s), clockwise: false)
      ..lineTo(14 * s, 16 * s)
      ..arcToPoint(Offset(14 * s, 6 * s), radius: Radius.circular(5 * s), clockwise: true)
      ..lineTo(23 * s, 6 * s);
    canvas.drawPath(p, stroke);
    canvas.drawCircle(Offset(27 * s, 6 * s), 3 * s, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _MarkPainter old) => old.color != color;
}

class Brand extends StatelessWidget {
  const Brand({super.key});
  @override
  Widget build(BuildContext context) => const Row(mainAxisSize: MainAxisSize.min, children: [
    YoMark(),
    SizedBox(width: 8),
    Text('YoPython', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
  ]);
}

enum BtnKind { primary, ghost, danger, white }

/// Tombol datar
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final BtnKind kind;
  final double height;
  const AppButton(this.label, {super.key, this.onPressed, this.kind = BtnKind.primary, this.height = 52});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    Color bg = AppColors.accent, fg = Colors.white;
    BorderSide side = BorderSide.none;
    switch (kind) {
      case BtnKind.primary:
        bg = AppColors.accent;
        fg = Colors.white;
      case BtnKind.ghost:
        bg = AppColors.surface;
        fg = AppColors.text;
        side = const BorderSide(color: AppColors.control);
      case BtnKind.danger:
        bg = AppColors.negInk;
        fg = Colors.white;
      case BtnKind.white:
        bg = Colors.white;
        fg = AppColors.ink;
    }
    if (!enabled) {
      bg = AppColors.raised;
      fg = AppColors.muted;
      side = BorderSide.none;
    }
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: bg,
          disabledForegroundColor: fg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius), side: side),
          textStyle: const TextStyle(fontFamily: AppTheme.sans, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}

class CardBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  const CardBox({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.borderColor});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: borderColor ?? AppColors.border),
      borderRadius: BorderRadius.circular(AppTheme.radius),
    ),
    child: child,
  );
}

class ProgressTrack extends StatelessWidget {
  final double value; // 0..1
  const ProgressTrack(this.value, {super.key});

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: LinearProgressIndicator(
      value: value,
      minHeight: 8,
      backgroundColor: AppColors.track,
      color: AppColors.accent,
    ),
  );
}

/// Pilihan bergantian
class SegmentedChoice extends StatelessWidget {
  final List<String> options;
  final int selected;
  final ValueChanged<int> onChanged;
  const SegmentedChoice({super.key, required this.options, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.raised, borderRadius: BorderRadius.circular(AppTheme.radius)),
      child: Row(children: [
        for (var i = 0; i < options.length; i++)
          Expanded(
            child: Semantics(
              selected: i == selected,
              button: true,
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == selected ? AppColors.surface : Colors.transparent,
                    border: Border.all(color: i == selected ? AppColors.border : Colors.transparent),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    options[i],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: i == selected ? FontWeight.w600 : FontWeight.w500,
                      color: i == selected ? AppColors.text : AppColors.muted,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}

/// Status tampilan sebuah pilihan.
enum OptState { idle, selected, correct, wrong, dim }

/// Satu pilihan jawaban (kotak bergaris). Dipakai di target harian dan kuis.
class OptionTile extends StatelessWidget {
  final Widget child;
  final OptState state;
  final VoidCallback? onTap;
  final bool showRadio;
  final double minHeight;
  final Widget? trailing;
  const OptionTile({
    super.key,
    required this.child,
    this.state = OptState.idle,
    this.onTap,
    this.showRadio = false,
    this.minHeight = 56,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    Color border = AppColors.control, bg = AppColors.surface;
    double w = 1;
    switch (state) {
      case OptState.selected:
        border = AppColors.accent;
        bg = AppColors.soft;
        w = 2;
      case OptState.correct:
        border = AppColors.pos;
        bg = AppColors.posSoft;
        w = 2;
      case OptState.wrong:
        border = AppColors.neg;
        bg = AppColors.negSoft;
        w = 2;
      case OptState.idle:
      case OptState.dim:
        break;
    }
    return Semantics(
      button: true,
      selected: state == OptState.selected,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: border, width: w),
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(children: [
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: state == OptState.dim ? AppColors.muted : AppColors.text,
                    ),
                    child: child,
                  ),
                ),
                if (trailing != null) trailing!,
                if (showRadio) _Radio(on: state == OptState.selected),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  final bool on;
  const _Radio({required this.on});
  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.soft,
      border: Border.all(color: on ? AppColors.accent : AppColors.control, width: on ? 6 : 2),
    ),
  );
}

class Pill extends StatelessWidget {
  final String text;
  final Color bg, fg;
  const Pill(this.text, {super.key, this.bg = AppColors.raised, this.fg = AppColors.text});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(11)),
    child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: fg)),
  );
}

void showSoon(BuildContext context, String page) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Halaman $page dibuat di langkah berikutnya.')),
  );
}