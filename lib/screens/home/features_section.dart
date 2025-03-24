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
     imageUrl: 'assets/images/industrial2.webp',
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
        imageUrl: 'assets/images/wood.webp',
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
      imageUrl: 'assets/images/jewlery5.webp',
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
        imageUrl: 'assets/images/wood3.webp',
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
      imageUrl: 'assets/images/industrial4.webp',
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
      imageUrl: 'assets/images/engraved.webp',
    ),
  ];

  int _selectedFeatureIndex = 0;
  int _hoveredTabIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final isTabletScreen = ResponsiveBreakpoints.isTablet(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 40 : isTabletScreen ? 60 : 80,
        horizontal: padding,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.metallicGradient,
      ),
      child: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: isSmallScreen ? 40 : 60),
          if (isSmallScreen) 
              _buildMobileLayout(context)
          else if (isTabletScreen)
              _buildTabletLayout(context)
          else
              _buildDesktopLayout(context),
        ],
      ),
    );
  }

 Widget _buildHeader(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
  
  return Column(
    children: [
      Text(
        'Our Services & Capabilities',
        style: TextStyle(
          fontSize: ScreenUtils.getResponsiveFontSize(context, isSmallScreen ? 32 : 36),
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextColor,
          letterSpacing: 0.5,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
      
      Container(
        margin: const EdgeInsets.only(top: 12, bottom: 24),
        width: isSmallScreen ? 240 : 300,
        height: 2.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.sapphire.withOpacity(0.0),
              AppColors.sapphire,
              AppColors.sapphire.withOpacity(0.0),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(1.25),
        ),
      ),
      
      Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.darkTextColor.withOpacity(0.7),
              AppColors.sapphire,
              AppColors.darkTextColor.withOpacity(0.7),
            ],
            stops: const [0.1, 0.5, 0.9],
          ).createShader(bounds),
          child: Text(
            'Discover our comprehensive range of laser engraving and marking solutions',
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
              fontWeight: FontWeight.w500,
              color: Colors.white, 
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
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
            itemBuilder: (context, index) => _buildFeatureTab(index, isMobile: true),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
        const SizedBox(height: 30),
        _buildFeatureContent(context, isMobile: true),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: List.generate(
            features.length,
            (index) => _buildFeatureTab(index, isTablet: true),
          ),
        ),
        const SizedBox(height: 30),
        _buildFeatureContent(context, isTablet: true),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 320, 
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 540,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: List.generate(
                        features.length,
                        (index) => _buildFeatureTab(index),
                      ),
                    ),
                  );
                }
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _buildFeatureContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTab(int index, {bool isMobile = false, bool isTablet = false}) {
    final isSelected = index == _selectedFeatureIndex;
    final horizontalPadding = isMobile ? 16.0 : isTablet ? 18.0 : 24.0;
    final verticalPadding = isMobile ? 12.0 : isTablet ? 14.0 : 16.0;
    final iconSize = isMobile ? 20.0 : 24.0;
    final fontSize = isMobile ? 13.0 : isTablet ? 14.0 : 15.0;
    
    return MouseRegion(
      onEnter: (_) => setState(() {
        _hoveredTabIndex = index;
      }),
      onExit: (_) => setState(() {
        _hoveredTabIndex = -1;
      }),
      child: AnimatedScale(
        scale: (!isMobile && _hoveredTabIndex == index) ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: isMobile ? 2 : isTablet ? 3 : 4,
            horizontal: isMobile ? 4 : 0,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _selectedFeatureIndex = index),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
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
                      size: iconSize,
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    Flexible(
                      child: Text(
                        features[index].title,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: isSelected 
                              ? AppColors.lightTextColor 
                              : AppColors.darkTextColor.withOpacity(0.7),
                          fontWeight: isSelected 
                              ? FontWeight.bold 
                              : FontWeight.normal,
                        ),
                        overflow: isMobile ? TextOverflow.ellipsis : TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureContent(BuildContext context, {bool isMobile = false, bool isTablet = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final feature = features[_selectedFeatureIndex];
    
    final contentPadding = isMobile ? 16.0 : isTablet ? 24.0 : 32.0;
    final titleSize = isMobile ? 20.0 : isTablet ? 22.0 : 24.0;
    final descriptionSize = isMobile ? 14.0 : 16.0;
    final iconSize = isMobile ? 24.0 : isTablet ? 26.0 : 28.0;
    
    return ResponsiveFeatureCard(
      child: Container(
        padding: EdgeInsets.all(contentPadding),
        decoration: BoxDecoration(
          color: AppColors.pearl,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(isMobile ? 10 : 12),
                    decoration: BoxDecoration(
                      color: AppColors.sapphire.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      feature.icon,
                      size: iconSize,
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
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feature.description,
                          style: TextStyle(
                            fontSize: descriptionSize,
                            color: AppColors.darkTextColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: isMobile ? 24 : 32),
              
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: isMobile ? 200 : isTablet ? 260 : 300,
                  width: double.infinity,
                  child: Image.asset(
                    feature.imageUrl,
                    fit: BoxFit.cover, 
                    alignment: Alignment.center, 
                  ),
                ),
              ),
              
              SizedBox(height: isMobile ? 24 : 32),

              Text(
                'Key Capabilities:',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              
              const SizedBox(height: 16),

              _buildCapabilitiesWrap(feature.capabilities, screenWidth),
              
              const SizedBox(height: 32),
              
              SizedBox(
                width: isMobile ? double.infinity : null,
                child: ElevatedButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCapabilitiesWrap(List<String> capabilities, double screenWidth) {
    final isMobile = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: capabilities.map((capability) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
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
              Icon(
                Icons.check_circle_outline,
                size: isMobile ? 14 : 16,
                color: AppColors.sapphire,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  capability,
                  style: TextStyle(
                    color: AppColors.darkTextColor,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ResponsiveFeatureCard extends StatefulWidget {
  final Widget child;
  const ResponsiveFeatureCard({super.key, required this.child});

  @override
  _ResponsiveFeatureCardState createState() => _ResponsiveFeatureCardState();
}

class _ResponsiveFeatureCardState extends State<ResponsiveFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

    return MouseRegion(
      onEnter: isSmallScreen ? null : (_) => setState(() => _isHovered = true),
      onExit: isSmallScreen ? null : (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: (!isSmallScreen && _isHovered) ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(_isHovered ? 0.2 : 0.1),
                blurRadius: _isHovered ? 15 : 10,
                offset: Offset(0, _isHovered ? 6 : 4),
                spreadRadius: _isHovered ? 1 : 0,
              ),
              if (_isHovered && !isSmallScreen)
                BoxShadow(
                  color: AppColors.sapphire.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}