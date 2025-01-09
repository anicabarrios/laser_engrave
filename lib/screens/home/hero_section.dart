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

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
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
    final isMediumScreen = ResponsiveBreakpoints.isTablet(screenWidth);

    return Stack(
      children: [
        // Background with gradient and pattern
        _buildBackground(),
        
        // Main content
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.getResponsivePadding(context),
          ),
          child: Column(
            children: [
              SizedBox(height: isSmallScreen ? 80 : 100),
              _buildMainContent(isSmallScreen, isMediumScreen),
              const SizedBox(height: 60),
              _buildStatsCards(isSmallScreen),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          height: 700,
          decoration: BoxDecoration(
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
        ),
        // Animated pattern overlay
        Positioned.fill(
          child: CustomPaint(
            painter: GridPatternPainter(
              color: Colors.white.withOpacity(0.05),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(bool isSmallScreen, bool isMediumScreen) {
    return Row(
      children: [
        // Left side content
        Expanded(
          flex: isSmallScreen ? 1 : 2,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revolutionary\nLaser Engraving',
                    style: TextStyle(
                      fontSize: ScreenUtils.getResponsiveFontSize(
                        context,
                        isSmallScreen ? 36 : 48,
                      ),
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightTextColor,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Precision engineering meets artistic excellence',
                    style: TextStyle(
                      fontSize: ScreenUtils.getResponsiveFontSize(
                        context,
                        isSmallScreen ? 16 : 20,
                      ),
                      color: AppColors.lightTextColor.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
        
        // Right side animated content
        if (!isSmallScreen) ...[
          const SizedBox(width: 40),
          Expanded(
            flex: 2,
            child: _buildAnimatedShowcase(),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/contact'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
            foregroundColor: AppColors.lightTextColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Start Your Project'),
        ),
        OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, '/gallery'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.lightTextColor,
            side: BorderSide(color: AppColors.lightTextColor),
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('View Gallery'),
        ),
      ],
    );
  }

  Widget _buildAnimatedShowcase() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating rings
              ...List.generate(3, (index) {
                final size = 200.0 + (index * 40);
                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accentColor.withOpacity(0.3 - (index * 0.1)),
                      width: 2,
                    ),
                  ),
                );
              }),
              // Center icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.accentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.precision_manufacturing,
                  size: 48,
                  color: AppColors.lightTextColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsCards(bool isSmallScreen) {
    final stats = [
      {
        'icon': Icons.precision_manufacturing,
        'title': 'Precision',
        'value': '0.01mm Accuracy'
      },
      {
        'icon': Icons.speed,
        'title': 'Turnaround',
        'value': '24 Hour Service'
      },
      {
        'icon': Icons.verified,
        'title': 'Quality',
        'value': 'ISO 9001:2015'
      },
    ];

    return Container(
      transform: Matrix4.translationValues(0, -30, 0),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: stats.map((stat) => _buildStatCard(stat, isSmallScreen)).toList(),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, bool isSmallScreen) {
    return Container(
      width: isSmallScreen ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sapphire.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              stat['icon'] as IconData,
              color: AppColors.sapphire,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat['title'] as String,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stat['value'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.sapphire,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

    for (var i = 0; i < size.width; i += spacing as int) {
      canvas.drawLine(
        Offset(i as double, 0),
        Offset(i as double, size.height),
        paint,
      );
    }

    for (var i = 0; i < size.height; i += spacing as int) {
      canvas.drawLine(
        Offset(0, i as double),
        Offset(size.width, i as double),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) => false;
}