import 'package:flutter/material.dart';
import 'package:laser_engrave/config/responsive_breakpoints.dart';
import 'package:laser_engrave/utils/colors.dart';
import 'package:laser_engrave/utils/screen_utils.dart';
import 'package:laser_engrave/widgets/grid_pattern_painter.dart';


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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.pearl,
            AppColors.pearl.withOpacity(0.95),
            AppColors.platinum.withOpacity(0.9),
          ],
          stops: const [0.0, 0.3, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: AppColors.sapphire.withOpacity(0.08),
              ),
            ),
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  // Enhanced header section with consistent styling
                  _buildHeader(context),
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
        ],
      ),
    );
  }

  // New enhanced header matching other sections
  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return Column(
      children: [
        // Title text
        Text(
          'Our Technology',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, isSmallScreen ? 32 : 36),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
            letterSpacing: 0.5,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        
        // Decorative divider for title
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
        
        // Subtitle with text-only color transition effect
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
              'State-of-the-Art Equipment & Capabilities',
              style: TextStyle(
                fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                fontWeight: FontWeight.w500,
                color: Colors.white, // The ShaderMask will override this
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _TechnologyCard extends StatefulWidget {
  final Map<String, dynamic> tech;

  const _TechnologyCard({required this.tech});

  @override
  State<_TechnologyCard> createState() => _TechnologyCardState();
}

class _TechnologyCardState extends State<_TechnologyCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(24),
        // Apply a slight scale transform when hovered.
        transform: Matrix4.identity()..scale(isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // Change gradient based on hover state
          gradient: isHovered
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.pearl,
                    AppColors.pearl.withOpacity(0.98),
                    AppColors.platinum.withOpacity(0.95),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.pearl,
                    AppColors.pearl.withOpacity(0.95),
                    AppColors.platinum.withOpacity(0.9),
                  ],
                  stops: const [0.0, 0.3, 1.0],
                ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppColors.sapphire.withOpacity(0.4)
                  : AppColors.darkColor.withOpacity(0.1),
              blurRadius: isHovered ? 20 : 10,
              offset: Offset(0, isHovered ? 8 : 4),
              spreadRadius: isHovered ? 2 : 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with icon and technology details.
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.sapphire.withOpacity(0.15),
                        AppColors.aquamarine.withOpacity(0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sapphire.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.7),
                        blurRadius: 8,
                        spreadRadius: -2,
                        offset: const Offset(-2, -2),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.tech['icon'],
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
                        widget.tech['name'],
                        style: TextStyle(
                          fontSize:
                              ScreenUtils.getResponsiveFontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkTextColor,
                        ),
                      ),
                      Text(
                        widget.tech['type'],
                        style: TextStyle(
                          fontSize:
                              ScreenUtils.getResponsiveFontSize(context, 14),
                          color: AppColors.sapphire,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Layout adjustment based on screen size.
            if (!isSmallScreen)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildDescription(context, widget.tech),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _buildSpecifications(context, widget.tech),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDescription(context, widget.tech),
                  const SizedBox(height: 16),
                  _buildSpecifications(context, widget.tech),
                ],
              ),
          ],
        ),
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
        ...tech['specifications'].map<Widget>(
          (spec) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppColors.sapphire,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    spec,
                    style: TextStyle(
                      fontSize:
                          ScreenUtils.getResponsiveFontSize(context, 14),
                      color: AppColors.darkTextColor.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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