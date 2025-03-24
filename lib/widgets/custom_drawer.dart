import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../config/app_config.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: DecoratedBox(
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
        ),
        child: Stack(
          children: [
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
            Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white,
                          Colors.white.withOpacity(0.9),
                        ],
                        stops: const [0.0, 0.9, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: _buildDrawerContent(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: isSelected ? AppColors.luxuryAccentGradient : null,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.darkColor.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppColors.lightTextColor : AppColors.sapphire,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color:
                isSelected ? AppColors.lightTextColor : AppColors.darkTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.pushNamed(context, route);
        },
        tileColor: Colors.transparent,
        hoverColor: AppColors.sapphire.withOpacity(0.05),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: AppColors.platinum.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildLogoContainer(),
          const SizedBox(height: 16),
          const Text(
            AppConfig.appName,
            style: TextStyle(
              color: AppColors.darkTextColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.sapphire.withOpacity(0.15),
            AppColors.aquamarine.withOpacity(0.15),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.sapphire.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: const Icon(
        Icons.precision_manufacturing,
        size: 44,
        color: AppColors.sapphire,
      ),
    );
  }

  Widget _buildDrawerContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _buildNavigationSection(context),
        _buildDivider(),
        _buildContactSection(),
        const SizedBox(height: 24),
        _buildSocialSection(),
      ],
    );
  }

  Widget _buildNavigationSection(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Column(
      children: [
        _buildDrawerItem(
          context,
          icon: Icons.home_outlined,
          title: 'Home',
          route: '/',
          isSelected: currentRoute == '/',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.info_outline,
          title: 'About',
          route: '/about',
          isSelected: currentRoute == '/about',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.photo_library_outlined,
          title: 'Gallery',
          route: '/gallery',
          isSelected: currentRoute == '/gallery',
        ),
        _buildDrawerItem(
          context,
          icon: Icons.contact_mail_outlined,
          title: 'Contact',
          route: '/contact',
          isSelected: currentRoute == '/contact',
        ),
        
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.titanium.withOpacity(0.1),
              AppColors.titanium.withOpacity(0.3),
              AppColors.titanium.withOpacity(0.1),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.pearl.withOpacity(0.5),
            AppColors.platinum.withOpacity(0.3),
          ],
        ),
        border: Border.all(
          color: AppColors.platinum.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.contact_support_outlined,
                size: 20,
                color: AppColors.sapphire,
              ),
              SizedBox(width: 8),
              Text(
                'Contact Information',
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            icon: Icons.phone_outlined,
            text: AppConfig.contactPhone,
          ),
          _buildContactItem(
            icon: Icons.email_outlined,
            text: AppConfig.contactEmail,
          ),
          _buildContactItem(
            icon: Icons.location_on_outlined,
            text: AppConfig.address.split('\n')[0],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.sapphire.withOpacity(0.8),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.darkTextColor.withOpacity(0.8),
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialButton(Icons.facebook, 'Facebook'),
          _buildSocialButton(Icons.camera_alt_outlined, 'Instagram'),
          _buildSocialButton(
              Icons.connect_without_contact_outlined, 'LinkedIn'),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String platform) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.pearl.withOpacity(0.9),
            AppColors.platinum.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 20,
        color: AppColors.sapphire,
      ),
    );
  }
}