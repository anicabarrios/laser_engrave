import 'package:flutter/material.dart';
import 'package:laser_engrave/config/responsive_breakpoints.dart';
import 'package:laser_engrave/utils/colors.dart';
import 'package:laser_engrave/utils/screen_utils.dart';

class TechnologySection extends StatelessWidget {
  const TechnologySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 60 : 100,
        horizontal: padding,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Our Technology',
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
                'State-of-the-Art Equipment & Capabilities',
                style: TextStyle(
                  fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                  color: AppColors.lightTextColor.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _technologies.length,
                itemBuilder: (context, index) =>
                    _TechnologyCard(tech: _technologies[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechnologyCard extends StatelessWidget {
  final Map<String, dynamic> tech;

  const _TechnologyCard({required this.tech});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: AppColors.metallicGradient,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.sapphire.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  tech['icon'],
                  size: 24,
                  color: AppColors.sapphire,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tech['name'],
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Text(
                      tech['type'],
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                        color: AppColors.sapphire,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!isSmallScreen)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildDescription(context, tech),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildSpecifications(context, tech),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDescription(context, tech),
                const SizedBox(height: 16),
                _buildSpecifications(context, tech),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, Map<String, dynamic> tech) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 16),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tech['description'],
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
            color: AppColors.darkTextColor.withOpacity(0.7),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecifications(BuildContext context, Map<String, dynamic> tech) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Specifications',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 16),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        const SizedBox(height: 8),
        ...tech['specifications'].map<Widget>((spec) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: AppColors.sapphire,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      spec,
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                        color: AppColors.darkTextColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

final List<Map<String, dynamic>> _technologies = [
  {
    'icon': Icons.precision_manufacturing,
    'name': 'Fiber Laser System',
    'type': 'Industrial Grade Equipment',
    'description': 'High-precision fiber laser marking system capable of engraving on metals, plastics, and coated materials with exceptional accuracy.',
    'specifications': [
      'Power Output: 50W',
      'Precision: ±0.02mm',
      'Work Area: 300x300mm',
      'Marking Speed: Up to 7000mm/s',
    ],
  },
  {
    'icon': Icons.co2,
    'name': 'CO2 Laser System',
    'type': 'Professional Grade Equipment',
    'description': 'Versatile CO2 laser system ideal for organic materials like wood, acrylic, and fabric, offering both cutting and engraving capabilities.',
    'specifications': [
      'Power Output: 100W',
      'Precision: ±0.05mm',
      'Work Area: 600x400mm',
      'Max Material Thickness: 15mm',
    ],
  },
  {
    'icon': Icons.design_services,
    'name': '3D Scanning System',
    'type': 'Advanced Modeling Equipment',
    'description': 'High-resolution 3D scanning system for precise object digitization and custom engraving pattern development.',
    'specifications': [
      'Resolution: Up to 0.1mm',
      'Scan Speed: 1M points/second',
      'Color Scanning: Yes',
      'Max Object Size: 800mm³',
    ],
  },
];