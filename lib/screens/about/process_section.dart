import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';
import '../../config/responsive_breakpoints.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

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
        gradient: AppColors.metallicGradient,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 60),
              isSmallScreen
                  ? Column(
                      children: _processSteps
                          .map((step) => _ProcessStep(
                                step: step,
                                isLast:
                                    step == _processSteps[_processSteps.length - 1],
                              ))
                          .toList(),
                    )
                  : Row(
                      children: _processSteps
                          .map((step) => Expanded(
                                child: _ProcessStep(
                                  step: step,
                                  isLast: step ==
                                      _processSteps[_processSteps.length - 1],
                                ),
                              ))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return Column(
      children: [
        Text(
          'Our Process',
          style: TextStyle(
            fontSize: ScreenUtils.getResponsiveFontSize(context, isSmallScreen ? 32 : 36),
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
            letterSpacing: 0.5,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        
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
              'Our streamlined approach to delivering exceptional results',
              style: TextStyle(
                fontSize: ScreenUtils.getResponsiveFontSize(context, 18),
                fontWeight: FontWeight.w500,
                color: Colors.white, 
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

class _ProcessStep extends StatefulWidget {
  final Map<String, dynamic> step;
  final bool isLast;

  const _ProcessStep({
    required this.step,
    required this.isLast,
  });

  @override
  State<_ProcessStep> createState() => _ProcessStepState();
}

class _ProcessStepState extends State<_ProcessStep> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

    const double iconContainerSize = 72.0; 
    const double iconSize = 32.0; 
    const double titleHeight = 28.0; 
    const double descriptionHeight = 50.0; 

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
        child: Column(
          children: [
            SizedBox(
              height: iconContainerSize,
              width: iconContainerSize,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  width: iconContainerSize,
                  height: iconContainerSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isHovered 
                        ? AppColors.sapphire.withOpacity(0.2) 
                        : AppColors.sapphire.withOpacity(0.1),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.sapphire.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 8,
                              spreadRadius: -2,
                              offset: const Offset(-2, -2),
                            ),
                          ]
                        : [],
                    border: Border.all(
                      color: _isHovered
                          ? AppColors.sapphire.withOpacity(0.5)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    widget.step['icon'],
                    size: iconSize,
                    color: AppColors.sapphire,
                  ),
                ),
              ),
            ),
            
            if (!isSmallScreen)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  height: 2,
                  color: _isHovered
                      ? AppColors.sapphire.withOpacity(0.6)
                      : AppColors.sapphire.withOpacity(0.3),
                ),
              ),
              
            const SizedBox(height: 16),

            SizedBox(
              height: titleHeight,
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: ScreenUtils.getResponsiveFontSize(
                      context,
                      _isHovered ? 22 : 20,
                    ),
                    fontWeight: FontWeight.bold,
                    color: _isHovered 
                        ? AppColors.sapphire
                        : AppColors.darkTextColor,
                    letterSpacing: _isHovered ? 0.6 : 0.5,
                  ),
                  child: Text(
                    widget.step['title'],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            SizedBox(
              height: descriptionHeight,
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
                    color: _isHovered
                        ? AppColors.darkTextColor.withOpacity(0.9)
                        : AppColors.darkTextColor.withOpacity(0.8),
                    height: 1.5,
                  ),
                  child: Text(
                    widget.step['description'],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _processSteps = [
  {
    'icon': Icons.chat_outlined,
    'title': 'Consultation',
    'description': 'Detailed discussion of your requirements and objectives',
  },
  {
    'icon': Icons.design_services,
    'title': 'Design',
    'description': 'Creation of custom designs and technical specifications',
  },
  {
    'icon': Icons.precision_manufacturing,
    'title': 'Production',
    'description': 'Precision manufacturing with quality controls',
  },
  {
    'icon': Icons.verified_outlined,
    'title': 'Quality Check',
    'description': 'Rigorous testing and verification process',
  },
];