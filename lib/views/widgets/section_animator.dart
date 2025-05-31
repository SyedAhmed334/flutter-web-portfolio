// widgets/section_animator.dart
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum AnimationStyle {
  fadeIn,
  slideUp,
  slideDown,
  slideLeft,
  slideRight,
  scaleUp,
  grow,
  none
}

class SectionAnimator extends StatefulWidget {
  final String sectionId;
  final Widget child;
  final AnimationStyle animationStyle;
  final Duration duration;
  final Curve curve;
  final double visibilityThreshold;
  final bool animateOnce;
  
  const SectionAnimator({
    Key? key,
    required this.sectionId,
    required this.child,
    this.animationStyle = AnimationStyle.fadeIn,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutQuart,
    this.visibilityThreshold = 0.1,
    this.animateOnce = true,
  }) : super(key: key);

  @override
  _SectionAnimatorState createState() => _SectionAnimatorState();
}

class _SectionAnimatorState extends State<SectionAnimator> {
  bool _isVisible = false;
  bool _hasAnimated = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.sectionId),
      onVisibilityChanged: (visibilityInfo) {
        if (widget.animateOnce && _hasAnimated) return;
        
        bool shouldBeVisible = visibilityInfo.visibleFraction > widget.visibilityThreshold;
        
        if (shouldBeVisible != _isVisible) {
          setState(() {
            _isVisible = shouldBeVisible;
            if (shouldBeVisible) {
              _hasAnimated = true;
            }
          });
        }
      },
      child: _buildAnimatedWidget(),
    );
  }

  Widget _buildAnimatedWidget() {
    switch (widget.animationStyle) {
      case AnimationStyle.fadeIn:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: widget.child,
        );
      
      case AnimationStyle.slideUp:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedSlide(
            offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
            duration: widget.duration,
            curve: widget.curve,
            child: widget.child,
          ),
        );
      
      case AnimationStyle.slideDown:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedSlide(
            offset: _isVisible ? Offset.zero : const Offset(0, -0.2),
            duration: widget.duration,
            curve: widget.curve,
            child: widget.child,
          ),
        );
      
      case AnimationStyle.slideLeft:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedSlide(
            offset: _isVisible ? Offset.zero : const Offset(0.2, 0),
            duration: widget.duration,
            curve: widget.curve,
            child: widget.child,
          ),
        );
      
      case AnimationStyle.slideRight:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedSlide(
            offset: _isVisible ? Offset.zero : const Offset(-0.2, 0),
            duration: widget.duration,
            curve: widget.curve,
            child: widget.child,
          ),
        );
      
      case AnimationStyle.scaleUp:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedScale(
            scale: _isVisible ? 1.0 : 0.8,
            duration: widget.duration,
            curve: widget.curve,
            child: widget.child,
          ),
        );
      
      case AnimationStyle.grow:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            transform: Transform.scale(
              scale: _isVisible ? 1.0 : 0.95,
              child: Container(),
            ).transform,
            child: widget.child,
          ),
        );
      
      case AnimationStyle.none:
      default:
        return widget.child;
    }
  }
}

// Helper widget for staggered items animation
class StaggeredItems extends StatefulWidget {
  final List<Widget> children;
  final String sectionId;
  final Duration staggerDelay;
  final Duration itemDuration;
  final Curve curve;
  final double visibilityThreshold;
  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;
  final bool animateOnce;
  
  const StaggeredItems({
    Key? key,
    required this.children,
    required this.sectionId,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.itemDuration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutQuart,
    this.visibilityThreshold = 0.1,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.animateOnce = true,
  }) : super(key: key);

  @override
  State<StaggeredItems> createState() => _StaggeredItemsState();
}

class _StaggeredItemsState extends State<StaggeredItems> {
  bool _isVisible = false;
  bool _hasAnimated = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.sectionId),
      onVisibilityChanged: (visibilityInfo) {
        if (widget.animateOnce && _hasAnimated) return;
        
        bool shouldBeVisible = visibilityInfo.visibleFraction > widget.visibilityThreshold;
        
        if (shouldBeVisible != _isVisible) {
          setState(() {
            _isVisible = shouldBeVisible;
            if (shouldBeVisible) {
              _hasAnimated = true;
            }
          });
        }
      },
      child: Wrap(
        direction: widget.direction,
        alignment: widget.alignment,
        spacing: widget.spacing,
        runSpacing: widget.runSpacing,
        children: List.generate(
          widget.children.length,
          (index) => _StaggeredItem(
            isVisible: _isVisible,
            index: index,
            staggerDelay: widget.staggerDelay,
            duration: widget.itemDuration,
            curve: widget.curve,
            child: widget.children[index],
          ),
        ),
      ),
    );
  }
}

class _StaggeredItem extends StatelessWidget {
  final bool isVisible;
  final int index;
  final Duration staggerDelay;
  final Duration duration;
  final Curve curve;
  final Widget child;

  const _StaggeredItem({
    Key? key,
    required this.isVisible,
    required this.index,
    required this.staggerDelay,
    required this.duration,
    required this.curve,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate delay based on index
    final delay = Duration(milliseconds: index * staggerDelay.inMilliseconds);
    
    return FutureBuilder(
      // Only apply delay if becoming visible
      future: isVisible ? Future.delayed(delay) : Future.value(),
      builder: (context, snapshot) {
        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: duration,
          curve: curve,
          child: AnimatedScale(
            scale: isVisible ? 1.0 : 0.85,
            duration: duration,
            curve: curve,
            child: child,
          ),
        );
      },
    );
  }
}