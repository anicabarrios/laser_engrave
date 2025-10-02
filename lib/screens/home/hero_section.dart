import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';
import '../../../widgets/grid_pattern_painter.dart';
import 'dart:math' as math;

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.02),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final isMediumScreen = ResponsiveBreakpoints.isTablet(screenWidth);
    final isTouchDevice = Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.android;

    return SizedBox(
      height: screenHeight,
      width: double.infinity,
      child: Stack(
        children: [
          _buildBackground(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtils.getResponsivePadding(context),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildMainContent(
                        isSmallScreen, isMediumScreen, isTouchDevice),
                    SizedBox(height: isSmallScreen ? 40 : 60),
                    _buildStatsBadges(isSmallScreen, isMediumScreen),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
              AppColors.darkColor,
            ],
          ),
        ),
        child: CustomPaint(
          painter: GridPatternPainter(
            color: Colors.white.withOpacity(0.05),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(
      bool isSmallScreen, bool isMediumScreen, bool isTouchDevice) {
    if (!isSmallScreen && !isMediumScreen) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                flex: 5,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Center(
                      child: _buildContentWithoutAnimations(isSmallScreen),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isMediumScreen ? 20 : 60),
              Expanded(
                flex: 4,
                child: isTouchDevice
                    ? _buildShowcaseWithoutAnimations()
                    : _buildAnimatedShowcase(),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        // Left side content
        Expanded(
          flex: isSmallScreen ? 1 : 2,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.only(
                  left: isSmallScreen
                      ? 0
                      : isMediumScreen
                          ? 40
                          : 100,
                ),
                child: _buildContentWithoutAnimations(isSmallScreen),
              ),
            ),
          ),
        ),

        // Right side animated content (only on larger screens)
        if (!isSmallScreen) ...[
          SizedBox(width: isMediumScreen ? 20 : 40),
          Expanded(
            flex: 2,
            child: isTouchDevice
                ? _buildShowcaseWithoutAnimations()
                : _buildAnimatedShowcase(),
          ),
        ],
      ],
    );
  }

  Widget _buildContentWithoutAnimations(bool isSmallScreen) {
    return Column(
      crossAxisAlignment:
          isSmallScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          isSmallScreen
              ? 'Revolutionary\nLaser Engraving'
              : 'Revolutionary\nLaser Engraving',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(
              context,
              isSmallScreen ? 38 : 48,
            ),
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextColor,
            height: 1.2,
          ),
          textAlign: isSmallScreen ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 20),
        Text(
          'Precision engineering meets artistic excellence',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(
              context,
              isSmallScreen ? 18 : 20,
            ),
            color: AppColors.lightTextColor.withOpacity(0.9),
            height: 1.5,
          ),
          textAlign: isSmallScreen ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: isSmallScreen ? 24 : 32),
        FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 0.9, curve: Curves.easeInOut),
          )),
          child: isSmallScreen
              ? Center(child: _buildActionButtons(isSmallScreen))
              : _buildActionButtons(isSmallScreen),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isSmallScreen) {
    final btnPadding = isSmallScreen
        ? const EdgeInsets.symmetric(horizontal: 30, vertical: 18)
        : const EdgeInsets.symmetric(horizontal: 32, vertical: 20);

    final btnFontSize = isSmallScreen ? 17.0 : 15.0;

    return Wrap(
      spacing: isSmallScreen ? 12 : 16,
      runSpacing: isSmallScreen ? 12 : 16,
      alignment: isSmallScreen ? WrapAlignment.center : WrapAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/contact'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
            foregroundColor: AppColors.lightTextColor,
            padding: btnPadding,
            minimumSize: isSmallScreen ? const Size(230, 55) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Start Your Project',
            style: TextStyle(
              fontSize: btnFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, '/gallery'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.lightTextColor,
            side: const BorderSide(color: AppColors.lightTextColor, width: 1.5),
            padding: btnPadding,
            minimumSize: isSmallScreen ? const Size(230, 55) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'View Gallery',
            style: TextStyle(
              fontSize: btnFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShowcaseWithoutAnimations() {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(3, (index) {
              final size = 200.0 + (index * 40);
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        AppColors.accentColor.withOpacity(0.3 - (index * 0.1)),
                    width: 2,
                  ),
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.precision_manufacturing,
                size: 48,
                color: AppColors.lightTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedShowcase() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final rotationValue = _controller.value * (math.pi / 4);
        final scale = 1.0 + (math.sin(_controller.value * math.pi) * 0.05);

        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.scale(
            scale: scale,
            child: Transform.rotate(
              angle: rotationValue,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(3, (index) {
                    final size = 200.0 + (index * 40);
                    return Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accentColor
                              .withOpacity(0.3 - (index * 0.1)),
                          width: 2,
                        ),
                      ),
                    );
                  }),
                  Transform.rotate(
                    angle: -rotationValue,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.accentColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.precision_manufacturing,
                        size: 48,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsBadges(bool isSmallScreen, bool isTabletScreen) {
    final stats = [
      {
        'icon': Icons.precision_manufacturing,
        'label': 'Precision: 0.01mm Accuracy',
      },
      {
        'icon': Icons.speed,
        'label': 'Turnaround: 24 Hour Service',
      },
      {
        'icon': Icons.verified,
        'label': 'Quality: ISO 9001:2015',
      },
    ];

    final containerWidth = isSmallScreen
        ? MediaQuery.of(context).size.width * 0.9
        : isTabletScreen
            ? MediaQuery.of(context).size.width * 0.85
            : MediaQuery.of(context).size.width * 0.7;

    return Container(
      width: containerWidth,
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 14 : 16,
        horizontal: isSmallScreen ? 18 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: isSmallScreen
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: stats.map((stat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          stat['icon'] as IconData,
                          color: AppColors.accentColor,
                          size: 24,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          stat['label'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            : Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 16,
                runSpacing: 12,
                children: stats.map((stat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          stat['icon'] as IconData,
                          color: AppColors.accentColor,
                          size: isTabletScreen ? 20 : 22,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          stat['label'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTabletScreen ? 15 : 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
