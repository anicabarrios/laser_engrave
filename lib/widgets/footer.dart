import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';
import '../config/responsive_breakpoints.dart';
import '../config/app_config.dart';

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
              vertical: isSmallScreen ? 40 : isTabletScreen ? 50 : 60,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildCompanyInfo(true),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildQuickLinks(context),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildServices(context),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildContact(),
                ),
              ),
            ],
          ),
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

  Widget _buildCompanyInfo(bool isCentered) {
    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
                size: 28, 
                color: AppColors.sapphire,
              ),
              SizedBox(width: 8), 
              Flexible(
                child: Text(
                  AppConfig.appName,
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
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
          textAlign: isCentered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
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
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 36,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.arrow_forward,
              size: 14, 
              color: AppColors.sapphire,
            ),
            const SizedBox(width: 6), 
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14, 
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
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
          Navigator.pushNamed(
            context, 
            '/gallery',
            arguments: {'selectedCategory': category}
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.arrow_forward,
              size: 14, 
              color: AppColors.sapphire,
            ),
            const SizedBox(width: 6), 
            Flexible(
              child: Text(
                serviceName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
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
          padding: const EdgeInsets.all(6), 
          decoration: BoxDecoration(
            color: AppColors.sapphire.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16, 
            color: AppColors.sapphire,
          ),
        ),
        const SizedBox(width: 8), 
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14, 
              height: 1.4,
              letterSpacing: 0.2,
            ),
            overflow: TextOverflow.visible, 
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform) {
    return Container(
      padding: const EdgeInsets.all(10), 
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.sapphire.withOpacity(0.1),
        border: Border.all(
          color: AppColors.sapphire.withOpacity(0.2),
          width: 1, 
        ),
      ),
      child: Icon(
        icon,
        size: 18, 
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
      child: Center(
        child: Text(
          '© $currentYear ${AppConfig.appName} All rights reserved.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}