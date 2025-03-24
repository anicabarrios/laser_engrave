import 'package:flutter/material.dart';
import '../../../config/responsive_breakpoints.dart';
import 'gallery_item.dart';

class GalleryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onItemTap;

  const GalleryGrid({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildGalleryGrid(constraints.maxWidth);
      },
    );
  }

  Widget _buildGalleryGrid(double width) {
    final crossAxisCount = _getCrossAxisCount(width);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(width),
        vertical: _getVerticalPadding(width),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: _getSpacing(width),
        crossAxisSpacing: _getSpacing(width),
        // Using a fixed aspect ratio for consistent appearance
        childAspectRatio: _getChildAspectRatio(width),
        mainAxisExtent: _getMainAxisExtent(width),
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GalleryItem(
          item: item,
          onTap: () => onItemTap(item),
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (ResponsiveBreakpoints.isMobile(width)) return 1;
    if (ResponsiveBreakpoints.isTablet(width)) return 2;
    if (width < 1200) return 3;
    return 3; // Limiting to 3 even on large screens for better photo display
  }

  double _getChildAspectRatio(double width) {
    // Using 3:4 aspect ratio for a more portrait-oriented look that showcases photos better
    if (ResponsiveBreakpoints.isMobile(width)) return 0.75;
    if (ResponsiveBreakpoints.isTablet(width)) return 0.8;
    return 0.85; // Desktop
  }

  double _getMainAxisExtent(double width) {
    // Control the height of items directly for better photo display
    if (ResponsiveBreakpoints.isMobile(width)) return 360; // Taller on mobile
    if (ResponsiveBreakpoints.isTablet(width)) return 320;
    return 380; // Desktop - taller to showcase images better
  }

  double _getSpacing(double width) {
    // Adjusted spacing for better visual appearance
    if (ResponsiveBreakpoints.isMobile(width)) return 20;
    if (ResponsiveBreakpoints.isTablet(width)) return 24;
    return 30; // Desktop - more breathing room between items
  }

  double _getHorizontalPadding(double width) {
    // Added horizontal padding function for responsive layout
    if (ResponsiveBreakpoints.isMobile(width)) return 12;
    if (ResponsiveBreakpoints.isTablet(width)) return 16;
    return 20; // Desktop
  }

  double _getVerticalPadding(double width) {
    // Added vertical padding function for responsive layout
    if (ResponsiveBreakpoints.isMobile(width)) return 12;
    if (ResponsiveBreakpoints.isTablet(width)) return 16;
    return 24; // Desktop
  }
}
