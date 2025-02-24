import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/about/about_screen.dart';
import '../screens/gallery/gallery_screen.dart';
import '../screens/contact/contact_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
    '/gallery': (context) => const GalleryScreen(),
  '/contact': (context) => const ContactScreen(),
  '/about': (context) => const AboutScreen(),
};