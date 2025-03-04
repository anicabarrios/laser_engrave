import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';
import '../../widgets/grid_pattern_painter.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final isTabletScreen = ResponsiveBreakpoints.isTablet(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        // Adjust vertical padding based on screen size
        vertical: isSmallScreen ? 40 : isTabletScreen ? 70 : 100,
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
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Grid pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: AppColors.sapphire.withOpacity(0.08),
              ),
            ),
          ),
          // Content
          Center(
            child: Container(
              constraints: BoxConstraints(
                // Adjust max width based on screen size
                maxWidth: isSmallScreen ? 450 : isTabletScreen ? 700 : 1200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: isSmallScreen ? 400 : isTabletScreen ? 600 : 800,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Ready to Transform Your Ideas?',
                          style: TextStyle(
                            fontSize: ScreenUtils.getResponsiveFontSize(
                              context,
                              isSmallScreen ? 28 : isTabletScreen ? 36 : 42,
                            ),
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                            letterSpacing: 0.5,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 12 : 20),
                        Text(
                          'Get in touch with us today and let our expert team bring your vision to life with precision and excellence.',
                          style: TextStyle(
                            fontSize: ScreenUtils.getResponsiveFontSize(
                              context, 
                              isSmallScreen ? 16 : 18
                            ),
                            color: AppColors.darkTextColor.withOpacity(0.8),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 24 : isTabletScreen ? 32 : 40),
                        _buildContactOptions(context, isSmallScreen, isTabletScreen),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context, bool isSmallScreen, bool isTabletScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 4 : 8
      ),
      child: isSmallScreen
          ? Column(
              children: [
                _buildPrimaryButton(context, isSmallScreen, isTabletScreen),
                const SizedBox(height: 16),
                _buildSecondaryButton(isSmallScreen, isTabletScreen),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPrimaryButton(context, isSmallScreen, isTabletScreen),
                SizedBox(width: isTabletScreen ? 16 : 20),
                _buildSecondaryButton(isSmallScreen, isTabletScreen),
              ],
            ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context, bool isSmallScreen, bool isTabletScreen) {
    final width = isSmallScreen
        ? double.infinity
        : isTabletScreen
            ? 220.0
            : null;
            
    final height = isSmallScreen ? 50.0 : isTabletScreen ? 54.0 : 56.0;
    
    final btnPadding = isSmallScreen
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 14)
        : isTabletScreen
            ? const EdgeInsets.symmetric(horizontal: 28, vertical: 15)
            : const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
            
    final fontSize = isSmallScreen ? 15.0 : 16.0;
    
    final iconSize = isSmallScreen ? 18.0 : 20.0;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.sapphire,
            AppColors.sapphire.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.sapphire.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, '/contact'),
        icon: Icon(Icons.send, size: iconSize),
        label: Text(
          'Start Your Project',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.lightTextColor,
          shadowColor: Colors.transparent,
          padding: btnPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(bool isSmallScreen, bool isTabletScreen) {
    final width = isSmallScreen
        ? double.infinity
        : isTabletScreen
            ? 220.0
            : null;
            
    final height = isSmallScreen ? 50.0 : isTabletScreen ? 54.0 : 56.0;
    
    final btnPadding = isSmallScreen
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 14)
        : isTabletScreen
            ? const EdgeInsets.symmetric(horizontal: 28, vertical: 15)
            : const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
            
    final fontSize = isSmallScreen ? 15.0 : 16.0;
    
    final iconSize = isSmallScreen ? 18.0 : 20.0;
    
    final borderWidth = isSmallScreen ? 1.5 : 2.0;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.sapphire,
          width: borderWidth,
        ),
      ),
      child: OutlinedButton.icon(
        onPressed: () {
          // Launch phone call
        },
        icon: Icon(Icons.phone, size: iconSize, color: AppColors.sapphire),
        label: Text(
          'Call Us Now',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.sapphire,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: btnPadding,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}