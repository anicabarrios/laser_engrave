import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_utils.dart';
import '../../../config/responsive_breakpoints.dart';

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
              Text(
                'Our Process',
                style: TextStyle(
                  fontSize: ScreenUtils.getResponsiveFontSize(context, 36),
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
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
}

class _ProcessStep extends StatelessWidget {
  final Map<String, dynamic> step;
  final bool isLast;

  const _ProcessStep({
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.sapphire.withOpacity(0.1),
            ),
            child: Icon(
              step['icon'],
              size: 32,
              color: AppColors.sapphire,
            ),
          ),
          if (!isLast && !isSmallScreen)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 2,
                color: AppColors.sapphire.withOpacity(0.3),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            step['title'],
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            step['description'],
            style: TextStyle(
              fontSize: ScreenUtils.getResponsiveFontSize(context, 14),
              color: AppColors.darkTextColor.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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