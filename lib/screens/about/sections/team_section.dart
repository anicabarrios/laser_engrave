import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';
import '../../../widgets/grid_pattern_painter.dart';

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
      ),
      child: Stack(
        children: [
          // Grid pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: GridPatternPainter(
                color: AppColors.sapphire.withOpacity(0.08),
              ),
            ),
          ),
          // Content
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  Text(
                    'Meet Our Team',
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
                    'Expert craftsmen and engineers dedicated to excellence',
                    style: TextStyle(
                      fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                      color: AppColors.darkTextColor.withOpacity(0.7),
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
        ],
      ),
    );
  }
}

class _TeamMemberCard extends StatefulWidget {
  final Map<String, String> member;

  const _TeamMemberCard({required this.member});

  @override
  State<_TeamMemberCard> createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<_TeamMemberCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withOpacity(0.08),
              blurRadius: isHovered ? 20 : 10,
              offset: Offset(0, isHovered ? 8 : 4),
              spreadRadius: isHovered ? 2 : 0,
            ),
            if (isHovered)
              BoxShadow(
                color: AppColors.sapphire.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(-2, -2),
            ),
          ],
          border: Border.all(
            color: isHovered 
                ? AppColors.sapphire.withOpacity(0.3)
                : AppColors.platinum.withOpacity(0.3),
            width: isHovered ? 2 : 1,
          ),
        ),
        transform: Matrix4.identity()
          ..scale(isHovered ? 1.02 : 1.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.member['image']!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(isHovered ? 0.1 : 0.2),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    if (isHovered)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.sapphire.withOpacity(0.2),
                              AppColors.pearl.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(
                          context,
                          isHovered ? 22 : 20,
                        ),
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                        letterSpacing: 0.3,
                      ),
                      child: Text(
                        widget.member['name']!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        widget.member['role']!,
                        style: TextStyle(
                          fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                          color: AppColors.sapphire,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.member['description']!,
                      style: TextStyle(
                        fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                        color: AppColors.darkTextColor.withOpacity(0.7),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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