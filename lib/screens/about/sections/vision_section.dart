import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';

class VisionSection extends StatelessWidget {
  const VisionSection({super.key});

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
        gradient: AppColors.metallicGradient,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              if (!isSmallScreen)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _buildVisionContent(context)),
                    const SizedBox(width: 60),
                    Expanded(child: _buildStatsGrid(context)),
                  ],
                )
              else
                Column(
                  children: [
                    _buildVisionContent(context),
                    const SizedBox(height: 40),
                    _buildStatsGrid(context),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisionContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.sapphire.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Our Vision',
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
              fontWeight: FontWeight.bold,
              color: AppColors.sapphire,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Setting New Standards in Precision Engineering',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 32),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
            height: 1.2,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'We combine cutting-edge technology with masterful craftsmanship to deliver exceptional results that consistently exceed expectations. Our commitment to innovation and excellence drives everything we do.',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 16),
            color: AppColors.darkTextColor.withOpacity(0.8),
            height: 1.6,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.sapphire.withOpacity(0.05),
            AppColors.aquamarine.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: AppColors.platinum.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: _StatItem(
                  value: '500+',
                  label: 'Projects\nCompleted',
                  icon: Icons.check_circle_outline,
                ),
              ),
              Expanded(
                child: _StatItem(
                  value: '200+',
                  label: 'Happy\nClients',
                  icon: Icons.people_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: const [
              Expanded(
                child: _StatItem(
                  value: '50+',
                  label: 'Material\nTypes',
                  icon: Icons.category_outlined,
                ),
              ),
              Expanded(
                child: _StatItem(
                  value: '99%',
                  label: 'Client\nSatisfaction',
                  icon: Icons.thumb_up_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.sapphire.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: AppColors.sapphire,
            size: 24,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          value,
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
            color: AppColors.darkTextColor.withOpacity(0.7),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
