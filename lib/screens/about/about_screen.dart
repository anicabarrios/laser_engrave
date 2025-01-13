import 'package:flutter/material.dart';
import 'package:laser_engrave/screens/home/floating_contact_button.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/footer.dart';
import '../../utils/colors.dart';
import 'sections/hero_section.dart';
import 'sections/vision_section.dart';
import 'sections/team_section.dart';
import 'sections/process_section.dart';
import 'sections/technology_section.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.lightTextColor),
      ),
      backgroundColor: AppColors.lightColor,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Enhanced sections with consistent styling
                const HeroSection(),
                const SizedBox(height: 40),
                const VisionSection(),
                const TeamSection(),
                const ProcessSection(),
                const TechnologySection(),
                 const Footer(),

               
               
              ],
            ),
          ),
         

          // Add floating contact button for consistency with home screen
          const FloatingContactButton(),
        ],
      ),
    );
  }
}
