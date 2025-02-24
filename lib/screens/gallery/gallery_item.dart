import 'package:flutter/material.dart';
import 'package:laser_engrave/utils/colors.dart';

class GalleryItem extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const GalleryItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  // Base shadow
                  BoxShadow(
                    color: AppColors.darkColor.withOpacity(0.1),
                    blurRadius: 10 + (10 * _elevationAnimation.value),
                    offset: Offset(0, 5 + (5 * _elevationAnimation.value)),
                    spreadRadius: 0 + (2 * _elevationAnimation.value),
                  ),
                  // Secondary highlight shadow
                  BoxShadow(
                    color: AppColors.sapphire
                        .withOpacity(0.1 * _elevationAnimation.value),
                    blurRadius: 30,
                    offset: const Offset(0, 8),
                  ),
                  // Subtle inner glow
                  BoxShadow(
                    color: Colors.white
                        .withOpacity(0.1 * _elevationAnimation.value),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    _buildBackgroundImage(),
                    _buildOverlays(),
                    _buildContent(),
                    _buildInteractiveElements(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Hero(
      tag: widget.item['imageUrl'],
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.item['imageUrl']),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(_isHovered ? 0.3 : 0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlays() {
    return Stack(
      children: [
        // Base gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(_isHovered ? 0.8 : 0.6),
              ],
              stops: const [0.4, 1.0],
            ),
          ),
        ),
        // Animated accent gradient
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _isHovered ? 1.0 : 0.0,
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
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryBadge(),
          const Spacer(),
          _buildTitleAndTags(),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        widget.item['category'],
        style: const TextStyle(
          color: AppColors.sapphire,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTitleAndTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: _isHovered ? 26 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
          child: Text(widget.item['title']),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ...(widget.item['tags'] as List<String>)
                .take(2)
                .map((tag) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildTag(tag),
                    )),
            if (_isHovered) ...[
              const Spacer(),
              _buildViewButton(),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(_isHovered ? 0.2 : 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildViewButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.sapphire,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.sapphire.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  Widget _buildInteractiveElements() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isHovered ? 1.0 : 0.0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.sapphire.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}