import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../utils/colors.dart';
import '../../widgets/grid_pattern_painter.dart';

/// A custom widget that adds a hover effect to its child.
/// When hovered, the card scales up slightly and its shadow deepens.
class HoverGlassCard extends StatefulWidget {
  final Widget child;
  const HoverGlassCard({Key? key, required this.child}) : super(key: key);

  @override
  _HoverGlassCardState createState() => _HoverGlassCardState();
}

class _HoverGlassCardState extends State<HoverGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        // Center the transform so the card expands equally in all directions.
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        transformAlignment: Alignment.center,
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
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.darkColor.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.darkColor.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}

/// A custom widget for social icons with a hover effect.
/// When hovered, the icon scales up and its shadow becomes more pronounced.
class HoverSocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  const HoverSocialIcon({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  _HoverSocialIconState createState() => _HoverSocialIconState();
}

class _HoverSocialIconState extends State<HoverSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.2 : 1.0),
          transformAlignment: Alignment.center,
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
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.darkColor.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.darkColor.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: AppColors.sapphire,
          ),
        ),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

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
                  style: const TextStyle(
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
                child: const Icon(
                  Icons.access_time,
                  size: 24,
                  color: AppColors.sapphire,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
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
            style: const TextStyle(
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
        const Text(
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
            // Use the new HoverSocialIcon widget for each social icon.
            HoverSocialIcon(icon: Icons.facebook, label: 'Facebook'),
            const SizedBox(width: 16),
            HoverSocialIcon(icon: Icons.camera_alt_outlined, label: 'Instagram'),
            const SizedBox(width: 16),
            HoverSocialIcon(icon: Icons.connect_without_contact_outlined, label: 'LinkedIn'),
          ],
        ),
      ],
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
                color: AppColors.sapphire.withOpacity(0.08),
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
              HoverGlassCard(
                child: _buildContactItem(
                  icon: Icons.location_on_outlined,
                  title: 'Visit Us',
                  content: AppConfig.address,
                  light: false,
                ),
              ),
              const SizedBox(height: 24),
              HoverGlassCard(
                child: _buildContactItem(
                  icon: Icons.phone_outlined,
                  title: 'Call Us',
                  content: AppConfig.contactPhone,
                  isClickable: true,
                  light: false,
                ),
              ),
              const SizedBox(height: 24),
              HoverGlassCard(
                child: _buildContactItem(
                  icon: Icons.email_outlined,
                  title: 'Email Us',
                  content: AppConfig.contactEmail,
                  isClickable: true,
                  light: false,
                ),
              ),
              const SizedBox(height: 40),
              HoverGlassCard(
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
