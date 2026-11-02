import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Pewarnaan sintaks Python sederhana: komentar, teks, angka, kata kunci.
final _token = RegExp(
  r'''(#.*$)|("[^"]*"|'[^']*')|(\b\d+(?:\.\d+)?\b)|(\b(?:print|if|else|elif|for|while|in|def|return|type|input|len|int|str|float|True|False|and|or|not)\b)''',
);

List<InlineSpan> highlightPython(String line, {Color base = AppColors.codeInk}) {
  final spans = <InlineSpan>[];
  var last = 0;
  for (final m in _token.allMatches(line)) {
    if (m.start > last) spans.add(TextSpan(text: line.substring(last, m.start)));
    final Color c;
    if (m.group(1) != null) {
      c = AppColors.codeComment;
    } else if (m.group(2) != null) {
      c = AppColors.codeString;
    } else if (m.group(3) != null) {
      c = AppColors.codeNumber;
    } else {
      c = AppColors.codeKeyword;
    }
    spans.add(
      TextSpan(
        text: m.group(0),
        style: TextStyle(color: c),
      ),
    );
    last = m.end;
  }
  if (last < line.length) spans.add(TextSpan(text: line.substring(last)));
  return spans;
}

const codeStyle = TextStyle(fontFamily: AppTheme.mono, fontSize: 15, height: 1.9, color: AppColors.codeInk);

/// Blok kode gelap. [blank] mengganti `___` dengan kotak isian.
class CodeBlock extends StatelessWidget {
  final List<String> lines;
  final String? blank; // teks yang mengisi ___ (null = kotak kosong)
  final double fontSize;
  const CodeBlock(this.lines, {super.key, this.blank, this.fontSize = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(color: AppColors.code, borderRadius: BorderRadius.circular(AppTheme.radius)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [for (final l in lines) _line(l)]),
      ),
    );
  }

  Widget _line(String l) {
    final style = codeStyle.copyWith(fontSize: fontSize);
    if (!l.contains('___')) {
      return Text.rich(TextSpan(style: style, children: highlightPython(l)));
    }
    final parts = l.split('___');
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          ...highlightPython(parts[0]),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              constraints: const BoxConstraints(minWidth: 72),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: blank == null ? Colors.transparent : AppColors.accent,
                border: Border.all(color: const Color(0xFF7CA9B6), width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(blank ?? ' ', style: style.copyWith(color: Colors.white, height: 1.5)),
            ),
          ),
          ...highlightPython(parts.sublist(1).join('___')),
        ],
      ),
    );
  }
}

/// Kotak "Output" hijau di kartu materi.
class OutputBox extends StatelessWidget {
  final String output;
  const OutputBox(this.output, {super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(color: AppColors.posSoft, borderRadius: BorderRadius.circular(AppTheme.radius)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text(
            'Output',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.posInk),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(output, style: AppText.mono)),
      ],
    ),
  );
}