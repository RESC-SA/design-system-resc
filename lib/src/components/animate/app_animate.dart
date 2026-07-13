import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'animate_types.dart';

class AppAnimateConfig {
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool loop;
  final bool reverse;
  final double begin;
  final double end;
  final double beginX;
  final double beginY;
  final double endX;
  final double endY;

  const AppAnimateConfig({
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.loop = false,
    this.reverse = false,
    this.begin = 0.0,
    this.end = 1.0,
    this.beginX = -30,
    this.beginY = -30,
    this.endX = 0,
    this.endY = 0,
  });

  const AppAnimateConfig.stagger({
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.loop = false,
    this.reverse = false,
    this.begin = 0.0,
    this.end = 1.0,
    this.beginX = 0,
    this.beginY = 20,
    this.endX = 0,
    this.endY = 0,
  });

  const AppAnimateConfig.shimmer({
    this.duration = const Duration(milliseconds: 1200),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
    this.loop = true,
    this.reverse = true,
    this.begin = -1.0,
    this.end = 2.0,
    this.beginX = -200,
    this.beginY = 0,
    this.endX = 200,
    this.endY = 0,
  });

  const AppAnimateConfig.blur({
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.loop = false,
    this.reverse = false,
    this.begin = 10.0,
    this.end = 0.0,
    this.beginX = 0,
    this.beginY = 0,
    this.endX = 0,
    this.endY = 0,
  });
}

class AppAnimate extends StatefulWidget {
  final AppAnimateType type;
  final AppAnimateConfig? config;
  final Widget child;
  final VoidCallback? onPlay;
  final VoidCallback? onComplete;

  const AppAnimate({
    super.key,
    required this.type,
    this.config,
    required this.child,
    this.onPlay,
    this.onComplete,
  });

  @override
  State<AppAnimate> createState() => _AppAnimateState();
}

class _AppAnimateState extends State<AppAnimate> {
  @override
  Widget build(BuildContext context) {
    final c = widget.config ?? const AppAnimateConfig();
    final anim = widget.child.animate(
      onPlay: (controller) {
        if (c.loop) {
          controller.repeat(reverse: c.reverse);
        }
        widget.onPlay?.call();
      },
      onComplete: (_) => widget.onComplete?.call(),
    );

    return _buildEffects(anim, c);
  }

  Widget _buildEffects(Animate anim, AppAnimateConfig c) {
    final d = c.duration;
    final del = c.delay;

    switch (widget.type) {
      // ── Fade ──
      case AppAnimateType.fadeIn:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOut:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInDown:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve)
            .slideY(begin: -0.08, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInUp:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve)
            .slideY(begin: 0.08, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInLeft:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve)
            .slideX(begin: -0.08, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInRight:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve)
            .slideX(begin: 0.08, end: 0, duration: d, delay: del, curve: c.curve);

      // ── Slide ──
      case AppAnimateType.slideInUp:
        return anim.slideY(begin: 0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInDown:
        return anim.slideY(begin: -0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInLeft:
        return anim.slideX(begin: -0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideInRight:
        return anim.slideX(begin: 0.3, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutUp:
        return anim.slideY(begin: 0, end: -0.3, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutDown:
        return anim.slideY(begin: 0, end: 0.3, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutLeft:
        return anim.slideX(begin: 0, end: -0.3, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.slideOutRight:
        return anim.slideX(begin: 0, end: 0.3, duration: d, delay: del, curve: c.curve);

      // ── Zoom / Scale ──
      case AppAnimateType.zoomIn:
        return anim.scaleXY(begin: 0.3, end: 1, duration: d, delay: del, curve: c.curve)
            .fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.zoomOut:
        return anim.scaleXY(begin: 1.3, end: 0, duration: d, delay: del, curve: c.curve)
            .fadeOut(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleIn:
        return anim.scaleXY(begin: 0, end: 1, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.scaleOut:
        return anim.scaleXY(begin: 1, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.pulse:
        return anim.scaleXY(
          begin: 1, end: 1.08,
          duration: d, delay: del, curve: Curves.easeInOut,
        );
      case AppAnimateType.bounce:
        return anim.scaleXY(
          begin: 0, end: 1.15,
          duration: d, delay: del, curve: Curves.elasticOut,
        );

      // ── Rotate ──
      case AppAnimateType.rotateIn:
        return anim.rotate(begin: -0.25, end: 0, duration: d, delay: del, curve: c.curve)
            .fadeIn(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.rotateOut:
        return anim.rotate(begin: 0, end: 0.25, duration: d, delay: del, curve: c.curve)
            .fadeOut(duration: d, delay: del, curve: c.curve);
      case AppAnimateType.flipInX:
        return anim.scaleXY(begin: 1, end: 1, duration: d, delay: del)
            .then(delay: del)
            .scaleX(begin: 0, end: 1, duration: d, curve: c.curve)
            .fadeIn(duration: d * 0.5, curve: c.curve);
      case AppAnimateType.flipInY:
        return anim.scaleXY(begin: 1, end: 1, duration: d, delay: del)
            .then(delay: del)
            .scaleY(begin: 0, end: 1, duration: d, curve: c.curve)
            .fadeIn(duration: d * 0.5, curve: c.curve);
      case AppAnimateType.flipOutX:
        return anim.scaleX(begin: 1, end: 0, duration: d, delay: del, curve: c.curve)
            .fadeOut(duration: d * 0.5, curve: c.curve);
      case AppAnimateType.flipOutY:
        return anim.scaleY(begin: 1, end: 0, duration: d, delay: del, curve: c.curve)
            .fadeOut(duration: d * 0.5, curve: c.curve);

      // ── Special ──
      case AppAnimateType.shimmer:
        return anim.shimmer(duration: d, delay: del);
      case AppAnimateType.blur:
        return anim.blurXY(begin: c.begin, end: c.end, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.glow:
        return anim.boxShadow(
          duration: d, delay: del, curve: c.curve,
          begin: BoxShadow(color: Colors.transparent, blurRadius: 0),
          end: BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 20, spreadRadius: 2),
        );
      case AppAnimateType.shake:
        return anim.shake(duration: d, delay: del);
      case AppAnimateType.jello:
        return anim
            .scaleX(begin: 1, end: 1.15, duration: d * 0.25, curve: Curves.easeOut)
            .then()
            .scaleX(begin: 1.15, end: 0.9, duration: d * 0.25, curve: Curves.easeInOut)
            .then()
            .scaleX(begin: 0.9, end: 1.05, duration: d * 0.25, curve: Curves.easeInOut)
            .then()
            .scaleX(begin: 1.05, end: 1, duration: d * 0.25, curve: Curves.easeIn);
      case AppAnimateType.swing:
        return anim
            .rotate(begin: 0, end: 0.15, duration: d * 0.3, curve: Curves.easeOut)
            .then()
            .rotate(begin: 0.15, end: -0.1, duration: d * 0.3, curve: Curves.easeInOut)
            .then()
            .rotate(begin: -0.1, end: 0.05, duration: d * 0.2, curve: Curves.easeInOut)
            .then()
            .rotate(begin: 0.05, end: 0, duration: d * 0.2, curve: Curves.easeIn);
      case AppAnimateType.wobble:
        return anim
            .slideX(begin: 0, end: 0.06, duration: d * 0.2, curve: Curves.easeOut)
            .rotate(begin: 0, end: -0.03, duration: d * 0.2, curve: Curves.easeOut)
            .then()
            .slideX(begin: 0.06, end: -0.04, duration: d * 0.2, curve: Curves.easeInOut)
            .rotate(begin: -0.03, end: 0.02, duration: d * 0.2, curve: Curves.easeInOut)
            .then()
            .slideX(begin: -0.04, end: 0.02, duration: d * 0.2, curve: Curves.easeInOut)
            .rotate(begin: 0.02, end: -0.01, duration: d * 0.2, curve: Curves.easeInOut)
            .then()
            .slideX(begin: 0.02, end: 0, duration: d * 0.2, curve: Curves.easeIn)
            .rotate(begin: -0.01, end: 0, duration: d * 0.2, curve: Curves.easeIn);
      case AppAnimateType.flash:
        return anim
            .fadeIn(duration: d * 0.25, curve: Curves.easeOut)
            .then()
            .fadeOut(duration: d * 0.25, curve: Curves.easeIn)
            .then()
            .fadeIn(duration: d * 0.25, curve: Curves.easeOut)
            .then()
            .fadeOut(duration: d * 0.25, curve: Curves.easeIn);
      case AppAnimateType.rubberBand:
        return anim
            .scaleX(begin: 1, end: 1.25, duration: d * 0.3, curve: Curves.easeOut)
            .scaleY(begin: 1, end: 0.75, duration: d * 0.3, curve: Curves.easeOut)
            .then()
            .scaleX(begin: 1.25, end: 0.9, duration: d * 0.3, curve: Curves.easeInOut)
            .scaleY(begin: 0.75, end: 1.1, duration: d * 0.3, curve: Curves.easeInOut)
            .then()
            .scaleX(begin: 0.9, end: 1, duration: d * 0.2, curve: Curves.easeInOut)
            .scaleY(begin: 1.1, end: 1, duration: d * 0.2, curve: Curves.easeInOut);
      case AppAnimateType.heartbeat:
        return anim
            .scaleXY(begin: 1, end: 1.15, duration: d * 0.3, curve: Curves.easeOut)
            .then()
            .scaleXY(begin: 1.15, end: 1, duration: d * 0.3, curve: Curves.easeIn)
            .then()
            .scaleXY(begin: 1, end: 1.08, duration: d * 0.2, curve: Curves.easeOut)
            .then()
            .scaleXY(begin: 1.08, end: 1, duration: d * 0.2, curve: Curves.easeIn);

      // ── Bounce ──
      case AppAnimateType.bounceIn:
        return anim
            .scaleXY(begin: 0, end: 1.2, duration: d * 0.4, curve: Curves.easeOut)
            .then()
            .scaleXY(begin: 1.2, end: 0.9, duration: d * 0.2, curve: Curves.easeInOut)
            .then()
            .scaleXY(begin: 0.9, end: 1.05, duration: d * 0.2, curve: Curves.easeOut)
            .then()
            .scaleXY(begin: 1.05, end: 1, duration: d * 0.2, curve: Curves.easeInOut)
            .fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.bounceInDown:
        return anim
            .slideY(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceInUp:
        return anim
            .slideY(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceInLeft:
        return anim
            .slideX(begin: -0.5, end: 0, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceInRight:
        return anim
            .slideX(begin: 0.5, end: 0, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.4, curve: Curves.easeOut);
      case AppAnimateType.bounceOut:
        return anim
            .scaleXY(begin: 1, end: 1.2, duration: d * 0.3, curve: Curves.easeOut)
            .then()
            .scaleXY(begin: 1.2, end: 0, duration: d * 0.5, curve: Curves.easeIn)
            .fadeOut(duration: d * 0.6, curve: Curves.easeIn);
      case AppAnimateType.bounceOutDown:
        return anim
            .slideY(begin: 0, end: 0.3, duration: d * 0.4, curve: Curves.easeOut)
            .then()
            .slideY(begin: 0.3, end: -0.2, duration: d * 0.2, curve: Curves.easeIn)
            .then()
            .slideY(begin: -0.2, end: 0.5, duration: d * 0.4, curve: Curves.easeIn);
      case AppAnimateType.bounceOutUp:
        return anim
            .slideY(begin: 0, end: -0.3, duration: d * 0.4, curve: Curves.easeOut)
            .then()
            .slideY(begin: -0.3, end: 0.2, duration: d * 0.2, curve: Curves.easeIn)
            .then()
            .slideY(begin: 0.2, end: -0.5, duration: d * 0.4, curve: Curves.easeIn);

      // ── Elastic ──
      case AppAnimateType.elasticIn:
        return anim
            .scaleXY(begin: 0, end: 1, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d, curve: Curves.easeOut);
      case AppAnimateType.elasticOut:
        return anim
            .scaleXY(begin: 1, end: 0, duration: d, curve: Curves.elasticIn)
            .fadeOut(duration: d, curve: Curves.easeIn);
      case AppAnimateType.elasticInOut:
        return anim
            .scaleXY(begin: 0, end: 1.1, duration: d * 0.3, curve: Curves.easeOut)
            .then()
            .scaleXY(begin: 1.1, end: 0.9, duration: d * 0.2, curve: Curves.elasticIn)
            .then()
            .scaleXY(begin: 0.9, end: 1, duration: d * 0.5, curve: Curves.elasticOut);
      case AppAnimateType.elasticInDown:
        return anim
            .slideY(begin: -0.4, end: 0, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.elasticInUp:
        return anim
            .slideY(begin: 0.4, end: 0, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.5, curve: Curves.easeOut);
      case AppAnimateType.elasticInLeft:
        return anim
            .slideX(begin: -0.4, end: 0, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.5, curve: Curves.easeOut);

      // ── Combo ──
      case AppAnimateType.fadeInScale:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve)
            .scaleXY(begin: 0.8, end: 1, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInSlide:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve)
            .slideY(begin: 0.06, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeInRotate:
        return anim.fadeIn(duration: d, delay: del, curve: c.curve)
            .rotate(begin: -0.1, end: 0, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutScale:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve)
            .scaleXY(begin: 1, end: 0.8, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutSlide:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve)
            .slideY(begin: 0, end: -0.06, duration: d, delay: del, curve: c.curve);
      case AppAnimateType.fadeOutRotate:
        return anim.fadeOut(duration: d, delay: del, curve: c.curve)
            .rotate(begin: 0, end: 0.1, duration: d, delay: del, curve: c.curve);

      // ── Text / Container ──
      case AppAnimateType.typewriter:
        return anim
            .fadeIn(duration: 100.ms, delay: del);
      case AppAnimateType.textReveal:
        return anim
            .slideX(begin: -0.1, end: 0, duration: d, delay: del, curve: Curves.easeOut)
            .fadeIn(duration: d, delay: del, curve: Curves.easeOut);
      case AppAnimateType.marquee:
        return anim
            .slideX(begin: 0.5, end: -0.5, duration: const Duration(seconds: 4), curve: Curves.linear)
            .then()
            .slideX(begin: -0.5, end: 0.5, duration: const Duration(seconds: 4), curve: Curves.linear);
      case AppAnimateType.ripple:
        return anim
            .scaleXY(begin: 0.85, end: 1, duration: d, curve: Curves.elasticOut)
            .fadeIn(duration: d * 0.5, curve: Curves.easeOut);
    }
  }
}
