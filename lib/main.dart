import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'utils/colors.dart';

void main() {
  runApp(const LaserEngravingApp());
}

class LaserEngravingApp extends StatelessWidget {
  const LaserEngravingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laser Engraving Co.',
      theme: AppColors.themeData,
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}