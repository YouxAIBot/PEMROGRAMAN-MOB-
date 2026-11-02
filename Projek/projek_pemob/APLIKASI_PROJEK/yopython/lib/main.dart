import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/common.dart';

void main() => runApp(const YoPythonApp());

class YoPythonApp extends StatelessWidget {
  const YoPythonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YoPython',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const Scaffold(body: Center(child: Brand())),
    );
  }
}