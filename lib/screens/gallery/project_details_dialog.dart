import 'package:flutter/material.dart';
import 'package:laser_engrave/utils/colors.dart';
import 'package:laser_engrave/config/responsive_breakpoints.dart';

class ProjectDetailsDialog extends StatefulWidget {
  final Map<String, dynamic> project;

  const ProjectDetailsDialog({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailsDialog> createState() => _ProjectDetailsDialogState();
}

class _ProjectDetailsDialogState extends State<ProjectDetailsDialog> {
  bool _isFullScreenImage = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenSize.width);
    final isTabletScreen = ResponsiveBreakpoints.isTablet(screenSize.width);
    
    // Responsive dialog sizing
    final dialogWidth = isSmallScreen 
        ? screenSize.width * 0.95 
        : isTabletScreen 
            ? screenSize.width * 0.85 
            : 1000.0;
    
    final imageHeight = isSmallScreen 
        ? 300.0 
        : isTabletScreen 
            ? 400.0 
            : 500.0;
    
    // If in fullscreen image mode
    if (_isFullScreenImage) {
      return _buildFullScreenImageView();
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          maxHeight: screenSize.height * 0.85, // Prevent overflow
        ),
        decoration: BoxDecoration(
          color: AppColors.pearl,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        // Use different layouts based on screen size
        child: isSmallScreen ? _buildMobileLayout(imageHeight) : _buildDesktopLayout(imageHeight),
      ),
    );
  }

  Widget _buildMobileLayout(double imageHeight) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Project Image with zoom indicator
        Stack(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: GestureDetector(
                onTap: () => setState(() => _isFullScreenImage = true),
                child: Image.asset(
                  widget.project['imageUrl'],
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Zoom indicator
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => setState(() => _isFullScreenImage = true),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        
        // Project Details
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategory(),
                  const SizedBox(height: 8),
                  _buildTitle(),
                  const SizedBox(height: 16),
                  _buildDescription(),
                  const SizedBox(height: 24),
                  _buildTags(widget.project['tags']),
                  const SizedBox(height: 24),
                  _buildActionButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double imageHeight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left section - Image
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _isFullScreenImage = true),
                  child: Image.asset(
                    widget.project['imageUrl'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              // Zoom indicator
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () => setState(() => _isFullScreenImage = true),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Right section - Details
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategory(),
                  const SizedBox(height: 16),
                  _buildTitle(),
                  const SizedBox(height: 24),
                  _buildDescription(),
                  const SizedBox(height: 32),
                  _buildTags(widget.project['tags']),
                  const SizedBox(height: 40),
                  _buildActionButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildFullScreenImageView() {
    return GestureDetector(
      onTap: () => setState(() => _isFullScreenImage = false),
      child: Dialog.fullscreen(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Black background
            Container(color: Colors.black),
            
            // Centered image with InteractiveViewer for pinch to zoom
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.asset(
                  widget.project['imageUrl'],
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            // Close button
            Positioned(
              top: 24,
              right: 24,
              child: IconButton(
                onPressed: () => setState(() => _isFullScreenImage = false),
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.6),
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ),
            
            // Hint text at bottom
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Pinch to zoom • Tap anywhere to close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.sapphire.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.project['category'],
        style: const TextStyle(
          color: AppColors.sapphire,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
  
  Widget _buildTitle() {
    return Text(
      widget.project['title'],
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextColor,
        height: 1.2,
      ),
    );
  }
  
  Widget _buildDescription() {
    // Using a placeholder description since it wasn't in the original model
    // You should add a description field to your project data
    return Text(
      widget.project['description'] ?? 
      'Experience the precision and artistry of our laser engraving expertise with this stunning piece. Crafted with meticulous attention to detail, this project showcases our commitment to quality and innovation.',
      style: TextStyle(
        fontSize: 16,
        color: AppColors.darkTextColor.withOpacity(0.8),
        height: 1.6,
      ),
    );
  }

  Widget _buildTags(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.sapphire.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.sapphire.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 14,
                    color: AppColors.sapphire,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    tag,
                    style: const TextStyle(
                      color: AppColors.sapphire,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = ResponsiveBreakpoints.isMobile(screenWidth);
    
    return SizedBox(
      width: isSmallScreen ? double.infinity : 280,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/contact');
        },
        icon: const Icon(Icons.send, size: 18),
        label: const Text(
          'Start Similar Project',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.sapphire,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}