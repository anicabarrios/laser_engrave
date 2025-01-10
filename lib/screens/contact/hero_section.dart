import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/grid_pattern_painter.dart';

class HeroSection extends StatelessWidget {
  final bool isSmallScreen;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const HeroSection({
    Key? key,
    required this.isSmallScreen,
    required this.fadeAnimation,
    required this.slideAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSmallScreen ? 300 : 400,
      decoration: BoxDecoration(gradient: AppColors.premiumDarkGradient),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(color: Colors.white.withOpacity(0.05)),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtils.getResponsivePadding(context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: Text(
                        'Let\'s Create Something Amazing',
                        style: TextStyle(
                          fontSize: ScreenUtils.getResponsiveFontSize(
                            context,
                            isSmallScreen ? 32 : 48,
                          ),
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightTextColor,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: AppColors.sapphire, width: 3),
                        ),
                      ),
                      child: Text(
                        'Share your vision, and we\'ll bring it to life with precision',
                        style: TextStyle(
                          fontSize: ScreenUtils.getResponsiveFontSize(
                            context,
                            isSmallScreen ? 16 : 20,
                          ),
                          color: AppColors.lightTextColor.withOpacity(0.9),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
}
