import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';
import '../../config/responsive_breakpoints.dart';
import '../../widgets/grid_pattern_painter.dart';

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
                  _buildHeader(context),
                  const SizedBox(height: 60),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isSmallScreen ? 1 : 3,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: isSmallScreen ? 0.75 : 0.8,
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

  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return Column(
      children: [
        // Title text
        Text(
          'Meet Our Team',
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
              'Expert craftsmen and engineers dedicated to excellence',
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: _buildTeamMemberImage(isHovered),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: ScreenUtils.getResponsiveFontSize(
                              context,
                              isHovered ? 22 : (isSmallScreen ? 18 : 20),
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
                            color: AppColors.sapphire.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.sapphire.withOpacity(0.2),
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
                        const SizedBox(height: 8),
                        Text(
                          widget.member['description']!,
                          style: TextStyle(
                            fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                            color: AppColors.darkTextColor.withOpacity(0.7),
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMemberImage(bool isHovered) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base image - doesn't animate
        Image.asset(
          widget.member['image']!,
          fit: BoxFit.cover,
        ),
        
        // Overlay that animates
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isHovered ? 1.0 : 0.0,
          child: Container(
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
        ),
        
        // Dark overlay that fades out on hover
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isHovered ? 0.0 : 0.2,
          child: Container(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

final List<Map<String, String>> _teamMembers = [
  {
    'name': 'John Smith',
    'role': 'Master Engraver',
    'description': '15 years of precision engineering experience',
    'image': 'assets/images/boss.webp',
  },
  {
    'name': 'Sarah Johnson',
    'role': 'Design Director',
    'description': 'Award-winning industrial designer',
    'image': 'assets/images/bossl.webp',
  },
  {
    'name': 'Michael Chen',
    'role': 'Technical Lead',
    'description': 'Specialized in advanced laser systems',
    'image': 'assets/images/worker.webp',
  },
];