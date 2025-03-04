import 'package:flutter/material.dart';
import 'package:laser_engrave/routes/routes.dart';
import 'utils/colors.dart';

void main() {
  runApp(const LaserEngraveApp());
}

class LaserEngraveApp extends StatelessWidget {
  const LaserEngraveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laser Engraving Co.',
      theme: AppColors.themeData,
      routes: appRoutes,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}