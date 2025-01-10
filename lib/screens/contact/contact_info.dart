import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../utils/colors.dart';
import '../../widgets/grid_pattern_painter.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({Key? key}) : super(key: key);

  Widget _buildSectionTitle(String title, String subtitle, {bool light = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: light ? AppColors.lightTextColor : AppColors.darkTextColor,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: light 
              ? AppColors.lightTextColor.withOpacity(0.8)
              : AppColors.darkTextColor.withOpacity(0.7),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
    bool isClickable = false,
    bool light = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sapphire.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
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
                  blurRadius: 8,
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
            child: Icon(
              icon,
              size: 24,
              color: AppColors.sapphire,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkTextColor,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    color: AppColors.darkTextColor.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          if (isClickable)
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.sapphire.withOpacity(0.5),
            ),
        ],
      ),
    );
  }

  Widget _buildBusinessHoursContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.sapphire.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
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
                      blurRadius: 8,
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
                child: Icon(
                  Icons.access_time,
                  size: 24,
                  color: AppColors.sapphire,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Business Hours',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkTextColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTimeRow('Monday - Friday', '9:00 AM - 6:00 PM'),
          _buildTimeRow('Saturday', '10:00 AM - 4:00 PM'),
          _buildTimeRow('Sunday', 'Closed'),
        ],
      ),
    );
  }

  Widget _buildTimeRow(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(
              color: AppColors.darkTextColor.withOpacity(0.8),
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
          Text(
            hours,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.darkTextColor,
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinksGlass() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Us',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.darkTextColor,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSocialIconGlass(Icons.facebook, 'Facebook'),
            const SizedBox(width: 16),
            _buildSocialIconGlass(Icons.camera_alt_outlined, 'Instagram'),
            const SizedBox(width: 16),
            _buildSocialIconGlass(Icons.connect_without_contact_outlined, 'LinkedIn'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIconGlass(IconData icon, String label) {
    return Tooltip(
      message: label,
      child: Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 840,
      padding: const EdgeInsets.all(32),
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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: AppColors.sapphire.withOpacity(0.08)
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(
                'Contact Information',
                'Get in touch with our team',
                light: false,
              ),
              const SizedBox(height: 40),
              _buildGlassCard(
                child: _buildContactItem(
                  icon: Icons.location_on_outlined,
                  title: 'Visit Us',
                  content: AppConfig.address,
                  light: false,
                ),
              ),
              const SizedBox(height: 24),
              _buildGlassCard(
                child: _buildContactItem(
                  icon: Icons.phone_outlined,
                  title: 'Call Us',
                  content: AppConfig.contactPhone,
                  isClickable: true,
                  light: false,
                ),
              ),
              const SizedBox(height: 24),
              _buildGlassCard(
                child: _buildContactItem(
                  icon: Icons.email_outlined,
                  title: 'Email Us',
                  content: AppConfig.contactEmail,
                  isClickable: true,
                  light: false,
                ),
              ),
              const SizedBox(height: 40),
              _buildGlassCard(
                child: _buildBusinessHoursContent(),
              ),
              const Spacer(),
              _buildSocialLinksGlass(),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}