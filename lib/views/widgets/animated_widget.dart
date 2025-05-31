// widgets/animated_section_widget.dart
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum AnimationStyle {
  fadeIn,
  slideUp,
  slideLeft,
  slideRight,
  scaleUp,
  rotateIn
}

class AnimatedSectionWidget extends StatefulWidget {
  final Widget child;
  final String sectionKey;
  final AnimationStyle animationStyle;
  final Duration duration;
  final Curve curve;
  final double visibilityThreshold;
  
  const AnimatedSectionWidget({
    super.key,
    required this.child,
    required this.sectionKey,
    this.animationStyle = AnimationStyle.fadeIn,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutQuart,
    this.visibilityThreshold = 0.1,
  });

  @override
  State<AnimatedSectionWidget> createState() => _AnimatedSectionWidgetState();
}

class _AnimatedSectionWidgetState extends State<AnimatedSectionWidget> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.sectionKey),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > widget.visibilityThreshold && !_isVisible) {
          setState(() {
            _isVisible = true;
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
      
      case AnimationStyle.rotateIn:
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedRotation(
            turns: _isVisible ? 0 : -0.05,
            duration: widget.duration,
            curve: widget.curve,
            child: widget.child,
          ),
        );
    }
  }
}