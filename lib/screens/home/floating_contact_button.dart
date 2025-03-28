import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/colors.dart';
import '../../config/responsive_breakpoints.dart';

class FloatingContactButton extends StatefulWidget {
  const FloatingContactButton({super.key});

  @override
  State<FloatingContactButton> createState() => _FloatingContactButtonState();
}

class _FloatingContactButtonState extends State<FloatingContactButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    HapticFeedback.lightImpact();
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Future<void> _launchUrl(String url) async {
    HapticFeedback.mediumImpact();
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return Stack(
      children: [
        // Background overlay when expanded
        if (_isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleExpanded,
              child: Container(
                color: Colors.black54,
              ),
            ),
          ),
        
        // Contact buttons
        Positioned(
          right: isSmallScreen ? 12 : 16,
          bottom: isSmallScreen ? 12 : 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Animated contact options
              ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildContactOption(
                      'Call Us',
                      Icons.phone,
                      () => _launchUrl('tel:+15551234567'),
                      isSmallScreen,
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    _buildContactOption(
                      'WhatsApp',
                      Icons.chat,
                      () => _launchUrl('https://wa.me/15551234567'),
                      isSmallScreen,
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    _buildContactOption(
                      'Email',
                      Icons.email,
                      () => _launchUrl('mailto:info@example.com'),
                      isSmallScreen,
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                  ],
                ),
              ),
              
              // Main floating button
              FloatingActionButton(
                onPressed: _toggleExpanded,
                backgroundColor: AppColors.sapphire,
                child: AnimatedRotation(
                  turns: _isExpanded ? 0.125 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isExpanded ? Icons.close : Icons.contact_support,
                    color: AppColors.lightTextColor,
                    size: isSmallScreen ? 22 : 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactOption(String label, IconData icon, VoidCallback onTap, bool isSmallScreen) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 16, 
            vertical: isSmallScreen ? 8 : 12
          ),
          decoration: BoxDecoration(
            color: AppColors.pearl,
            borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.sapphire, size: isSmallScreen ? 18 : 20),
              SizedBox(width: isSmallScreen ? 6 : 8),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: isSmallScreen ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}