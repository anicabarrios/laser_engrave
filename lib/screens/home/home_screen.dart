import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../config/app_config.dart';
import '../../utils/colors.dart';
import '../../models/carousel_item.dart';
import '../../models/feature.dart';
import '../../utils/screen_utils.dart';
import '../../config/responsive_breakpoints.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<CarouselItem> carouselItems = [
    const CarouselItem(
      image: 'assets/images/slide1.jpg',
      title: 'Precision Laser Engraving',
      subtitle: 'State-of-the-art technology for perfect results',
    ),
    const CarouselItem(
      image: 'assets/images/slide2.jpg',
      title: 'Custom Designs',
      subtitle: 'Bring your ideas to life',
    ),
    const CarouselItem(
      image: 'assets/images/slide3.jpg',
      title: 'Industrial Solutions',
      subtitle: 'Professional marking and engraving',
    ),
  ];

  final List<Feature> features = [
    const Feature(
      icon: Icons.precision_manufacturing,
      title: 'Advanced Technology',
      description: 'State-of-the-art fiber laser systems capable of marking metals, plastics, and composites with precision up to 0.02mm',
    ),
    const Feature(
      icon: Icons.architecture,
      title: 'Multi-Material Expertise',
      description: 'Specialized equipment for wood, metal, glass, leather, and plastic engraving with optimal settings for each material',
    ),
    const Feature(
      icon: Icons.assessment,
      title: 'Quality Control',
      description: 'Advanced optical verification systems ensuring perfect reproduction and consistent quality across bulk orders',
    ),
    const Feature(
      icon: Icons.diversity_3,
      title: 'Industry Solutions',
      description: 'Tailored services for aerospace, medical, automotive, and jewelry industries with certified processes',
    ),
    const Feature(
      icon: Icons.interests,
      title: 'Custom Projects',
      description: 'Full-service design team helping transform your ideas into reality with 3D visualization before production',
    ),
    const Feature(
      icon: Icons.verified,
      title: 'Certified Process',
      description: 'ISO 9001:2015 certified facility with documented quality management system for consistent results',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final responsivePadding = ScreenUtils.getResponsivePadding(context);
    
    // Pre-calculate responsive font sizes
    final titleFontSize = ScreenUtils.getResponsiveFontSize(
      context,
      isSmallScreen ? 32 : 48,
    );
    final subtitleFontSize = ScreenUtils.getResponsiveFontSize(
      context,
      isSmallScreen ? 18 : 24,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppConfig.appName,
          style: TextStyle(
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.lightTextColor),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCarousel(
              context,
              isSmallScreen,
              screenWidth,
              titleFontSize,
              subtitleFontSize,
            ),
            _buildFeatures(context, isSmallScreen, responsivePadding),
            _buildCallToAction(context, isSmallScreen, responsivePadding),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(
    BuildContext context,
    bool isSmallScreen,
    double screenWidth,
    double titleFontSize,
    double subtitleFontSize,
  ) {
    return CarouselSlider(
      options: CarouselOptions(
        height: isSmallScreen ? 400 : 600,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOutCubic,
        autoPlayAnimationDuration: const Duration(milliseconds: 1500),
        viewportFraction: 1.0,
      ),
      items: carouselItems.map((item) {
        return Container(
          width: screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(item.image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.premiumDarkGradient,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: AppColors.lightTextColor,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: AppColors.accentColor, width: 3),
                        ),
                      ),
                      child: Text(
                        item.subtitle,
                        style: TextStyle(
                          color: AppColors.lightTextColor.withOpacity(0.9),
                          fontSize: subtitleFontSize,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeatures(BuildContext context, bool isSmallScreen, double padding) {
    final featureTitleSize = ScreenUtils.getResponsiveFontSize(context, 36);
    final cardTitleSize = ScreenUtils.getResponsiveFontSize(context, 20);
    final descriptionSize = ScreenUtils.getResponsiveFontSize(context, 14);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Column(
        children: [
          Text(
            'Our Capabilities',
            style: TextStyle(
              fontSize: featureTitleSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: AppColors.lightTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isSmallScreen ? 1 : 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isSmallScreen ? 1.5 : 1.1,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) => _buildFeatureCard(
              features[index],
              cardTitleSize,
              descriptionSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Feature feature, double titleSize, double descriptionSize) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.platinum.withOpacity(0.3)),
        gradient: AppColors.metallicGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.sapphire.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                feature.icon,
                size: 40,
                color: AppColors.sapphire,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              feature.title,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              feature.description,
              style: TextStyle(
                fontSize: descriptionSize,
                color: AppColors.darkTextColor.withOpacity(0.7),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

Widget _buildCallToAction(BuildContext context, bool isSmallScreen, double padding) {
    final titleSize = ScreenUtils.getResponsiveFontSize(context, 36);
    final subtitleSize = ScreenUtils.getResponsiveFontSize(context, 20);
    final buttonTextSize = ScreenUtils.getResponsiveFontSize(context, 18);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 60 : 80,
        horizontal: padding,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Your Project?',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextColor,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Explore our gallery or contact us today for a free consultation',
            style: TextStyle(
              fontSize: subtitleSize,
              color: AppColors.lightTextColor.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          isSmallScreen 
            ? Column(
                children: [
                  _buildActionButton(
                    context,
                    'View Our Gallery',
                    Icons.photo_library,
                    '/gallery',
                    buttonTextSize,
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    context,
                    'Get Free Quote',
                    Icons.request_quote,
                    '/contact',
                    buttonTextSize,
                    false,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    context,
                    'View Our Gallery',
                    Icons.photo_library,
                    '/gallery',
                    buttonTextSize,
                    true,
                  ),
                  const SizedBox(width: 24),
                  _buildActionButton(
                    context,
                    'Get Free Quote',
                    Icons.request_quote,
                    '/contact',
                    buttonTextSize,
                    false,
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    String route,
    double fontSize,
    bool isPrimary,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (isPrimary) {
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.sapphire;
                }
                return AppColors.aquamarine;
              } else {
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.titanium;
                }
                return Colors.transparent;
              }
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (isPrimary) {
                return AppColors.lightTextColor;
              }
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primaryColor;
              }
              return AppColors.lightTextColor;
            },
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: !isPrimary ? BorderSide(
                color: AppColors.titanium,
                width: 2,
              ) : BorderSide.none,
            ),
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return 8;
              }
              return 4;
            },
          ),
          shadowColor: MaterialStateProperty.all<Color>(
            AppColors.darkColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}