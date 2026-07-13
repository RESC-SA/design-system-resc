import 'package:flutter/widgets.dart';

import 'animate_types.dart';
import 'app_animate.dart';

extension AppAnimateX on Widget {
  Widget animateWith(AppAnimateType type, {AppAnimateConfig? config, VoidCallback? onComplete}) {
    return AppAnimate(
      type: type,
      config: config,
      child: this,
      onComplete: onComplete,
    );
  }

  Widget fadeIn({Duration? duration, Duration? delay, Curve? curve}) =>
      AppAnimate(
        type: AppAnimateType.fadeIn,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 400),
          delay: delay ?? Duration.zero,
          curve: curve ?? Curves.easeOut,
        ),
        child: this,
      );

  Widget fadeInUp({Duration? duration, Curve? curve}) =>
      AppAnimate(
        type: AppAnimateType.fadeInUp,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 500),
          curve: curve ?? Curves.easeOut,
        ),
        child: this,
      );

  Widget slideInUp({Duration? duration, Curve? curve}) =>
      AppAnimate(
        type: AppAnimateType.slideInUp,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 500),
          curve: curve ?? Curves.easeOut,
        ),
        child: this,
      );

  Widget pulse({Duration? duration, bool loop = true}) =>
      AppAnimate(
        type: AppAnimateType.pulse,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 900),
          loop: loop,
          reverse: true,
        ),
        child: this,
      );

  Widget bounce({Duration? duration}) =>
      AppAnimate(
        type: AppAnimateType.bounce,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
        ),
        child: this,
      );

  Widget shake({Duration? duration}) =>
      AppAnimate(
        type: AppAnimateType.shake,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 600),
        ),
        child: this,
      );

  Widget shimmer({Duration? duration}) =>
      AppAnimate(
        type: AppAnimateType.shimmer,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 1200),
          loop: true,
          reverse: true,
        ),
        child: this,
      );

  Widget scaleIn({Duration? duration, Curve? curve}) =>
      AppAnimate(
        type: AppAnimateType.scaleIn,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 400),
          curve: curve ?? Curves.elasticOut,
        ),
        child: this,
      );

  Widget rotateIn({Duration? duration, Curve? curve}) =>
      AppAnimate(
        type: AppAnimateType.rotateIn,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 600),
          curve: curve ?? Curves.easeOut,
        ),
        child: this,
      );

  Widget zoomIn({Duration? duration, Curve? curve}) =>
      AppAnimate(
        type: AppAnimateType.zoomIn,
        config: AppAnimateConfig(
          duration: duration ?? const Duration(milliseconds: 500),
          curve: curve ?? Curves.easeOut,
        ),
        child: this,
      );
}
