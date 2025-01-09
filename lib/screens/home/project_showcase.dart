import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  final List<Map<String, dynamic>> projects = const [
    {
      'image': 'assets/images/project1.jpg',
      'title': 'Industrial Component Marking',
      'category': 'Manufacturing',
      'description': 'High-precision serial number and QR code marking for industrial components.',
    },
    {
      'image': 'assets/images/project2.jpg',
      'title': 'Custom Wood Engravings',
      'category': 'Custom Design',
      'description': 'Intricate designs on premium wooden surfaces for artistic and decorative purposes.',
    },
    {
      'image': 'assets/images/project3.jpg',
      'title': 'Jewelry Personalization',
      'category': 'Luxury',
      'description': 'Delicate engraving work on precious metals and jewelry pieces.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 40 : 80,
        horizontal: padding,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Column(
        children: [
          Text(
            'Featured Projects',
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 36),
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextColor,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Discover our latest work and innovative solutions',
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
              color: AppColors.lightTextColor.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 30,
                runSpacing: 30,
                children: projects.map((project) => SizedBox(
                  width: constraints.maxWidth < 600 
                      ? constraints.maxWidth 
                      : (constraints.maxWidth - 60) / 3,
                  child: _buildProjectCard(context, project),
                )).toList(),
              );
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/gallery');
            },
            icon: const Icon(Icons.photo_library),
            label: const Text('View All Projects'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentColor,
              foregroundColor: AppColors.lightTextColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.pearl,
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    project['image'],
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sapphire,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        project['category'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['title'],
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project['description'],
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                        color: AppColors.darkTextColor.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Navigate to project details
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.sapphire,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Learn More'),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}