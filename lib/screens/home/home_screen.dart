import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';
import '../../screens/home/floating_contact_button.dart';
import '../../utils/colors.dart';
import './hero_section.dart';
import './features_section.dart';
import './testimonials_section.dart';
import './project_showcase.dart';
import './cta.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.lightTextColor),
      ),
      backgroundColor: AppColors.lightColor,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                const HeroSection(),
                
                // Main content sections
                const SizedBox(height: 40),
                const FeaturesSection(),
                const ProjectSection(),
                const TestimonialSection(),
                const CTASection(),
              ],
            ),
          ),
          
          // Floating Contact Button
          const FloatingContactButton(),
        ],
      ),
    );
  }

  Widget _buildFeaturePreview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        elevation: 8,
        shadowColor: AppColors.darkColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: AppColors.metallicGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFeaturePreviewItem(
                Icons.precision_manufacturing,
                'Precision',
                'Up to 0.02mm accuracy',
              ),
              _buildFeaturePreviewItem(
                Icons.speed,
                'Fast',
                '24-hour turnaround',
              ),
              _buildFeaturePreviewItem(
                Icons.verified,
                'Quality',
                'ISO 9001:2015 certified',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturePreviewItem(IconData icon, String title, String subtitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.sapphire.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 32,
            color: AppColors.sapphire,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.darkTextColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}