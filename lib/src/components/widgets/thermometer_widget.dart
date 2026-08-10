import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Available fluid color themes for the thermometer
enum ThermometerFluidTheme {
  redSpirit(
    primary: Color(0xFFFF2A2A),
    deep: Color(0xFF9E0B0B),
    highlight: Color(0xFFFF8A80),
    glow: Color(0x66FF2A2A),
  ),
  mercury(
    primary: Color(0xFFCFD8DC),
    deep: Color(0xFF607D8B),
    highlight: Color(0xFFECEFF1),
    glow: Color(0x44B0BEC5),
  ),
  cryoBlue(
    primary: Color(0xFF00B0FF),
    deep: Color(0xFF0060B6),
    highlight: Color(0xFF80D8FF),
    glow: Color(0x6600B0FF),
  ),
  emerald(
    primary: Color(0xFF00E676),
    deep: Color(0xFF007E33),
    highlight: Color(0xFFB9F6CA),
    glow: Color(0x6600E676),
  ),
  amber(
    primary: Color(0xFFFF9100),
    deep: Color(0xFFB35400),
    highlight: Color(0xFFFFD180),
    glow: Color(0x66FF9100),
  );

  final Color primary;
  final Color deep;
  final Color highlight;
  final Color glow;

  const ThermometerFluidTheme({
    required this.primary,
    required this.deep,
    required this.highlight,
    required this.glow,
  });

  /// Automatically selects a fluid theme based on temperature in Celsius
  static ThermometerFluidTheme fromCelsius(double celsius) {
    if (celsius < 5) return ThermometerFluidTheme.cryoBlue;
    if (celsius < 18) return ThermometerFluidTheme.mercury;
    if (celsius < 28) return ThermometerFluidTheme.emerald;
    if (celsius < 38) return ThermometerFluidTheme.amber;
    return ThermometerFluidTheme.redSpirit;
  }
}

/// Readout display styles for the thermometer
enum ThermometerReadoutStyle {
  /// No floating readout indicator
  none,

  /// 3-tick cylindrical rolling drum / wheel indicator with animated top & bottom faded ticks (60% hidden)
  circularWheel,

  /// Clean minimal badge
  simpleBadge,
}

/// A 100% photorealistic glass thermometer widget with precision graduated scale (ruler/wheel).
///
/// Features:
/// - 3D glass stem with specular refraction, inner shadows, and edge highlights
/// - 3D spherical glass bulb with volumetric fluid glow and curved reflection glint
/// - Realistic liquid column with cylindrical gradient lighting and curved meniscus surface
/// - Precision graduated scale with major ticks (5, 10, 15...) and minor tick micro-labels
/// - 3-tick 3D cylindrical rolling wheel readout option (top/bottom faded by 60%, active center tick)
/// - Interactive touch & drag support to adjust temperature
/// - Smooth animated fluid transitions
class ThermometerWidget extends StatefulWidget {
  /// Temperature in Celsius (-30 to +50 by default).
  final double? celsius;

  /// Temperature in Fahrenheit (-20 to 125 by default).
  final double? fahrenheit;

  /// Minimum Celsius range for the scale (default: -30).
  final double minCelsius;

  /// Maximum Celsius range for the scale (default: 50).
  final double maxCelsius;

  /// Minimum Fahrenheit range for the scale (default: -20).
  final double minFahrenheit;

  /// Maximum Fahrenheit range for the scale (default: 125).
  final double maxFahrenheit;

  /// Total widget width (optional, automatically adapts to parent constraints if null).
  final double? width;

  /// Total widget height (optional, automatically adapts to parent constraints if null).
  final double? height;

  /// Whether to display Fahrenheit scale on the left.
  final bool showFahrenheit;

  /// Whether to display Celsius scale on the right.
  final bool showCelsius;

  /// Whether to display micro-numbers on minor ticks (like a precision ruler/wheel).
  final bool showMinorLabels;

  /// Interval for major ticks on Celsius scale (default: 10, or 5).
  final int celsiusMajorStep;

  /// Interval for medium ticks on Celsius scale (default: 5).
  final int celsiusMediumStep;

  /// Interval for minor ticks on Celsius scale (default: 1).
  final int celsiusMinorStep;

  /// Interval for major ticks on Fahrenheit scale (default: 20).
  final int fahrenheitMajorStep;

  /// Fluid color theme.
  final ThermometerFluidTheme fluidTheme;

  /// Readout display style (default: circularWheel).
  final ThermometerReadoutStyle readoutStyle;

  /// Custom fluid primary color (overrides fluidTheme if provided).
  final Color? customFluidColor;

  /// Whether to show the top sun / weather badge.
  final bool showSunIcon;

  /// Custom top icon widget (optional).
  final Widget? topIcon;

  /// Whether the user can drag/tap on the thermometer to change temperature.
  final bool interactive;

  /// Callback when temperature changes (provides Celsius value).
  final ValueChanged<double>? onChanged;

  /// Callback when dragging starts.
  final VoidCallback? onDragStart;

  /// Callback when dragging ends.
  final VoidCallback? onDragEnd;

  /// Animation duration when temperature value changes programmatically.
  final Duration animationDuration;

  const ThermometerWidget({
    super.key,
    this.celsius,
    this.fahrenheit,
    this.minCelsius = -30,
    this.maxCelsius = 50,
    this.minFahrenheit = -20,
    this.maxFahrenheit = 125,
    this.width,
    this.height,
    this.showFahrenheit = true,
    this.showCelsius = true,
    this.showMinorLabels = true,
    this.celsiusMajorStep = 10,
    this.celsiusMediumStep = 5,
    this.celsiusMinorStep = 1,
    this.fahrenheitMajorStep = 20,
    this.fluidTheme = ThermometerFluidTheme.redSpirit,
    this.readoutStyle = ThermometerReadoutStyle.circularWheel,
    this.customFluidColor,
    this.showSunIcon = true,
    this.topIcon,
    this.interactive = true,
    this.onChanged,
    this.onDragStart,
    this.onDragEnd,
    this.animationDuration = const Duration(milliseconds: 400),
  });

  @override
  State<ThermometerWidget> createState() => _ThermometerWidgetState();
}

class _ThermometerWidgetState extends State<ThermometerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animValue;

  double _currentCelsius = 32.0;

  @override
  void initState() {
    super.initState();
    _currentCelsius = _resolveInitialCelsius();

    _animController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animValue = Tween<double>(
      begin: _currentCelsius,
      end: _currentCelsius,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
  }

  double _resolveInitialCelsius() {
    if (widget.celsius != null) {
      return widget.celsius!.clamp(widget.minCelsius, widget.maxCelsius);
    }
    if (widget.fahrenheit != null) {
      return ((widget.fahrenheit! - 32) * 5 / 9)
          .clamp(widget.minCelsius, widget.maxCelsius);
    }
    return 32.0;
  }

  @override
  void didUpdateWidget(ThermometerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final targetCelsius = _resolveInitialCelsius();
    if ((targetCelsius - _currentCelsius).abs() > 0.05) {
      _animValue = Tween<double>(
        begin: _currentCelsius,
        end: targetCelsius,
      ).animate(CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutCubic,
      ));
      _animController.forward(from: 0.0);
      _currentCelsius = targetCelsius;
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleInteraction(Offset localPosition, Size size) {
    if (!widget.interactive && widget.onChanged == null) return;

    final h = size.height;
    final tubeTop = h * 0.09;
    final tubeBottom = h * 0.84;
    final span = tubeBottom - tubeTop;

    // Invert Y: top is maxCelsius, bottom is minCelsius
    final clampedY = localPosition.dy.clamp(tubeTop, tubeBottom);
    final progress = (tubeBottom - clampedY) / span; // 0.0 (min) to 1.0 (max)
    final newCelsius =
        widget.minCelsius + progress * (widget.maxCelsius - widget.minCelsius);

    setState(() {
      _currentCelsius = newCelsius;
    });

    widget.onChanged?.call(newCelsius);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveW = widget.width ??
            (constraints.hasBoundedWidth && constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : 230.0);
        final effectiveH = widget.height ??
            (constraints.hasBoundedHeight && constraints.maxHeight.isFinite
                ? constraints.maxHeight
                : 440.0);

        final scaleFactor =
            (math.min(effectiveW / 220, effectiveH / 420)).clamp(0.45, 2.5);

        // Smart horizontal alignment if only one scale is displayed
        final double stemAlignmentX;
        if (widget.showCelsius && !widget.showFahrenheit) {
          stemAlignmentX = -0.3; // stem slightly left, Celsius scale on right
        } else if (!widget.showCelsius && widget.showFahrenheit) {
          stemAlignmentX = 0.3; // stem slightly right, Fahrenheit scale on left
        } else {
          stemAlignmentX = 0.0; // centered
        }

        return AnimatedBuilder(
          animation: _animController,
          builder: (context, child) {
            final animatedCelsius =
                _animController.isAnimating ? _animValue.value : _currentCelsius;
            final currentFahrenheit = animatedCelsius * 9 / 5 + 32;

            return SizedBox(
              width: effectiveW,
              height: effectiveH,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onVerticalDragStart: (details) {
                  if (widget.interactive) {
                    HapticFeedback.selectionClick();
                    widget.onDragStart?.call();
                    _handleInteraction(
                        details.localPosition, Size(effectiveW, effectiveH));
                  }
                },
                onVerticalDragUpdate: (details) {
                  if (widget.interactive) {
                    _handleInteraction(
                        details.localPosition, Size(effectiveW, effectiveH));
                  }
                },
                onVerticalDragEnd: (_) => widget.onDragEnd?.call(),
                onTapDown: (details) {
                  if (widget.interactive) {
                    HapticFeedback.lightImpact();
                    _handleInteraction(
                        details.localPosition, Size(effectiveW, effectiveH));
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomPaint(
                      size: Size(effectiveW, effectiveH),
                      painter: _RealisticThermometerPainter(
                        celsius: animatedCelsius,
                        fahrenheit: currentFahrenheit,
                        minCelsius: widget.minCelsius,
                        maxCelsius: widget.maxCelsius,
                        minFahrenheit: widget.minFahrenheit,
                        maxFahrenheit: widget.maxFahrenheit,
                        showFahrenheit: widget.showFahrenheit,
                        showCelsius: widget.showCelsius,
                        showMinorLabels: widget.showMinorLabels,
                        celsiusMajorStep: widget.celsiusMajorStep,
                        celsiusMediumStep: widget.celsiusMediumStep,
                        celsiusMinorStep: widget.celsiusMinorStep,
                        fahrenheitMajorStep: widget.fahrenheitMajorStep,
                        fluidTheme: widget.fluidTheme,
                        readoutStyle: widget.readoutStyle,
                        customFluidColor: widget.customFluidColor,
                        isDark: isDark,
                        scaleFactor: scaleFactor,
                      ),
                    ),
                    if (widget.showSunIcon)
                      Align(
                        alignment: Alignment(stemAlignmentX, -0.96),
                        child: widget.topIcon ??
                            _buildDefaultTopBadge(isDark, scaleFactor),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDefaultTopBadge(bool isDark, double scaleFactor) {
    final badgeColor = isDark ? const Color(0xFF282C35) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF4A5160) : const Color(0xFFD0D7DE);
    final badgeSize = (36.0 * scaleFactor).clamp(20.0, 52.0);
    final iconSize = (20.0 * scaleFactor).clamp(12.0, 30.0);

    return Container(
      width: badgeSize,
      height: badgeSize,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5 * scaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
            blurRadius: 8 * scaleFactor,
            offset: Offset(0, 3 * scaleFactor),
          ),
          if (!isDark)
            BoxShadow(
              color: const Color(0x22FFFFFF),
              blurRadius: 4 * scaleFactor,
              offset: Offset(0, -1 * scaleFactor),
            ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.wb_sunny_rounded,
          color: const Color(0xFFFFA000),
          size: iconSize,
        ),
      ),
    );
  }
}

/// Custom painter delivering 100% photorealistic glass & liquid physics.
class _RealisticThermometerPainter extends CustomPainter {
  final double celsius;
  final double fahrenheit;
  final double minCelsius;
  final double maxCelsius;
  final double minFahrenheit;
  final double maxFahrenheit;
  final bool showFahrenheit;
  final bool showCelsius;
  final bool showMinorLabels;
  final int celsiusMajorStep;
  final int celsiusMediumStep;
  final int celsiusMinorStep;
  final int fahrenheitMajorStep;
  final ThermometerFluidTheme fluidTheme;
  final ThermometerReadoutStyle readoutStyle;
  final Color? customFluidColor;
  final bool isDark;
  final double scaleFactor;

  _RealisticThermometerPainter({
    required this.celsius,
    required this.fahrenheit,
    required this.minCelsius,
    required this.maxCelsius,
    required this.minFahrenheit,
    required this.maxFahrenheit,
    required this.showFahrenheit,
    required this.showCelsius,
    required this.showMinorLabels,
    required this.celsiusMajorStep,
    required this.celsiusMediumStep,
    required this.celsiusMinorStep,
    required this.fahrenheitMajorStep,
    required this.fluidTheme,
    required this.readoutStyle,
    required this.customFluidColor,
    required this.isDark,
    this.scaleFactor = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Smart horizontal alignment: if only Celsius is shown, shift stem left to give scale room
    final double cx;
    if (showCelsius && !showFahrenheit) {
      cx = (w * 0.35).clamp(25.0, w * 0.45);
    } else if (!showCelsius && showFahrenheit) {
      cx = (w * 0.65).clamp(w * 0.55, w - 25.0);
    } else {
      cx = w * 0.5;
    }

    // Geometry dimensions scaled dynamically
    final tubeOuterWidth = (w * 0.14).clamp(18.0 * scaleFactor, 40.0 * scaleFactor);
    final tubeInnerWidth = tubeOuterWidth * 0.58; // inner capillary bore
    final bulbRadius = tubeOuterWidth * 1.25;

    final tubeTop = h * 0.085;
    final tubeBottom = h * 0.835;
    final bulbCenterY = tubeBottom + bulbRadius * 0.48;

    // 1. Draw outer glass casing & backing plate
    _drawOuterGlassCasing(
      canvas,
      cx,
      tubeTop,
      tubeBottom,
      tubeOuterWidth,
      bulbRadius,
      bulbCenterY,
    );

    // 2. Draw dark inner capillary bore channel
    _drawCapillaryBore(
      canvas,
      cx,
      tubeTop,
      tubeBottom,
      tubeInnerWidth,
      bulbRadius * 0.78,
      bulbCenterY,
    );

    // 3. Draw realistic volumetric fluid (stem column + meniscus + 3D bulb)
    _drawRealisticFluid(
      canvas,
      cx,
      tubeTop,
      tubeBottom,
      tubeInnerWidth,
      bulbRadius * 0.82,
      bulbCenterY,
    );

    // 4. Draw realistic glass reflections, specular highlights, and refraction
    _drawGlassReflections(
      canvas,
      cx,
      tubeTop,
      tubeBottom,
      tubeOuterWidth,
      bulbRadius,
      bulbCenterY,
    );

    // 5. Draw precision graduated ruler scale with micro-numbers
    _drawGraduatedScale(
      canvas,
      size,
      cx,
      tubeOuterWidth,
      tubeTop,
      tubeBottom,
    );
  }

  /// Draws the outer thick glass silhouette with drop shadows and beveling
  void _drawOuterGlassCasing(
    Canvas canvas,
    double cx,
    double top,
    double bottom,
    double tubeW,
    double bulbR,
    double bulbCy,
  ) {
    final outerPath = _buildThermometerPath(
      cx,
      top - tubeW * 0.45,
      bottom,
      tubeW + 10,
      bulbR + 6,
      bulbCy,
    );

    // Ambient drop shadow behind thermometer
    canvas.drawShadow(
      outerPath,
      isDark ? const Color(0x99000000) : const Color(0x33000000),
      10.0,
      false,
    );

    // Outer frosted/translucent glass bezel
    final bezelPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [
                const Color(0xFF383E4A),
                const Color(0xFF282C34),
                const Color(0xFF1E2229),
                const Color(0xFF2C313B),
              ]
            : [
                const Color(0xFFF7F9FC),
                const Color(0xFFFFFFFF),
                const Color(0xFFECEFF4),
                const Color(0xFFE2E8F0),
              ],
        stops: const [0.0, 0.25, 0.75, 1.0],
      ).createShader(Rect.fromLTWH(cx - tubeW - 10, top - 30, (tubeW + 10) * 2, bottom - top + 80));

    canvas.drawPath(outerPath, bezelPaint);

    // Thin glass outline stroke
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
                const Color(0x66FFFFFF),
                const Color(0x22FFFFFF),
                const Color(0x05FFFFFF),
                const Color(0x44FFFFFF),
              ]
            : [
                const Color(0xAAFFFFFF),
                const Color(0x44000000),
                const Color(0x11000000),
                const Color(0x88FFFFFF),
              ],
      ).createShader(Rect.fromLTWH(cx - tubeW - 10, top - 30, (tubeW + 10) * 2, bottom - top + 80));

    canvas.drawPath(outerPath, outlinePaint);
  }

  /// Draws the inner hollow capillary channel (the vacuum channel)
  void _drawCapillaryBore(
    Canvas canvas,
    double cx,
    double top,
    double bottom,
    double innerW,
    double innerBulbR,
    double bulbCy,
  ) {
    final borePath = _buildThermometerPath(
      cx,
      top,
      bottom,
      innerW,
      innerBulbR,
      bulbCy,
    );

    // Deep dark channel background
    final borePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [
                const Color(0xFF121418),
                const Color(0xFF23272F),
                const Color(0xFF16191E),
              ]
            : [
                const Color(0xFF2A2E37),
                const Color(0xFF3B414E),
                const Color(0xFF252932),
              ],
      ).createShader(Rect.fromLTWH(cx - innerW, top, innerW * 2, bottom - top + 60));

    canvas.drawPath(borePath, borePaint);

    // Inner shadow at tube edges for depth
    final innerShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0x88000000);
    canvas.drawPath(borePath, innerShadowPaint);
  }

  /// Draws the 100% photorealistic liquid with cylindrical 3D shader, bulb volume, and meniscus
  void _drawRealisticFluid(
    Canvas canvas,
    double cx,
    double top,
    double bottom,
    double innerW,
    double fluidBulbR,
    double bulbCy,
  ) {
    final primary = customFluidColor ?? fluidTheme.primary;
    final deep = fluidTheme.deep;
    final highlight = fluidTheme.highlight;

    // Linear mapping for fluid column height based on Celsius
    final t = ((celsius - minCelsius) / (maxCelsius - minCelsius)).clamp(0.0, 1.0);
    final fillTopY = bottom - (bottom - top) * t;

    final fluidClipPath = _buildThermometerPath(
      cx,
      top,
      bottom,
      innerW,
      fluidBulbR,
      bulbCy,
    );

    canvas.save();
    canvas.clipPath(fluidClipPath);

    // Fluid column rectangle
    final fluidRect = Rect.fromLTRB(
      cx - innerW * 1.2,
      fillTopY,
      cx + innerW * 1.2,
      bottom + fluidBulbR * 2,
    );

    // 3D cylindrical liquid shader (dark sides, bright center streak)
    final fluidShader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        deep,
        primary,
        highlight,
        primary,
        deep,
      ],
      stops: const [0.0, 0.25, 0.5, 0.78, 1.0],
    ).createShader(fluidRect);

    final fluidPaint = Paint()..shader = fluidShader;
    canvas.drawRect(fluidRect, fluidPaint);

    // Liquid Meniscus (realistic curved dome at top of column)
    if (t > 0.01) {
      final meniscusHeight = innerW * 0.45;
      final meniscusRect = Rect.fromCenter(
        center: Offset(cx, fillTopY),
        width: innerW,
        height: meniscusHeight,
      );

      // Meniscus specular arc highlight
      final meniscusHighlightPaint = Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.4),
          radius: 0.7,
          colors: [
            Colors.white.withValues(alpha: 0.95),
            highlight.withValues(alpha: 0.8),
            primary.withValues(alpha: 0.0),
          ],
        ).createShader(meniscusRect);

      canvas.drawOval(meniscusRect, meniscusHighlightPaint);
    }

    canvas.restore();

    // 3D Spherical Liquid Bulb with realistic radial depth and specular glow
    final bulbRect = Rect.fromCircle(center: Offset(cx, bulbCy), radius: fluidBulbR);
    final bulbShader = RadialGradient(
      center: const Alignment(-0.35, -0.35),
      radius: 0.85,
      colors: [
        highlight,
        primary,
        deep,
        Color.lerp(deep, Colors.black, 0.4)!,
      ],
      stops: const [0.0, 0.35, 0.75, 1.0],
    ).createShader(bulbRect);

    final bulbPaint = Paint()..shader = bulbShader;
    canvas.drawCircle(Offset(cx, bulbCy), fluidBulbR, bulbPaint);

    // Bulb inner fluid glow (vibrant center)
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.2),
        radius: 0.45,
        colors: [
          Colors.white.withValues(alpha: 0.4),
          primary.withValues(alpha: 0.1),
          Colors.transparent,
        ],
      ).createShader(bulbRect);
    canvas.drawCircle(Offset(cx, bulbCy), fluidBulbR * 0.65, glowPaint);
  }

  /// Draws 100% realistic glass reflections: longitudinal specular streaks & bulb arc glint
  void _drawGlassReflections(
    Canvas canvas,
    double cx,
    double top,
    double bottom,
    double tubeW,
    double bulbR,
    double bulbCy,
  ) {
    // 1. Main sharp glass reflection line running down left side of tube
    final streakLeft = cx - tubeW * 0.36;
    final streakWidth = tubeW * 0.14;
    final streakRect = Rect.fromLTWH(
      streakLeft,
      top + tubeW * 0.3,
      streakWidth,
      bottom - top - tubeW * 0.2,
    );

    final streakPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.75),
          Colors.white.withValues(alpha: 0.55),
          Colors.white.withValues(alpha: 0.15),
        ],
        stops: const [0.0, 0.12, 0.7, 1.0],
      ).createShader(streakRect);

    final streakRRect = RRect.fromRectAndRadius(streakRect, Radius.circular(streakWidth / 2));
    canvas.drawRRect(streakRRect, streakPaint);

    // 2. Soft secondary glass reflection along right edge
    final rightStreakLeft = cx + tubeW * 0.24;
    final rightStreakWidth = tubeW * 0.08;
    final rightStreakRect = Rect.fromLTWH(
      rightStreakLeft,
      top + tubeW * 0.6,
      rightStreakWidth,
      bottom - top - tubeW * 0.6,
    );
    final rightStreakPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.25),
          Colors.white.withValues(alpha: 0.1),
        ],
      ).createShader(rightStreakRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rightStreakRect, Radius.circular(rightStreakWidth / 2)),
      rightStreakPaint,
    );

    // 3. Curved specular crescent arc reflection on the glass bulb
    final bulbGlintPath = Path();
    final glintCenter = Offset(cx - bulbR * 0.3, bulbCy - bulbR * 0.3);
    final glintR = bulbR * 0.52;

    bulbGlintPath.addArc(
      Rect.fromCircle(center: glintCenter, radius: glintR),
      -math.pi * 0.75,
      math.pi * 0.65,
    );

    final bulbGlintPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = bulbR * 0.18
      ..strokeCap = StrokeCap.round
      ..shader = RadialGradient(
        center: const Alignment(-0.4, -0.4),
        radius: 0.6,
        colors: [
          Colors.white.withValues(alpha: 0.9),
          Colors.white.withValues(alpha: 0.4),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, bulbCy), radius: bulbR));

    canvas.drawPath(bulbGlintPath, bulbGlintPaint);

    // 4. Subtle bottom bounce reflection on bulb
    final bounceGlintPath = Path();
    bounceGlintPath.addArc(
      Rect.fromCircle(center: Offset(cx + bulbR * 0.15, bulbCy + bulbR * 0.25), radius: bulbR * 0.65),
      math.pi * 0.25,
      math.pi * 0.45,
    );
    final bounceGlintPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = bulbR * 0.1
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.25);
    canvas.drawPath(bounceGlintPath, bounceGlintPaint);
  }

  /// Builds seamless unified path for tube + rounded top + bulb base
  Path _buildThermometerPath(
    double cx,
    double top,
    double bottom,
    double tubeW,
    double bulbR,
    double bulbCy,
  ) {
    final halfTube = tubeW / 2;
    final path = Path();

    // Top dome
    path.moveTo(cx - halfTube, top + halfTube);
    path.arcToPoint(
      Offset(cx + halfTube, top + halfTube),
      radius: Radius.circular(halfTube),
      clockwise: true,
    );

    // Right stem side down to bulb neck
    final neckY = bottom - bulbR * 0.25;
    path.lineTo(cx + halfTube, neckY);

    // Transition curve to bulb
    path.lineTo(cx + halfTube, neckY);

    // Add bulb
    final bulbPath = Path()
      ..addOval(Rect.fromCircle(center: Offset(cx, bulbCy), radius: bulbR));

    // Tube path combined with bulb
    final stemPath = Path()
      ..moveTo(cx - halfTube, top + halfTube)
      ..arcToPoint(
        Offset(cx + halfTube, top + halfTube),
        radius: Radius.circular(halfTube),
        clockwise: true,
      )
      ..lineTo(cx + halfTube, neckY + bulbR * 0.4)
      ..lineTo(cx - halfTube, neckY + bulbR * 0.4)
      ..close();

    return Path.combine(PathOperation.union, stemPath, bulbPath);
  }

  /// Draws the precision graduated ruler scale with major ticks (5, 10, 15...) and minor tick micro-labels
  void _drawGraduatedScale(
    Canvas canvas,
    Size size,
    double cx,
    double tubeW,
    double top,
    double bottom,
  ) {
    final tp = TextPainter(textDirection: TextDirection.ltr);

    final majorTextColor = isDark ? const Color(0xFFECEFF4) : const Color(0xFF1E293B);
    final mediumTextColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final minorTextColor = isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

    final majorTickPaint = Paint()
      ..color = isDark ? const Color(0xFFD8DEE9) : const Color(0xFF334155)
      ..strokeWidth = (1.8 * scaleFactor).clamp(1.0, 3.0)
      ..strokeCap = StrokeCap.round;

    final mediumTickPaint = Paint()
      ..color = isDark ? const Color(0xFF7B889B) : const Color(0xFF64748B)
      ..strokeWidth = (1.3 * scaleFactor).clamp(0.8, 2.2)
      ..strokeCap = StrokeCap.round;

    final minorTickPaint = Paint()
      ..color = isDark ? const Color(0xFF4C566A) : const Color(0xFFCBD5E1)
      ..strokeWidth = (1.0 * scaleFactor).clamp(0.6, 1.8)
      ..strokeCap = StrokeCap.round;

    final leftTickOriginX = cx - tubeW / 2 - (8 * scaleFactor);
    final rightTickOriginX = cx + tubeW / 2 + (8 * scaleFactor);
    final scaleSpan = bottom - top;

    // --- Right Side: Celsius Scale (°C) ---
    if (showCelsius) {
      final totalDegrees = (maxCelsius - minCelsius).round();

      for (int i = 0; i <= totalDegrees; i += celsiusMinorStep) {
        final val = (maxCelsius - i).round();
        final fraction = (val - minCelsius) / (maxCelsius - minCelsius);
        final y = bottom - fraction * scaleSpan;

        final isMajor = (val % celsiusMajorStep == 0);
        final isMedium = !isMajor && (val % celsiusMediumStep == 0);

        final double tickLength;
        final Paint activePaint;

        if (isMajor) {
          tickLength = 16.0 * scaleFactor;
          activePaint = majorTickPaint;
        } else if (isMedium) {
          tickLength = 10.0 * scaleFactor;
          activePaint = mediumTickPaint;
        } else {
          tickLength = 5.5 * scaleFactor;
          activePaint = minorTickPaint;
        }

        // Draw tick line on the right
        canvas.drawLine(
          Offset(rightTickOriginX, y),
          Offset(rightTickOriginX + tickLength, y),
          activePaint,
        );

        // Draw Number Labels
        if (isMajor) {
          // Major prominent number (e.g. 50, 40, 30, 20, 10, 0, -10, -20, -30 or 5, 10, 15...)
          tp.text = TextSpan(
            text: '$val',
            style: TextStyle(
              color: majorTextColor,
              fontSize: (12.5 * scaleFactor).clamp(8.0, 20.0),
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          );
          tp.layout();
          tp.paint(canvas, Offset(rightTickOriginX + tickLength + 4 * scaleFactor, y - tp.height / 2));
        } else if (isMedium && !showMinorLabels) {
          // Medium number (e.g., at 5, 15, 25, 35, 45 if minor labels are off)
          tp.text = TextSpan(
            text: '$val',
            style: TextStyle(
              color: mediumTextColor,
              fontSize: (10.5 * scaleFactor).clamp(7.0, 16.0),
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          );
          tp.layout();
          tp.paint(canvas, Offset(rightTickOriginX + tickLength + 3 * scaleFactor, y - tp.height / 2));
        } else if (showMinorLabels) {
          // Precision Ruler / Wheel micro-number on EVERY tick or small intermediate ticks!
          final isSub5 = (val % 5 != 0);
          final labelColor = isMedium ? mediumTextColor : minorTextColor;
          final fontSize = (isMedium ? 10.0 : 8.0) * scaleFactor;

          // Don't crowd too closely if height is very compact
          final shouldRender = size.height >= 300 || val % 2 == 0 || isMedium;
          if (shouldRender) {
            tp.text = TextSpan(
              text: '$val',
              style: TextStyle(
                color: labelColor,
                fontSize: fontSize.clamp(6.0, 14.0),
                fontWeight: isMedium ? FontWeight.w600 : FontWeight.w500,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            );
            tp.layout();
            tp.paint(
              canvas,
              Offset(rightTickOriginX + tickLength + (isSub5 ? 2.5 : 3.5) * scaleFactor, y - tp.height / 2),
            );
          }
        }
      }

      // °C Unit Header Badge
      _drawUnitHeader(canvas, '°C', rightTickOriginX + 6 * scaleFactor, top - 24 * scaleFactor, majorTextColor);
    }

    // --- Left Side: Fahrenheit Scale (°F) ---
    if (showFahrenheit) {
      const fMinorStep = 5; // Every 5°F

      for (int f = minFahrenheit.round(); f <= maxFahrenheit.round(); f += fMinorStep) {
        final fraction = (f - minFahrenheit) / (maxFahrenheit - minFahrenheit);
        final y = bottom - fraction * scaleSpan;

        final isMajor = (f % fahrenheitMajorStep == 0);
        final double tickLength = (isMajor ? 14.0 : 7.0) * scaleFactor;
        final activePaint = isMajor ? majorTickPaint : minorTickPaint;

        // Draw tick line on the left
        canvas.drawLine(
          Offset(leftTickOriginX, y),
          Offset(leftTickOriginX - tickLength, y),
          activePaint,
        );

        if (isMajor) {
          tp.text = TextSpan(
            text: '$f',
            style: TextStyle(
              color: majorTextColor,
              fontSize: (11.5 * scaleFactor).clamp(7.5, 18.0),
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          );
          tp.layout();
          tp.paint(canvas, Offset(leftTickOriginX - tickLength - tp.width - 4 * scaleFactor, y - tp.height / 2));
        }
      }

      // °F Unit Header Badge
      _drawUnitHeader(canvas, '°F', leftTickOriginX - 24 * scaleFactor, top - 24 * scaleFactor, majorTextColor);
    }

    // --- Current Level Subtle Pointer / Marker on scale ---
    _drawCurrentLevelMarker(canvas, cx, tubeW, top, bottom, scaleSpan);
  }

  /// Draws the current level indicator: either glowing 3-tick circular wheel or marker
  void _drawCurrentLevelMarker(
    Canvas canvas,
    double cx,
    double tubeW,
    double top,
    double bottom,
    double scaleSpan,
  ) {
    final t = ((celsius - minCelsius) / (maxCelsius - minCelsius)).clamp(0.0, 1.0);
    final curY = bottom - t * scaleSpan;
    final primary = customFluidColor ?? fluidTheme.primary;

    final markerPaint = Paint()
      ..color = primary
      ..strokeWidth = 2.0 * scaleFactor
      ..strokeCap = StrokeCap.round;

    // Subtle level pips on scale origins
    final rightX = cx + tubeW / 2 + (8 * scaleFactor);
    canvas.drawLine(Offset(rightX, curY), Offset(rightX + 6 * scaleFactor, curY), markerPaint);

    final leftX = cx - tubeW / 2 - (8 * scaleFactor);
    canvas.drawLine(Offset(leftX, curY), Offset(leftX - 6 * scaleFactor, curY), markerPaint);

    // ─── 3-Tick Circular Wheel Readout (البكرة الدائرية ذات الـ 3 شرطات) ───
    if (readoutStyle == ThermometerReadoutStyle.circularWheel) {
      _drawCircularWheelReadout(canvas, rightX, curY, primary);
    } else if (readoutStyle == ThermometerReadoutStyle.simpleBadge) {
      _drawSimpleBadgeReadout(canvas, rightX, curY, primary);
    }
  }

  /// Renders the 3-tick cylindrical rolling wheel readout:
  /// - Top tick: faded 60% (opacity 0.40)
  /// - Middle tick: 100% clarity with glowing active temperature value
  /// - Bottom tick: faded 60% (opacity 0.40)
  void _drawCircularWheelReadout(
    Canvas canvas,
    double rightTickX,
    double curY,
    Color primaryColor,
  ) {
    final tp = TextPainter(textDirection: TextDirection.ltr);

    // Geometry of the 3D wheel drum capsule
    final wheelLeft = rightTickX + (showMinorLabels ? 38.0 : 28.0) * scaleFactor;
    final wheelWidth = (84.0 * scaleFactor).clamp(64.0, 110.0);
    final wheelHeight = (54.0 * scaleFactor).clamp(40.0, 72.0);
    final wheelCenter = Offset(wheelLeft + wheelWidth / 2, curY);
    final wheelRect = Rect.fromCenter(
      center: wheelCenter,
      width: wheelWidth,
      height: wheelHeight,
    );

    // 1. Connector pointer line from thermometer meniscus to the wheel center
    final connectorPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.6)
      ..strokeWidth = 1.2 * scaleFactor
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(rightTickX + 6 * scaleFactor, curY),
      Offset(wheelLeft, curY),
      connectorPaint,
    );

    // 2. Ambient drop shadow behind the 3D wheel
    final wheelRRect = RRect.fromRectAndRadius(
      wheelRect,
      Radius.circular(14.0 * scaleFactor),
    );
    canvas.drawShadow(
      Path()..addRRect(wheelRRect),
      isDark ? const Color(0xAA000000) : const Color(0x28000000),
      6.0 * scaleFactor,
      false,
    );

    // 3. 3D Cylindrical Drum Shading (dark top/bottom, bright center reflection)
    final drumShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark
          ? [
              const Color(0xFF13161C),
              const Color(0xFF222834),
              const Color(0xFF2C3444),
              const Color(0xFF222834),
              const Color(0xFF13161C),
            ]
          : [
              const Color(0xFFE2E8F0),
              const Color(0xFFF8FAFC),
              const Color(0xFFFFFFFF),
              const Color(0xFFF8FAFC),
              const Color(0xFFE2E8F0),
            ],
      stops: const [0.0, 0.22, 0.5, 0.78, 1.0],
    ).createShader(wheelRect);

    final drumPaint = Paint()..shader = drumShader;
    canvas.drawRRect(wheelRRect, drumPaint);

    // 4. Subtle lens border with specular rim
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2 * scaleFactor
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? [
                Colors.white.withValues(alpha: 0.2),
                primaryColor.withValues(alpha: 0.4),
                Colors.white.withValues(alpha: 0.1),
              ]
            : [
                Colors.white.withValues(alpha: 0.8),
                primaryColor.withValues(alpha: 0.3),
                const Color(0xFFCBD5E1),
              ],
      ).createShader(wheelRect);
    canvas.drawRRect(wheelRRect, borderPaint);

    // ─── THE 3 TICKS (الـ 3 شرطات) ───
    final tickStartX = wheelLeft + (7.0 * scaleFactor);
    final tickSpacing = 15.0 * scaleFactor;

    // A) Top Tick: Faded 60% (Opacity 0.40)
    final topTickY = curY - tickSpacing;
    final topTickPaint = Paint()
      ..color = (isDark ? Colors.white : const Color(0xFF475569))
          .withValues(alpha: 0.40) // 60% hidden/faded
      ..strokeWidth = 1.3 * scaleFactor
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(tickStartX, topTickY),
      Offset(tickStartX + 7.0 * scaleFactor, topTickY),
      topTickPaint,
    );

    // Top Tick Micro Value (e.g. +1° with 0.40 opacity)
    tp.text = TextSpan(
      text: '${(celsius + 1).toStringAsFixed(0)}°',
      style: TextStyle(
        color: (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))
            .withValues(alpha: 0.40),
        fontSize: (9.0 * scaleFactor).clamp(7.0, 13.0),
        fontWeight: FontWeight.w500,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(tickStartX + 12.0 * scaleFactor, topTickY - tp.height / 2));

    // B) Middle Active Tick: 100% Opaque & Vibrant with live value in front of it
    final centerTickPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 2.4 * scaleFactor
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(tickStartX, curY),
      Offset(tickStartX + 12.0 * scaleFactor, curY),
      centerTickPaint,
    );

    // Middle Bold Temperature Value
    tp.text = TextSpan(
      text: '${celsius.toStringAsFixed(1)}°',
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF0F172A),
        fontSize: (13.5 * scaleFactor).clamp(9.5, 18.0),
        fontWeight: FontWeight.w800,
        letterSpacing: 0.3,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(tickStartX + 16.0 * scaleFactor, curY - tp.height / 2));

    // C) Bottom Tick: Faded 60% (Opacity 0.40)
    final bottomTickY = curY + tickSpacing;
    final bottomTickPaint = Paint()
      ..color = (isDark ? Colors.white : const Color(0xFF475569))
          .withValues(alpha: 0.40) // 60% hidden/faded
      ..strokeWidth = 1.3 * scaleFactor
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(tickStartX, bottomTickY),
      Offset(tickStartX + 7.0 * scaleFactor, bottomTickY),
      bottomTickPaint,
    );

    // Bottom Tick Micro Value (e.g. -1° with 0.40 opacity)
    tp.text = TextSpan(
      text: '${(celsius - 1).toStringAsFixed(0)}°',
      style: TextStyle(
        color: (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))
            .withValues(alpha: 0.40),
        fontSize: (9.0 * scaleFactor).clamp(7.0, 13.0),
        fontWeight: FontWeight.w500,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(tickStartX + 12.0 * scaleFactor, bottomTickY - tp.height / 2));
  }

  /// Simple badge readout alternative
  void _drawSimpleBadgeReadout(
    Canvas canvas,
    double rightTickX,
    double curY,
    Color primaryColor,
  ) {
    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = TextSpan(
      text: '${celsius.toStringAsFixed(1)}°C',
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF0F172A),
        fontSize: (12.0 * scaleFactor).clamp(9.0, 16.0),
        fontWeight: FontWeight.w700,
      ),
    );
    tp.layout();

    final badgeLeft = rightTickX + 28.0 * scaleFactor;
    final badgeRect = Rect.fromCenter(
      center: Offset(badgeLeft + tp.width / 2 + 8, curY),
      width: tp.width + 16 * scaleFactor,
      height: tp.height + 8 * scaleFactor,
    );

    final bgPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.15);
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = primaryColor.withValues(alpha: 0.5);

    final rrect = RRect.fromRectAndRadius(badgeRect, Radius.circular(8 * scaleFactor));
    canvas.drawRRect(rrect, bgPaint);
    canvas.drawRRect(rrect, borderPaint);
    tp.paint(canvas, Offset(badgeLeft + 8, curY - tp.height / 2));
  }

  void _drawUnitHeader(
    Canvas canvas,
    String unit,
    double x,
    double y,
    Color color,
  ) {
    final tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = TextSpan(
      text: unit,
      style: TextStyle(
        color: color,
        fontSize: (13.0 * scaleFactor).clamp(9.0, 18.0),
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    );
    tp.layout();

    // Subtle pill background behind unit header
    final headerRect = Rect.fromCenter(
      center: Offset(x + tp.width / 2, y + tp.height / 2),
      width: tp.width + 12 * scaleFactor,
      height: tp.height + 6 * scaleFactor,
    );

    final bgPaint = Paint()
      ..color = (isDark ? const Color(0xFF282C34) : const Color(0xFFE2E8F0))
          .withValues(alpha: 0.75);
    canvas.drawRRect(
      RRect.fromRectAndRadius(headerRect, Radius.circular(6 * scaleFactor)),
      bgPaint,
    );

    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant _RealisticThermometerPainter old) =>
      old.celsius != celsius ||
      old.fahrenheit != fahrenheit ||
      old.showMinorLabels != showMinorLabels ||
      old.showCelsius != showCelsius ||
      old.showFahrenheit != showFahrenheit ||
      old.readoutStyle != readoutStyle ||
      old.fluidTheme != fluidTheme ||
      old.customFluidColor != customFluidColor ||
      old.isDark != isDark ||
      old.celsiusMajorStep != celsiusMajorStep ||
      old.celsiusMediumStep != celsiusMediumStep ||
      old.celsiusMinorStep != celsiusMinorStep;
}

/// Standalone 3-tick 3D Cylindrical Rolling Wheel Readout Widget
/// Can be used anywhere in cards, dashboards, or next to sliders.
class ThermometerWheelReadout extends StatelessWidget {
  final double celsius;
  final String? unit;
  final Color? activeColor;
  final double width;
  final double height;

  const ThermometerWheelReadout({
    super.key,
    required this.celsius,
    this.unit = '°C',
    this.activeColor,
    this.width = 104,
    this.height = 68,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = activeColor ?? Theme.of(context).colorScheme.primary;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF13161C),
                  const Color(0xFF222834),
                  const Color(0xFF2C3444),
                  const Color(0xFF222834),
                  const Color(0xFF13161C),
                ]
              : [
                  const Color(0xFFE2E8F0),
                  const Color(0xFFF8FAFC),
                  const Color(0xFFFFFFFF),
                  const Color(0xFFF8FAFC),
                  const Color(0xFFE2E8F0),
                ],
          stops: const [0.0, 0.22, 0.5, 0.78, 1.0],
        ),
        border: Border.all(
          color: primary.withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ─── Top Faded Tick (60% faded) ───
          Opacity(
            opacity: 0.40, // 60% faded
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${(celsius + 1).toStringAsFixed(0)}°',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─── Center Prominent Active Tick (100% clarity) ───
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 14,
                height: 3.0,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${celsius.toStringAsFixed(1)}${unit ?? ''}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ─── Bottom Faded Tick (60% faded) ───
          Opacity(
            opacity: 0.40, // 60% faded
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${(celsius - 1).toStringAsFixed(0)}°',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
