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
    final childAspectRatio = _getChildAspectRatio(width);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: _getSpacing(width),
        crossAxisSpacing: _getSpacing(width),
        childAspectRatio: childAspectRatio,
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
    return 4;
  }

  double _getChildAspectRatio(double width) {
    if (ResponsiveBreakpoints.isMobile(width)) return 0.95; 
    if (ResponsiveBreakpoints.isTablet(width)) return 0.90; 
    return 0.85; // Desktop
  }

  double _getSpacing(double width) {
    if (ResponsiveBreakpoints.isMobile(width)) return 16;
    if (ResponsiveBreakpoints.isTablet(width)) return 20;
    return 24; // Desktop
  }
}