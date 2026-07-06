import 'package:flutter/widgets.dart';

/// **Spacing scale (4-step).** Vary spacing for rhythm — same padding everywhere is monotony.
class AppSpacing {
  AppSpacing._();

  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double x3l = 32;
  static const double x4l = 40;
  static const double x5l = 56;

  // Horizontal page padding
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets pagePaddingTight = EdgeInsets.symmetric(horizontal: md);

  // Common card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingTight = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingLoose = EdgeInsets.all(xl);

  // Section spacing
  static const SizedBox vGapXs = SizedBox(height: xs);
  static const SizedBox vGapSm = SizedBox(height: sm);
  static const SizedBox vGapMd = SizedBox(height: md);
  static const SizedBox vGapLg = SizedBox(height: lg);
  static const SizedBox vGapXl = SizedBox(height: xl);
  static const SizedBox vGapXxl = SizedBox(height: xxl);

  static const SizedBox hGapXs = SizedBox(width: xs);
  static const SizedBox hGapSm = SizedBox(width: sm);
  static const SizedBox hGapMd = SizedBox(width: md);
  static const SizedBox hGapLg = SizedBox(width: lg);
}
