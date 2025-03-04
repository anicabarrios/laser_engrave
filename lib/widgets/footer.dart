import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';
import '../../config/responsive_breakpoints.dart';
import '../../config/app_config.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final isTabletScreen = ResponsiveBreakpoints.isTablet(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: isSmallScreen ? 40 : 60,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  children: [
                    if (isSmallScreen)
                      _buildMobileContent(context)
                    else if (isTabletScreen)
                      _buildTabletContent(context)
                    else
                      _buildDesktopContent(context),
                    SizedBox(height: isSmallScreen ? 30 : 40),
                    _buildDivider(),
                    SizedBox(height: isSmallScreen ? 20 : 24),
                    _buildBottomBar(context, isSmallScreen),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _buildCompanyInfo(true)),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildQuickLinks(context)),
            Expanded(child: _buildServices(context)),
          ],
        ),
        const SizedBox(height: 40),
        _buildContact(),
      ],
    );
  }
  
  Widget _buildTabletContent(BuildContext context) {
    return Column(
      children: [
        _buildCompanyInfo(false),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildQuickLinks(context)),
            Expanded(child: _buildServices(context)),
            Expanded(child: _buildContact()),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildCompanyInfo(false),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 2,
          child: _buildQuickLinks(context),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 2,
          child: _buildServices(context),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 3,
          child: _buildContact(),
        ),
      ],
    );
  }

  Widget _buildCompanyInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.sapphire.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.precision_manufacturing,
                size: 32,
                color: AppColors.sapphire,
              ),
              SizedBox(width: 12),
              Text(
                AppConfig.appName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Precision engineering meets artistic excellence in every project we undertake. Your vision, our expertise.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            height: 1.6,
            fontSize: 16,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _buildSocialIcon(Icons.facebook, 'Facebook'),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.camera_alt_outlined, 'Instagram'),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.connect_without_contact_outlined, 'LinkedIn'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumnHeader('Quick Links'),
        const SizedBox(height: 20),
        _buildFooterLink(context, 'Home', '/'),
        _buildFooterLink(context, 'About Us', '/about'),
        _buildFooterLink(context, 'Gallery', '/gallery'),
        _buildFooterLink(context, 'Contact', '/contact'),
      ],
    );
  }

  Widget _buildServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumnHeader('Our Services'),
        const SizedBox(height: 20),
        // Map services to specific gallery categories
        _buildServiceGalleryLink(context, 'Custom Engraving', 'Wood Engraving'),
        _buildServiceGalleryLink(context, 'Industrial Marking', 'Metal'),
        _buildServiceGalleryLink(context, 'Corporate Solutions', 'Corporate'),
        _buildServiceGalleryLink(context, 'Artistic Services', 'Artistic'),
      ],
    );
  }

  Widget _buildContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumnHeader('Get in Touch'),
        const SizedBox(height: 20),
        _buildContactInfo(Icons.location_on_outlined, AppConfig.address),
        const SizedBox(height: 16),
        _buildContactInfo(Icons.phone_outlined, AppConfig.contactPhone),
        const SizedBox(height: 16),
        _buildContactInfo(Icons.email_outlined, AppConfig.contactEmail),
      ],
    );
  }

  Widget _buildColumnHeader(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.sapphire,
                AppColors.sapphire.withOpacity(0.5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_forward,
              size: 16,
              color: AppColors.sapphire,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceGalleryLink(BuildContext context, String serviceName, String category) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // Navigate to gallery with the specific category pre-selected
          Navigator.pushNamed(
            context, 
            '/gallery',
            arguments: {'selectedCategory': category}
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_forward,
              size: 16,
              color: AppColors.sapphire,
            ),
            const SizedBox(width: 8),
            Text(
              serviceName,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.sapphire.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.sapphire,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 15,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.sapphire.withOpacity(0.1),
        border: Border.all(
          color: AppColors.sapphire.withOpacity(0.2),
        ),
      ),
      child: Icon(
        icon,
        size: 20,
        color: AppColors.sapphire,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, bool isSmallScreen) {
    final currentYear = DateTime.now().year;

    return SizedBox(
      width: double.infinity,
      child: isSmallScreen
          ? Column(
              children: [
                Text(
                  '© $currentYear ${AppConfig.appName}. All rights reserved.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBottomLink(context, 'Privacy Policy', '/privacy'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '•',
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                    _buildBottomLink(context, 'Terms of Service', '/terms'),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© $currentYear ${AppConfig.appName}. All rights reserved.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                ),
                Row(
                  children: [
                    _buildBottomLink(context, 'Privacy Policy', '/privacy'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '•',
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                    _buildBottomLink(context, 'Terms of Service', '/terms'),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildBottomLink(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}