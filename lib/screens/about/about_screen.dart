import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:laser_engrave/screens/home/floating_contact_button.dart';
import 'package:laser_engrave/widgets/hero.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/footer.dart';
import '../../utils/colors.dart';
import 'vision_section.dart';
import 'team_section.dart';
import 'process_section.dart';
import 'technology_section.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  
  // Track visibility of each section
  final Map<String, bool> _visibleSections = {
    'hero': false,
    'vision': false,
    'team': false,
    'process': false,
    'technology': false,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.forward();

    // Add post-frame callback to ensure proper initial animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _visibleSections['hero'] = true;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSectionVisibilityChanged(String sectionKey, bool isVisible) {
    if (isVisible && !(_visibleSections[sectionKey] ?? false)) {
      setState(() {
        _visibleSections[sectionKey] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.lightTextColor),
          ),
        ),
      ),
      backgroundColor: AppColors.lightColor,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section with initial load animation
                _buildAnimatedSection(
                  'hero',
                  const HeroSection(
                    title: 'Our Story of Innovation',
                    subtitle: 'Crafting Excellence Since 2023',
                  ),
                  initialDelay: 0.0,
                ),

                // Vision Section
                _buildAnimatedSection(
                  'vision',
                  const VisionSection(),
                  initialDelay: 0.2,
                ),

                // Team Section
                _buildAnimatedSection(
                  'team',
                  const TeamSection(),
                  initialDelay: 0.3,
                ),

                // Process Section
                _buildAnimatedSection(
                  'process',
                  const ProcessSection(),
                  initialDelay: 0.4,
                ),

                // Technology Section
                _buildAnimatedSection(
                  'technology',
                  const TechnologySection(),
                  initialDelay: 0.5,
                ),

                // Footer
                const Footer(),
              ],
            ),
          ),

          // Floating Contact Button with slide in animation
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
              ),
            ),
            child: const FloatingContactButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection(String key, Widget child, {double initialDelay = 0.0}) {
    return VisibilityDetector(
      key: Key(key),
      onVisibilityChanged: (visibilityInfo) {
        _onSectionVisibilityChanged(key, visibilityInfo.visibleFraction > 0.3);
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        opacity: _visibleSections[key] ?? false ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          offset: _visibleSections[key] ?? false
              ? Offset.zero
              : const Offset(0, 0.1),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: _visibleSections[key] ?? false ? 1.0 : 0.8),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: child,
          ),
        ),
      ),
    );
  }
}