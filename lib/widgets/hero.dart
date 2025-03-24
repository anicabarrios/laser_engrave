import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';
import '../config/responsive_breakpoints.dart';
import '../widgets/grid_pattern_painter.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget>? actions;
  final Widget? additionalContent;
  final bool showAnimatedLogo;
  final double? customHeight;

  const HeroSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions,
    this.additionalContent,
    this.showAnimatedLogo = true,
    this.customHeight,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

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

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
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
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      height: widget.customHeight ?? (isSmallScreen ? 350 : 450),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                    Colors.white.withOpacity(0.1),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.showAnimatedLogo) ...[
                      _buildAnimatedLogo(isSmallScreen),
                      SizedBox(height: isSmallScreen ? 16 : 24),
                    ],

                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: ScreenUtils.getResponsiveFontSize(
                                context,
                                isSmallScreen ? 36 : 40,
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
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                  
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: isSmallScreen ? 6 : 8,
                        ),
                        child: Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: ScreenUtils.getResponsiveFontSize(
                              context,
                              isSmallScreen ? 16 : 18,
                            ),
                            color: AppColors.lightTextColor.withOpacity(0.9),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    if (widget.actions != null && widget.actions!.isNotEmpty) ...[
                      SizedBox(height: isSmallScreen ? 20 : 24),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: widget.actions!,
                          ),
                        ),
                      ),
                    ],

                    if (widget.additionalContent != null) ...[
                      SizedBox(height: isSmallScreen ? 20 : 24),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: widget.additionalContent!,
                      ),
                    ],
                  ],
                ),
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
            padding: EdgeInsets.all(isSmallScreen ? 22 : 20),
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
              size: isSmallScreen ? 48 : 48,
              color: AppColors.sapphire,
            ),
          ),
        );
      },
    );
  }
}