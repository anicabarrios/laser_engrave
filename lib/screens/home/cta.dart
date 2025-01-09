import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

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
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Text(
                  'Ready to Transform Your Ideas?',
                  style: TextStyle(
                    fontSize: ScreenUtils.getResponsiveFontSize(
                      context,
                      isSmallScreen ? 32 : 42,
                    ),
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightTextColor,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Get in touch with us today and let our expert team bring your vision to life with precision and excellence.',
                  style: TextStyle(
                    fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                    color: AppColors.lightTextColor.withOpacity(0.9),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildContactOptions(context, isSmallScreen),
              ],
            ),
          ),
          if (!isSmallScreen) ...[
            const SizedBox(height: 80),
            _buildQuickLinks(context),
          ],
        ],
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context, bool isSmallScreen) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return isSmallScreen
        ? Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/contact'),
                  icon: const Icon(Icons.send),
                  label: const Text('Start Your Project'),
                  style: buttonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(AppColors.accentColor),
                    foregroundColor: MaterialStateProperty.all(AppColors.lightTextColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Launch phone call
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Call Us Now'),
                  style: buttonStyle.copyWith(
                    foregroundColor: MaterialStateProperty.all(AppColors.lightTextColor),
                    side: MaterialStateProperty.all(
                      BorderSide(color: AppColors.lightTextColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                icon: const Icon(Icons.send),
                label: const Text('Start Your Project'),
                style: buttonStyle.copyWith(
                  backgroundColor: MaterialStateProperty.all(AppColors.accentColor),
                  foregroundColor: MaterialStateProperty.all(AppColors.lightTextColor),
                ),
              ),
              const SizedBox(width: 20),
              OutlinedButton.icon(
                onPressed: () {
                  // Launch phone call
                },
                icon: const Icon(Icons.phone),
                label: const Text('Call Us Now'),
                style: buttonStyle.copyWith(
                  foregroundColor: MaterialStateProperty.all(AppColors.lightTextColor),
                  side: MaterialStateProperty.all(
                    BorderSide(color: AppColors.lightTextColor),
                  ),
                ),
              ),
            ],
          );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.lightTextColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildQuickLink(
            context,
            'View Our Services',
            Icons.design_services,
            '/services',
          ),
          const SizedBox(width: 40),
          _buildQuickLink(
            context,
            'Explore Gallery',
            Icons.photo_library,
            '/gallery',
          ),
          const SizedBox(width: 40),
          _buildQuickLink(
            context,
            'About Us',
            Icons.info,
            '/about',
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLink(
    BuildContext context,
    String text,
    IconData icon,
    String route,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.lightTextColor.withOpacity(0.7),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: AppColors.lightTextColor.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}