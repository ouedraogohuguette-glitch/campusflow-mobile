import 'package:flutter/material.dart';

import 'screens/title_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CampusFlowApp());
}

class CampusFlowApp extends StatelessWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusFlow',
      theme: AppTheme.light,
      home: const TitleScreen(),
    );
  }
}
