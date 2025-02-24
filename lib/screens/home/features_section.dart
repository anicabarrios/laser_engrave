import 'package:flutter/material.dart';
import 'package:laser_engrave/models/feature.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';


class FeaturesSection extends StatefulWidget {
  const FeaturesSection({super.key});

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  final List<Feature> features = [
    const Feature(
      title: 'Precision Metal Marking',
      description: 'High-precision laser marking for industrial components and metal surfaces.',
      icon: Icons.precision_manufacturing,
      capabilities: [
        'Serial numbers and QR codes',
        'Logo and branding marks',
        'Data matrix codes',
        'Surface texturing',
        'Anti-counterfeiting marks'
      ],
      imageUrl: 'assets/images/metal_marking.jpg',
    ),
    const Feature(
      title: 'Custom Wood Engraving',
      description: 'Artisanal wood engraving for personalized gifts and decorative items.',
      icon: Icons.carpenter,
      capabilities: [
        'Detailed artwork reproduction',
        'Photo engraving',
        'Custom patterns',
        'Text and calligraphy',
        'Deep relief engraving'
      ],
      imageUrl: 'assets/images/wood_engraving.jpg',
    ),
    const Feature(
      title: 'Jewelry Customization',
      description: 'Delicate engraving work for precious metals and jewelry pieces.',
      icon: Icons.diamond,
      capabilities: [
        'Ring inscriptions',
        'Pendant personalization',
        'Watch case marking',
        'Precious metal marking',
        'Micro-engraving'
      ],
      imageUrl: 'assets/images/jewelry.jpg',
    ),
    const Feature(
      title: 'Corporate Solutions',
      description: 'Comprehensive marking solutions for business and industrial applications.',
      icon: Icons.business,
      capabilities: [
        'Asset tracking systems',
        'Product authentication',
        'Batch coding',
        'Equipment labeling',
        'Safety marking'
      ],
      imageUrl: 'assets/images/corporate.jpg',
    ),
    const Feature(
      title: 'Promotional Products',
      description: 'Custom engraving for marketing materials and promotional items.',
      icon: Icons.campaign,
      capabilities: [
        'Corporate gifts',
        'Award plaques',
        'Marketing materials',
        'Event merchandise',
        'Brand collateral'
      ],
      imageUrl: 'assets/images/promotional.jpg',
    ),
    const Feature(
      title: 'Artistic Services',
      description: 'Creative laser applications for artists and designers.',
      icon: Icons.palette,
      capabilities: [
        'Custom artwork',
        'Pattern creation',
        'Textile design',
        'Mixed media projects',
        'Installation art'
      ],
      imageUrl: 'assets/images/artistic.jpg',
    ),
  ];

  int _selectedFeatureIndex = 0;

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
        gradient: AppColors.metallicGradient,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 60),
          isSmallScreen 
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Our Services & Capabilities',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 36),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Discover our comprehensive range of laser engraving and marking solutions',
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
              color: AppColors.darkTextColor.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: features.length,
            itemBuilder: (context, index) => _buildFeatureTab(index),
          ),
        ),
        const SizedBox(height: 30),
        _buildFeatureContent(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: List.generate(
                features.length,
                (index) => _buildFeatureTab(index),
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 3,
            child: _buildFeatureContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTab(int index) {
    final isSelected = index == _selectedFeatureIndex;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _selectedFeatureIndex = index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected 
                  ? AppColors.sapphire
                  : Colors.transparent,
              border: Border.all(
                color: isSelected 
                    ? AppColors.sapphire 
                    : AppColors.darkTextColor.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  features[index].icon,
                  color: isSelected 
                      ? AppColors.lightTextColor 
                      : AppColors.darkTextColor.withOpacity(0.7),
                ),
                const SizedBox(width: 12),
                Text(
                  features[index].title,
                  style: TextStyle(
                    color: isSelected 
                        ? AppColors.lightTextColor 
                        : AppColors.darkTextColor.withOpacity(0.7),
                    fontWeight: isSelected 
                        ? FontWeight.bold 
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureContent(BuildContext context) {
    final feature = features[_selectedFeatureIndex];

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.pearl,
        borderRadius: BorderRadius.circular(16),
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
                  feature.icon,
                  size: 28,
                  color: AppColors.sapphire,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature.description,
                      style: TextStyle(
                        color: AppColors.darkTextColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              feature.imageUrl,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Key Capabilities:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: feature.capabilities.map((capability) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.sapphire.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.sapphire.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: AppColors.sapphire,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      capability,
                      style: const TextStyle(
                        color: AppColors.darkTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/contact');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.sapphire,
              foregroundColor: AppColors.lightTextColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}