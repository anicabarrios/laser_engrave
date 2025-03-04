import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:laser_engrave/widgets/custom_drawer.dart';
import 'package:laser_engrave/widgets/footer.dart';
import 'package:laser_engrave/utils/colors.dart';
import 'package:laser_engrave/utils/screen_utils.dart';
import 'package:laser_engrave/config/responsive_breakpoints.dart';
import 'package:laser_engrave/widgets/hero.dart';
import 'gallery_section.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  
  final Map<String, bool> _visibleSections = {
    'hero': false,
    'gallery': false,
    'footer': false,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.forward();

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    // Get the selected category from route arguments if available
    final Map<String, dynamic> args = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final String? selectedCategory = args['selectedCategory'];

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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section
            _buildAnimatedSection(
              'hero',
              const HeroSection(
                title: 'Our Work',
                subtitle: 'Explore our portfolio of precision engravings',
              ),
              initialDelay: 0.0,
              useScale: true,
            ),

            // Gallery Section (passing the selected category)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtils.getResponsivePadding(context),
                vertical: isSmallScreen ? 40 : 60,
              ),
              child: _buildAnimatedSection(
                'gallery',
                GallerySection(initialCategory: selectedCategory),
                initialDelay: 0.2,
              ),
            ),

            // Footer
            _buildAnimatedSection(
              'footer',
              const Footer(),
              initialDelay: 0.3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(
    String key,
    Widget child, {
    double initialDelay = 0.0,
    bool useScale = false,
  }) {
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
          child: useScale
              ? TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0.8,
                    end: _visibleSections[key] ?? false ? 1.0 : 0.8,
                  ),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: child,
                )
              : child,
        ),
      ),
    );
  }
}