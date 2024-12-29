import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Contact Screen'),
      ),
    );
  }
}