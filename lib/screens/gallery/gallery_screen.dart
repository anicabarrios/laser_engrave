import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Gallery Screen'),
      ),
    );
  }
}
