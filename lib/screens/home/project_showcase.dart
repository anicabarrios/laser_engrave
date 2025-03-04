import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';
import '../../../widgets/grid_pattern_painter.dart';

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
    final isTabletScreen = ResponsiveBreakpoints.isTablet(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 40 : 80,
        horizontal: padding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
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
          Column(
            children: [
              // Enhanced Section Header (matching FeaturesSection style)
              _buildHeader(context),
              
              const SizedBox(height: 60),
              
              // Responsive Project Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  if (isSmallScreen) {
                    // Mobile layout (1 column)
                    return Column(
                      children: projects.map((project) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: FractionallySizedBox(
                            // Making card 90% of available width on mobile
                            widthFactor: 0.9,
                            child: _buildProjectCard(context, project),
                          ),
                        );
                      }).toList(),
                    );
                  } else if (isTabletScreen) {
                    // Tablet layout (2 columns)
                    return Center(
                      child: SizedBox(
                        // Constrain the entire grid width to make cards smaller
                        width: constraints.maxWidth * 0.9,
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 30,
                          alignment: WrapAlignment.center,
                          children: projects.map((project) {
                            return SizedBox(
                              width: (constraints.maxWidth * 0.9 - 30) / 2,
                              child: _buildProjectCard(context, project),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    // Desktop layout (3 columns)
                    return Center(
                      child: SizedBox(
                        // Constrain the entire grid width to make cards smaller
                        width: constraints.maxWidth * 0.9,
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 30,
                          alignment: WrapAlignment.center,
                          children: projects.map((project) {
                            return SizedBox(
                              width: (constraints.maxWidth * 0.9 - 60) / 3,
                              child: _buildProjectCard(context, project),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
                },
              ),
              
              // View All Button
              const SizedBox(height: 40),
              _buildViewAllButton(isSmallScreen),
            ],
          ),
        ],
      ),
    );
  }

  // New enhanced header matching the FeaturesSection style
  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return Column(
      children: [
        // Title text
        Text(
          'Featured Projects',
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
              'Discover our latest work and innovative solutions',
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

  Widget _buildViewAllButton(bool isSmallScreen) {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigate to gallery page
      },
      icon: const Icon(Icons.photo_library),
      label: const Text('View All Projects'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.sapphire,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 24 : 32,
          vertical: isSmallScreen ? 16 : 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return HoverableProjectCard(
      builder: (context, isHovered) => Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image with slightly taller aspect ratio (less square)
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Stack(
                    children: [
                      // Image covering the full width and height
                      Positioned.fill(
                        child: Image.asset(
                          project['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Category badge
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
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.darkColor.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
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
                ),
                
                // Project Details (reduced padding)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title with color change on hover
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                          fontWeight: FontWeight.bold,
                          // Change color when hovered
                          color: isHovered ? AppColors.sapphire : AppColors.darkTextColor,
                        ),
                        child: Text(project['title']),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project['description'],
                        style: TextStyle(
                          fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                          color: AppColors.darkTextColor.withOpacity(0.7),
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HoverableProjectCard extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;
  
  const HoverableProjectCard({
    Key? key, 
    required this.builder,
  }) : super(key: key);

  @override
  _HoverableProjectCardState createState() => _HoverableProjectCardState();
}

class _HoverableProjectCardState extends State<HoverableProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(_isHovered ? 0.2 : 0.1),
                blurRadius: _isHovered ? 15 : 10,
                offset: const Offset(0, 4),
              ),
              if (_isHovered)
                BoxShadow(
                  color: AppColors.sapphire.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          // Pass the hover state to the builder function
          child: widget.builder(context, _isHovered),
        ),
      ),
    );
  }
}