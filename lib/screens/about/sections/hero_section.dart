import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

    return Container(
      height: isSmallScreen ? 400 : 600,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Stack(
        children: [
          // Grid pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          
          // Main content
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtils.getResponsivePadding(context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated logo
                  _buildAnimatedLogo(isSmallScreen),
                  const SizedBox(height: 40),
                  
                  // Animated title
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        'Our Story of Innovation',
                        style: TextStyle(
                          fontSize: ScreenUtils.getResponsiveFontSize(
                            context,
                            isSmallScreen ? 36 : 48,
                          ),
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightTextColor,
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Animated subtitle
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: AppColors.aquamarine,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Crafting Excellence Since 2023',
                        style: TextStyle(
                          fontSize: ScreenUtils.getResponsiveFontSize(
                            context,
                            isSmallScreen ? 18 : 24,
                          ),
                          color: AppColors.lightTextColor.withOpacity(0.9),
                          letterSpacing: 0.5,
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

  Widget _buildAnimatedLogo(bool isSmallScreen) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.metallicGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.sapphire.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Icon(
              Icons.precision_manufacturing,
              size: isSmallScreen ? 48 : 64,
              color: AppColors.sapphire,
            ),
          ),
        );
      },
    );
  }
}

class GridPatternPainter extends CustomPainter {
  final Color color;

  GridPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const spacing = 30.0;

    for (var i = 0; i < size.width; i += spacing.toInt()) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }

    for (var i = 0; i < size.height; i += spacing.toInt()) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) => false;
}