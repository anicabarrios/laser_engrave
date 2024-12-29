import 'package:flutter/material.dart';
import '../config/responsive_breakpoints.dart';

class ScreenUtils {
  static double getResponsivePadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (ResponsiveBreakpoints.isMobile(screenWidth)) {
      return 16.0;
    } else if (ResponsiveBreakpoints.isTablet(screenWidth)) {
      return 24.0;
    } else {
      return 32.0;
    }
  }

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (ResponsiveBreakpoints.isMobile(screenWidth)) {
      return baseSize * 0.8;
    } else if (ResponsiveBreakpoints.isTablet(screenWidth)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }
}