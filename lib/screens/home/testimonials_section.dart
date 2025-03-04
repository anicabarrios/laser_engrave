import 'package:flutter/material.dart';
import 'dart:async'; 
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';
import '../../../models/testimonial_model.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  int _currentSlide = 0;
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;

  final List<Testimonial> testimonials = [
    const Testimonial(
      name: "Michael Brown",
      role: "Product Manager",
      company: "TechCorp Industries",
      content: "The precision and quality of their laser engraving work exceeded our expectations. Their attention to detail and professional approach made them the perfect partner for our product customization needs.",
      rating: 5.0,
    ),
    const Testimonial(
      name: "Sarah Johnson",
      role: "Creative Director",
      company: "Design Studios Co.",
      content: "Working with the team was a fantastic experience. They brought our design concepts to life with incredible accuracy and helped us create unique pieces that our clients love.",
      rating: 5.0,
    ),
    const Testimonial(
      name: "David Martinez",
      role: "Operations Manager",
      company: "Industrial Solutions Ltd.",
      content: "Their industrial marking solutions have significantly improved our production line efficiency. The consistency and durability of their engravings are outstanding.",
      rating: 5.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && mounted) {
        final nextPage = (_currentSlide < testimonials.length - 1) ? _currentSlide + 1 : 0;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _pauseAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _resumeAutoPlay() {
    if (mounted) {
      _startAutoPlay();
    }
  }
  
  void _safelyAnimateToPage(int page) {
    if (_pageController.hasClients && mounted) {
      try {
        _pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        print('Safe animation error handled: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final isTabletScreen = ResponsiveBreakpoints.isTablet(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 40 : 80,
        horizontal: padding,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.metallicGradient,
      ),
      child: Column(
        children: [
          // Enhanced header section using the same style as other sections
          _buildHeader(context),
          const SizedBox(height: 60),
          
          if (isSmallScreen)
            _buildMobileTestimonials()
          else if (isTabletScreen)
            _buildTabletTestimonials()
          else
            _buildDesktopTestimonials(),
        ],
      ),
    );
  }

  // New enhanced header matching other sections
  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return Column(
      children: [
        // Title text
        Text(
          'Client Testimonials',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, isSmallScreen ? 32 : 36),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
            letterSpacing: 0.5,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        
        // Decorative divider for title
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 24),
          width: isSmallScreen ? 240 : 300,
          height: 2.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.sapphire.withOpacity(0.0),
                AppColors.sapphire,
                AppColors.sapphire.withOpacity(0.0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(1.25),
          ),
        ),
        
        // Subtitle with text-only color transition effect
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                AppColors.darkTextColor.withOpacity(0.7),
                AppColors.sapphire,
                AppColors.darkTextColor.withOpacity(0.7),
              ],
              stops: const [0.1, 0.5, 0.9],
            ).createShader(bounds),
            child: Text(
              'Hear what our clients have to say about our services',
              style: TextStyle(
                fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                fontWeight: FontWeight.w500,
                color: Colors.white, // The ShaderMask will override this
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTestimonials() {
    return Column(
      children: [
        SizedBox(
          height: 400, 
          child: PageView.builder(
            controller: _pageController,
            itemCount: testimonials.length,
            onPageChanged: (index) {
              setState(() {
                _currentSlide = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: MobileTestimonialCard(testimonial: testimonials[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                _pauseAutoPlay(); 
                final prevPage = _currentSlide > 0 ? _currentSlide - 1 : testimonials.length - 1;
                _safelyAnimateToPage(prevPage);
                Future.delayed(const Duration(milliseconds: 500), _resumeAutoPlay);
              },
              icon: const Icon(Icons.arrow_back_ios, size: 16),
              color: AppColors.sapphire,
            ),
            ...testimonials.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  _pauseAutoPlay(); 
                  _safelyAnimateToPage(entry.key);
                  Future.delayed(const Duration(milliseconds: 500), _resumeAutoPlay);
                },
                child: Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.sapphire.withOpacity(
                      _currentSlide == entry.key ? 0.9 : 0.2,
                    ),
                  ),
                ),
              );
            }),
            IconButton(
              onPressed: () {
                _pauseAutoPlay(); 
                final nextPage = _currentSlide < testimonials.length - 1 ? _currentSlide + 1 : 0;
                _safelyAnimateToPage(nextPage);
                Future.delayed(const Duration(milliseconds: 500), _resumeAutoPlay);
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              color: AppColors.sapphire,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletTestimonials() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: HoverableTestimonialCard(testimonial: testimonials[0]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: HoverableTestimonialCard(testimonial: testimonials[1]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: HoverableTestimonialCard(testimonial: testimonials[2]),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTestimonials() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: SizedBox(
            width: constraints.maxWidth * 0.9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: testimonials.map((testimonial) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: HoverableTestimonialCard(testimonial: testimonial),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }
    );
  }
}

class MobileTestimonialCard extends StatelessWidget {
  final Testimonial testimonial;
  
  const MobileTestimonialCard({super.key, required this.testimonial});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.pearl,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(-2, -2),
          ),
        ],
        border: Border.all(
          color: AppColors.sapphire.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return const Icon(
                Icons.star,
                size: 22, 
                color: AppColors.sapphire,
              );
            }),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Text(
                      testimonial.content,
                      style: const TextStyle(
                        fontSize: 17, 
                        color: AppColors.darkTextColor,
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center, 
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.format_quote,
                      size: 30,
                      color: AppColors.sapphire.withOpacity(0.2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: 70,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.sapphire.withOpacity(0.2),
                  AppColors.sapphire,
                  AppColors.sapphire.withOpacity(0.2),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.sapphire.withOpacity(0.1),
                child: Text(
                  testimonial.name[0],
                  style: const TextStyle(
                    color: AppColors.sapphire,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                testimonial.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '${testimonial.role}, ${testimonial.company}',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.darkTextColor.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HoverableTestimonialCard extends StatefulWidget {
  final Testimonial testimonial;
  const HoverableTestimonialCard({super.key, required this.testimonial});

  @override
  _HoverableTestimonialCardState createState() => _HoverableTestimonialCardState();
}

class _HoverableTestimonialCardState extends State<HoverableTestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.pearl,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(_isHovered ? 0.15 : 0.1),
                blurRadius: _isHovered ? 15 : 10,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.6),
                blurRadius: 8,
                spreadRadius: -2,
                offset: const Offset(-2, -2),
              ),
            ],
            border: Border.all(
              color: _isHovered 
                ? AppColors.sapphire.withOpacity(0.3)
                : AppColors.titanium.withOpacity(0.2),
              width: _isHovered ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star,
                    size: 20,
                    color: AppColors.sapphire,
                  );
                }),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
                    child: Text(
                      widget.testimonial.content,
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 16),
                        color: AppColors.darkTextColor.withOpacity(0.8),
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -5,
                    left: -5,
                    child: Icon(
                      Icons.format_quote,
                      size: 30,
                      color: AppColors.sapphire.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: 60,
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.sapphire.withOpacity(0.2),
                      AppColors.sapphire,
                      AppColors.sapphire.withOpacity(0.2),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.sapphire.withOpacity(0.1),
                    child: Text(
                      widget.testimonial.name[0],
                      style: const TextStyle(
                        color: AppColors.sapphire,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                            fontWeight: FontWeight.bold,
                            color: _isHovered 
                                ? AppColors.sapphire 
                                : AppColors.darkTextColor,
                          ),
                          child: Text(widget.testimonial.name),
                        ),
                        Text(
                          '${widget.testimonial.role}, ${widget.testimonial.company}',
                          style: TextStyle(
                            fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                            color: AppColors.darkTextColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}