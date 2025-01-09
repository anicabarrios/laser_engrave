import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  final List<Testimonial> testimonials = [
    Testimonial(
      name: "Michael Brown",
      role: "Product Manager",
      company: "TechCorp Industries",
      content: "The precision and quality of their laser engraving work exceeded our expectations. Their attention to detail and professional approach made them the perfect partner for our product customization needs.",
      rating: 5.0,
    ),
    Testimonial(
      name: "Sarah Johnson",
      role: "Creative Director",
      company: "Design Studios Co.",
      content: "Working with the team was a fantastic experience. They brought our design concepts to life with incredible accuracy and helped us create unique pieces that our clients love.",
      rating: 5.0,
    ),
    Testimonial(
      name: "David Martinez",
      role: "Operations Manager",
      company: "Industrial Solutions Ltd.",
      content: "Their industrial marking solutions have significantly improved our production line efficiency. The consistency and durability of their engravings are outstanding.",
      rating: 5.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
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
          Text(
            'Client Testimonials',
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 36),
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Hear what our clients have to say about our services',
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
              color: AppColors.darkTextColor.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          isSmallScreen 
              ? _buildMobileTestimonials()
              : _buildDesktopTestimonials(),
        ],
      ),
    );
  }

  Widget _buildMobileTestimonials() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: testimonials.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return _buildTestimonialCard(testimonials[index]);
          },
          options: CarouselOptions(
            height: 400,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() => _currentSlide = index);
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: testimonials.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() => _currentSlide = entry.key);
              },
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.sapphire.withOpacity(
                    _currentSlide == entry.key ? 0.9 : 0.2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDesktopTestimonials() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: testimonials.map((testimonial) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: _buildTestimonialCard(testimonial),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTestimonialCard(Testimonial testimonial) {
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
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                size: 20,
                color: AppColors.sapphire,
              );
            }),
          ),
          const SizedBox(height: 20),
          Text(
            testimonial.content,
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 16),
              color: AppColors.darkTextColor.withOpacity(0.8),
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.sapphire.withOpacity(0.1),
                child: Text(
                  testimonial.name[0],
                  style: TextStyle(
                    color: AppColors.sapphire,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.name,
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Text(
                      '${testimonial.role}, ${testimonial.company}',
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
    );
  }
}