import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    final padding = ScreenUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 60 : 100,
        horizontal: padding,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Meet Our Team',
                style: TextStyle(
                  fontSize: ScreenUtils.getResponsiveFontSize(context, 36),
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightTextColor,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Expert craftsmen and engineers dedicated to excellence',
                style: TextStyle(
                  fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                  color: AppColors.lightTextColor.withOpacity(0.9),
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmallScreen ? 1 : 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: isSmallScreen ? 1.2 : 0.8,
                ),
                itemCount: _teamMembers.length,
                itemBuilder: (context, index) =>
                    _TeamMemberCard(member: _teamMembers[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  final Map<String, String> member;

  const _TeamMemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: AppColors.metallicGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage(member['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    member['name']!,
                    style: TextStyle(
                      fontSize: ScreenUtils.getResponsiveFontSize(context, 20),
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    member['role']!,
                    style: TextStyle(
                      fontSize: ScreenUtils.getResponsiveFontSize(context, 16),
                      color: AppColors.sapphire,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    member['description']!,
                    style: TextStyle(
                      fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                      color: AppColors.darkTextColor.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> _teamMembers = [
  {
    'name': 'John Smith',
    'role': 'Master Engraver',
    'description': '15 years of precision engineering experience',
    'image': 'assets/images/team1.jpg',
  },
  {
    'name': 'Sarah Johnson',
    'role': 'Design Director',
    'description': 'Award-winning industrial designer',
    'image': 'assets/images/team2.jpg',
  },
  {
    'name': 'Michael Chen',
    'role': 'Technical Lead',
    'description': 'Specialized in advanced laser systems',
    'image': 'assets/images/team3.jpg',
  },
];
