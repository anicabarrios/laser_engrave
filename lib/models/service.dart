import 'package:flutter/material.dart';

class Service {
  final String name;
  final String description;
  final String price;
  final IconData icon;

  const Service({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}