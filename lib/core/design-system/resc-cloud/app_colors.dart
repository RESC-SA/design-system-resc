import 'package:flutter/material.dart';

/// **RESC IoT — Calm Saudi Premium tokens**
///
/// All neutrals are warm-tinted (OKLCH chroma 0.005–0.012, hue ~95°) so the
/// surface feels like fine sand at midday rather than clinical white.
/// All public names preserved for backward compatibility; values updated.
class AppColors {
  AppColors._();

  // ───────────────────────────────────────────────────────────────────────
  // Brand
  // ───────────────────────────────────────────────────────────────────────
  /// Brand green deepened slightly so it stays legible on warm sand surfaces.
  /// `oklch(0.62 0.17 142)` → `#3F9D43`. (Was `#51B848`.)
  static const Color primary = Color(0xFF3F9D43);
  static const Color primaryLight = Color(0xFFDCEED6);
  static const Color primaryDark = Color(0xFF2E7D32);
  static const Color primaryContainer = Color(0xFFDCEED6);

  /// Secondary is reserved — used only for warning/highlight roles, never decoratively.
  static const Color secondary = Color(0xFFD4A03B); // warm amber
  static const Color secondaryLight = Color(0xFFF5DDA8);
  static const Color secondaryDark = Color(0xFF9C6F1F);
  static const Color secondaryContainer = Color(0xFFF7E6BC);

  // ───────────────────────────────────────────────────────────────────────
  // Surfaces (light)
  // ───────────────────────────────────────────────────────────────────────
  /// Scaffold/base background. Sandy off-white, **never `#FFFFFF`**.
  static const Color surface = Color(0xFFFCFAF6);

  /// Raised surface (cards, sheets, top app bar fill).
  static const Color surfaceRaised = Color(0xFFF6F3EC);

  /// Sunken surface (inputs, chart wells, code blocks).
  static const Color surfaceSunken = Color(0xFFEDE9DF);

  // Material 3 alias names — mapped onto the new tinted scale.
  static const Color surfaceVariant = surfaceRaised;
  static const Color surfaceContainer = surfaceRaised;
  static const Color surfaceContainerHigh = surfaceSunken;
  static const Color surfaceContainerHighest = Color(0xFFE3DFD2);

  static const Color background = surface;
  static const Color backgroundDark = Color(0xFF1B1815);

  // ───────────────────────────────────────────────────────────────────────
  // Text / on-* (light)
  // ───────────────────────────────────────────────────────────────────────
  static const Color onPrimary = Color(0xFFFCFAF6);
  static const Color onSecondary = Color(0xFF1F2620);
  static const Color textPrimary = Color(0xFF1F2620);
  static const Color textSecondary = Color(0xFF5C6660);
  static const Color textTertiary = Color(0xFF8B8576);
  static const Color onSurface = textPrimary;
  static const Color onBackground = textPrimary;
  static const Color onSurfaceVariant = textSecondary;

  // ───────────────────────────────────────────────────────────────────────
  // Status (used **only** for status, never decoratively)
  // ───────────────────────────────────────────────────────────────────────
  static const Color status = Color(0xFF3F8AC9); // info
  static const Color info = Color(0xFF3F8AC9);
  static const Color infoContainer = Color(0xFFD7E8F5);

  static const Color error = Color(0xFFD44B3D);
  static const Color critical = Color(0xFFD44B3D);
  static const Color errorContainer = Color(0xFFF8DCD7);
  static const Color onError = Color(0xFFFCFAF6);
  static const Color onErrorContainer = Color(0xFF4A1612);

  static const Color success = Color(0xFF3DA855);
  static const Color successContainer = Color(0xFFD3ECD8);
  static const Color warning = Color(0xFFD4A03B);
  static const Color warningContainer = Color(0xFFF5E5BD);

  // ───────────────────────────────────────────────────────────────────────
  // Gradients (kept for back-compat; used sparingly — prefer flat surfaces)
  // ───────────────────────────────────────────────────────────────────────
  static const Color gradientGreenStart = Color(0xFF2E7D32);
  static const Color gradientGreenEnd = Color(0xFF6FBE6B);

  static const Color gradientBackgroundStart = surface;
  static const Color gradientBackgroundEnd = surfaceRaised;

  // ───────────────────────────────────────────────────────────────────────
  // Neutral scale (light) — every step warm-tinted toward sand.
  // ───────────────────────────────────────────────────────────────────────
  static const Color neutral0 = Color(0xFFFCFAF6);
  static const Color neutral10 = Color(0xFFF8F5EE);
  static const Color neutral20 = Color(0xFFF1ECE0);
  static const Color neutral30 = Color(0xFFE3DED1);
  static const Color neutral40 = Color(0xFFD0CABB);
  static const Color neutral50 = Color(0xFFA9A493);
  static const Color neutral60 = Color(0xFF8B8576);
  static const Color neutral70 = Color(0xFF6E6A5E);
  static const Color neutral80 = Color(0xFF52503F);
  static const Color neutral90 = Color(0xFF3A3A2E);
  static const Color neutral100 = Color(0xFF1F2620);

  static const Color neutral = neutral60;

  // ───────────────────────────────────────────────────────────────────────
  // Surfaces (dark) — warm near-black, never blue-black.
  // ───────────────────────────────────────────────────────────────────────
  static const Color darkSurface = Color(0xFF1B1815);
  static const Color darkBackground = Color(0xFF1B1815);
  static const Color darkSurfaceRaised = Color(0xFF23201C);
  static const Color darkSurfaceSunken = Color(0xFF161310);
  static const Color darkSurfaceVariant = darkSurfaceRaised;
  static const Color darkOnSurface = Color(0xFFF0EDE6);
  static const Color darkOnBackground = Color(0xFFF0EDE6);

  static const Color darkPrimary = Color(
    0xFF5BB955,
  ); // brand brightened for dark

  // ───────────────────────────────────────────────────────────────────────
  // Misc / decoration
  // ───────────────────────────────────────────────────────────────────────
  static const Color accent = Color(0xFFD4A03B);
  static const Color highlight = Color(0xFF3DA855);

  static const Color border = Color(0xFFDCD7C8);
  static const Color divider = Color(0xFFDCD7C8);

  static const Color shadow = Color(0x141B1815); // 8% warm-black
  static const Color shadowDark = Color(
    0x29000000,
  ); // 16% pure-black under dark

  // Dark neutral scale — mirrors warm hue.
  static const Color darkNeutral10 = Color(0xFF1B1815);
  static const Color darkNeutral20 = Color(0xFF23201C);
  static const Color darkNeutral30 = Color(0xFF2C2924);
  static const Color darkNeutral40 = Color(0xFF3A3631);
  static const Color darkNeutral50 = Color(0xFF55504A);
  static const Color darkNeutral60 = Color(0xFF7A746B);
  static const Color darkNeutral70 = Color(0xFFB0AAA0);
  static const Color darkNeutral80 = Color(0xFFD0CCC4);
  static const Color darkNeutral90 = Color(0xFFF0EDE6);
}

/// Theme-aware color helpers. Use these inside widgets instead of hardcoded
/// `Colors.white` / `Colors.black` / `AppColors.primary` etc.
extension AppColorsExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // ── Surfaces ──────────────────────────────────────────────────────────
  Color get surfaceColor => colors.surface;
  Color get surfaceRaised =>
      isDark ? const Color(0xFF242423) : AppColors.surfaceRaised;
  Color get surfaceTransparent =>
      isDark ? const Color(0x00000000) : const Color.fromARGB(255, 255, 255, 255);
  Color get surfaceSunken => isDark ? Colors.transparent : Colors.transparent;
  Color get surfaceContainerHighestColor => colors.surfaceContainerHighest;

  // ── Text ──────────────────────────────────────────────────────────────
  Color get onSurfaceColor => colors.onSurface;
  Color get onSurfaceVariantColor => colors.onSurfaceVariant;
  Color get textPrimaryColor => colors.onSurface;
  Color get textSecondaryColor => colors.onSurfaceVariant;
  Color get textTertiaryColor =>
      isDark ? AppColors.darkNeutral60 : AppColors.textTertiary;
  Color get textHintColor => textTertiaryColor;
  Color get textOnPrimaryColor => AppColors.onPrimary;

  // ── Borders / dividers ────────────────────────────────────────────────
  Color get outlineColor => colors.outline;
  Color get borderSubtle => isDark ? AppColors.darkNeutral40 : AppColors.border;
  Color get dividerColor => borderSubtle;
  Color get borderColor => borderSubtle;
  Color get cardBorder => borderSubtle;

  // ── Shadows ───────────────────────────────────────────────────────────
  Color get shadowColor => colors.shadow;
  Color get shadowSoft => isDark
      ? const Color(0x33000000) // 20% black for dark elevations
      : const Color(0x141B1815); // 8% warm-black for light elevations
  Color get shadowColorLight => shadowSoft;

  // ── Brand / accents ───────────────────────────────────────────────────
  Color get primaryColor => isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get primaryContainerColor =>
      isDark ? const Color(0xFF1F3D22) : AppColors.primaryContainer;
  Color get secondaryColor => AppColors.secondary;
  Color get accentColor => AppColors.accent;
  Color get brandSoft => primaryContainerColor;

  // ── Component helpers (legacy) ────────────────────────────────────────
  Color get cardBackground => surfaceRaised;
  Color get inputBackground => surfaceSunken;
  Color get subtleBackground => surfaceSunken;

  Color get iconColorPrimary => colors.onSurface;
  Color get iconColorSecondary => colors.onSurfaceVariant;

  Color get tabBarBackground => surfaceRaised;
  Color get tabIndicatorColor => primaryColor;
  Color get tabSelectedTextColor => AppColors.onPrimary;
  Color get tabUnselectedTextColor => textSecondaryColor;

  Color get progressTrackColor => surfaceSunken;

  // ── Liquid-glass card ─────────────────────────────────────────────────
  /// Card fill: warm off-white in light, translucent white in dark.
  Color get liquidCardFill =>
      isDark ? const Color(0x0BFFFFFF) : AppColors.onPrimary;

  /// Card shadow matching the fill mode.
  List<BoxShadow> get liquidCardShadow => isDark
      ? const [
          BoxShadow(
            color: Color(0x59000000),
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ]
      : const [
          BoxShadow(
            color: Color(0x141B1815),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ];

  /// Page scaffold background: deep near-black in dark, warm surface in light.
  Color get scaffoldBg => isDark ? const Color(0xFF242423) : AppColors.surface;
}
