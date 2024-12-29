import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/about/about_screen.dart';
import '../screens/services/services_screen.dart';
import '../screens/gallery/gallery_screen.dart';
import '../screens/contact/contact_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomeScreen(),
  '/services': (context) => ServicesScreen(),
  '/gallery': (context) => GalleryScreen(),
  '/contact': (context) => const ContactScreen(),
  '/about': (context) => AboutScreen(),
};