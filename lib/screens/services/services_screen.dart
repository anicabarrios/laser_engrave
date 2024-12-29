import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Services Screen'),
      ),
    );
  }
}
