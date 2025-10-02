import 'dart:ui';
import 'package:flutter/material.dart';

class SmoothScrollPhysics extends ScrollPhysics {
  final double speedFactor;
  final double frictionFactor;

  const SmoothScrollPhysics({
    super.parent,
    this.speedFactor = 1.0, 
    this.frictionFactor = 0.92, 
  });

  @override
  SmoothScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SmoothScrollPhysics(
      parent: buildParent(ancestor),
      speedFactor: speedFactor,
      frictionFactor: frictionFactor,
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return offset * speedFactor;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final Tolerance tolerance = toleranceFor(position);
    final double adjustedVelocity = velocity * frictionFactor;

    if (adjustedVelocity.abs() >= tolerance.velocity ||
        position.outOfRange) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        position.pixels + adjustedVelocity * 0.6, 
        adjustedVelocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,     
        stiffness: 120, 
        damping: 18,    
      );
}

class SmoothScrollBehavior extends ScrollBehavior {
  const SmoothScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const SmoothScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Scrollbar(
          controller: details.controller,
          thumbVisibility: false,
          thickness: 8,
          radius: const Radius.circular(4),
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

/// Animated scroll controller with smooth scroll-to functionality
class SmoothScrollController extends ScrollController {
  SmoothScrollController({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
  });

  /// Smoothly scroll to a specific offset
  Future<void> smoothScrollTo(
    double offset, {
    Duration duration = const Duration(milliseconds: 400), 
    Curve curve = Curves.easeInOutCubic,
  }) async {
    if (!hasClients) return;

    await animateTo(
      offset,
      duration: duration,
      curve: curve,
    );
  }

  /// Smoothly scroll to top
  Future<void> scrollToTop({
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    return smoothScrollTo(0, duration: duration, curve: curve);
  }

  /// Smoothly scroll to bottom
  Future<void> scrollToBottom({
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    if (!hasClients) return;
    
    return smoothScrollTo(
      position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  /// Scroll by a delta amount smoothly
  Future<void> smoothScrollBy(
    double delta, {
    Duration duration = const Duration(milliseconds: 250),
    Curve curve = Curves.easeInOutCubic,
  }) async {
    if (!hasClients) return;

    final double targetOffset =
        (offset + delta).clamp(0.0, position.maxScrollExtent);

    await animateTo(
      targetOffset,
      duration: duration,
      curve: curve,
    );
  }
}