import 'package:flutter/animation.dart';

/// **Motion tokens.** Single source of truth for durations and curves.
///
/// All animations in the app must reference these — never inline a duration
/// or curve in a widget.
class AppMotion {
  AppMotion._();

  // ── Durations ───────────────────────────────────────────────────────────
  static const Duration instant = Duration(milliseconds: 80);
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration base = Duration(milliseconds: 240);
  static const Duration slow = Duration(milliseconds: 320);
  static const Duration slower = Duration(milliseconds: 480);
  static const Duration number = Duration(milliseconds: 600);

  // ── Curves (ease-out family — never bounce / elastic) ───────────────────
  /// Default curve. Use for most transitions.
  static const Curve easeOutQuart = Cubic(0.25, 1.0, 0.5, 1.0);

  /// Stronger ease for entrances (sheets, modals).
  static const Curve easeOutQuint = Cubic(0.22, 1.0, 0.36, 1.0);

  /// Sharpest ease — use for chart morphs, telemetry redraws.
  static const Curve easeOutExpo = Cubic(0.16, 1.0, 0.3, 1.0);

  /// Symmetric — only for short emphasis pulses (focus rings, taps).
  static const Curve easeInOut = Cubic(0.45, 0, 0.55, 1.0);

  // ── Springs (for physics-driven values like pivot angle) ────────────────
  static const SpringDescription spring = SpringDescription(
    mass: 1,
    stiffness: 100,
    damping: 12,
  );

  static const SpringDescription springSnappy = SpringDescription(
    mass: 1,
    stiffness: 180,
    damping: 16,
  );
}
