import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('About Screen'),
      ),
    );
  }
}