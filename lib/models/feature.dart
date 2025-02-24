import 'package:flutter/material.dart';

class Feature {
  final String title;
  final String description;
  final IconData icon;
  final List<String> capabilities;
  final String imageUrl;

  const Feature({
    required this.title,
    required this.description,
    required this.icon,
    required this.capabilities,
    required this.imageUrl,
  });
}