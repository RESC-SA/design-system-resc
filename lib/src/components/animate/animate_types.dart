enum AppAnimateType {
  // ── Fade (14) ──
  fadeIn,
  fadeOut,
  fadeInDown,
  fadeInUp,
  fadeInLeft,
  fadeInRight,
  fadeInDownLeft,
  fadeInDownRight,
  fadeInUpLeft,
  fadeInUpRight,
  fadeOutDownLeft,
  fadeOutDownRight,
  fadeOutUpLeft,
  fadeOutUpRight,
  fadeInFast,
  fadeInSlow,
  fadeOutFast,
  fadeOutSlow,

  // ── Slide (16) ──
  slideInUp,
  slideInDown,
  slideInLeft,
  slideInRight,
  slideOutUp,
  slideOutDown,
  slideOutLeft,
  slideOutRight,
  slideInUpLeft,
  slideInUpRight,
  slideInDownLeft,
  slideInDownRight,
  slideOutUpLeft,
  slideOutUpRight,
  slideOutDownLeft,
  slideOutDownRight,
  slideInUpFast,
  slideInUpSlow,

  // ── Zoom / Scale (18) ──
  zoomIn,
  zoomOut,
  scaleIn,
  scaleOut,
  pulse,
  bounce,
  zoomInDown,
  zoomInUp,
  zoomInLeft,
  zoomInRight,
  zoomOutDown,
  zoomOutUp,
  zoomOutLeft,
  zoomOutRight,
  scaleXIn,
  scaleXOut,
  scaleYIn,
  scaleYOut,
  zoomInFast,
  zoomInSlow,

  // ── Rotate (14) ──
  rotateIn,
  rotateOut,
  flipInX,
  flipInY,
  flipOutX,
  flipOutY,
  rotateInDownLeft,
  rotateInDownRight,
  rotateInUpLeft,
  rotateInUpRight,
  rotateOutDownLeft,
  rotateOutDownRight,
  rotateOutUpLeft,
  rotateOutUpRight,
  rotateInFast,
  rotateInSlow,

  // ── Special (30) ──
  shimmer,
  blur,
  glow,
  shake,
  jello,
  swing,
  wobble,
  flash,
  rubberBand,
  heartbeat,
  glowPulse,
  neonPulse,
  gradientShift,
  scanLine,
  morph,
  distort,
  wave,
  rippleExpand,
  rippleContract,
  vortex,
  spiral,
  orbit,
  pendulum,
  blink,
  flicker,
  scramble,
  glitch,
  loadingDots,
  skeletonWave,
  confetti,

  // ── Bounce (20) ──
  bounceIn,
  bounceInDown,
  bounceInUp,
  bounceInLeft,
  bounceInRight,
  bounceOut,
  bounceOutDown,
  bounceOutUp,
  bounceInDownLeft,
  bounceInDownRight,
  bounceInUpLeft,
  bounceInUpRight,
  bounceOutDownLeft,
  bounceOutDownRight,
  bounceOutUpLeft,
  bounceOutUpRight,
  bounceInFade,
  bounceOutFade,

  // ── Elastic (14) ──
  elasticIn,
  elasticOut,
  elasticInOut,
  elasticInDown,
  elasticInUp,
  elasticInLeft,
  elasticInRight,
  elasticOutDown,
  elasticOutUp,
  elasticOutRight,
  elasticOutLeft,
  elasticInFade,
  elasticOutFade,

  // ── Combo (18) ──
  fadeInScale,
  fadeInSlide,
  fadeInRotate,
  fadeOutScale,
  fadeOutSlide,
  fadeOutRotate,
  fadeInScaleRotate,
  fadeInSlideScale,
  fadeInSlideRotate,
  fadeOutScaleRotate,
  fadeOutSlideScale,
  fadeOutSlideRotate,
  zoomInRotate,
  zoomOutRotate,
  scaleInRotate,

  // ── Text / Container (16) ──
  typewriter,
  textReveal,
  marquee,
  ripple,
  textWave,
  textBounce,
  textFlip,
  textSpin,
  letterFade,
  letterSlide,
  letterScale,
  letterRotate,
  wordFade,
  wordSlide,
  wordScale,
  wordRotate,

  // ── Utility (20) ──
  revealLeft,
  revealRight,
  revealUp,
  revealDown,
  shimmerSlide,
  shimmerWave,
  pulseSoft,
  pulseHard,
  pulseFast,
  pulseSlow,
  breathe,
  float,
  drift,
  shakeX,
  shakeY,
  shakeDiagonal,
  swingX,
  swingY,
  swingDiagonal,
  pulseGlow,

  // ── Speed / Intensity variants (20) ──
  scaleInFast,
  scaleInSlow,
  pulseRotate,
  pulseX,
  pulseY,
  pulseBorder,
  blinkFast,
  blinkSlow,
  fadeInSoft,
  fadeInStrong,
  slideInUpStrong,
  slideInUpSoft,
  scaleInBounce,
  rotateInBounce,
  fadeInBounce,
  slideInBounce,
  zoomInBounce,
  elasticBounce,
  wobbleFast,
  wobbleSlow;

  String get label => _generateLabel(this);

  String get group => _generateGroup(this);

  bool get isTextOnly => switch (this) {
    typewriter || textReveal || marquee || textWave || textBounce ||
    textFlip || textSpin || letterFade || letterSlide || letterScale ||
    letterRotate || wordFade || wordSlide || wordScale || wordRotate ||
    scramble || glitch => true,
    _ => false,
  };
}

String _generateLabel(AppAnimateType type) {
  return type.name
      .replaceAllMapped(RegExp(r'[A-Z]'), (m) => ' ${m.group(0)}')
      .replaceAllMapped(RegExp(r'(\d)'), (m) => ' ${m.group(0)}')
      .trim()
      .split(' ')
      .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}

String _generateGroup(AppAnimateType type) {
  switch (type) {
    case AppAnimateType.fadeIn: case AppAnimateType.fadeOut:
    case AppAnimateType.fadeInDown: case AppAnimateType.fadeInUp:
    case AppAnimateType.fadeInLeft: case AppAnimateType.fadeInRight:
    case AppAnimateType.fadeInDownLeft: case AppAnimateType.fadeInDownRight:
    case AppAnimateType.fadeInUpLeft: case AppAnimateType.fadeInUpRight:
    case AppAnimateType.fadeOutDownLeft: case AppAnimateType.fadeOutDownRight:
    case AppAnimateType.fadeOutUpLeft: case AppAnimateType.fadeOutUpRight:
    case AppAnimateType.fadeInFast: case AppAnimateType.fadeInSlow:
    case AppAnimateType.fadeOutFast: case AppAnimateType.fadeOutSlow:
    case AppAnimateType.fadeInSoft: case AppAnimateType.fadeInStrong:
    case AppAnimateType.fadeInBounce: return 'Fade';

    case AppAnimateType.slideInUp: case AppAnimateType.slideInDown:
    case AppAnimateType.slideInLeft: case AppAnimateType.slideInRight:
    case AppAnimateType.slideOutUp: case AppAnimateType.slideOutDown:
    case AppAnimateType.slideOutLeft: case AppAnimateType.slideOutRight:
    case AppAnimateType.slideInUpLeft: case AppAnimateType.slideInUpRight:
    case AppAnimateType.slideInDownLeft: case AppAnimateType.slideInDownRight:
    case AppAnimateType.slideOutUpLeft: case AppAnimateType.slideOutUpRight:
    case AppAnimateType.slideOutDownLeft: case AppAnimateType.slideOutDownRight:
    case AppAnimateType.slideInUpFast: case AppAnimateType.slideInUpSlow:
    case AppAnimateType.slideInUpStrong: case AppAnimateType.slideInUpSoft:
    case AppAnimateType.slideInBounce: return 'Slide';

    case AppAnimateType.zoomIn: case AppAnimateType.zoomOut:
    case AppAnimateType.zoomInDown: case AppAnimateType.zoomInUp:
    case AppAnimateType.zoomInLeft: case AppAnimateType.zoomInRight:
    case AppAnimateType.zoomOutDown: case AppAnimateType.zoomOutUp:
    case AppAnimateType.zoomOutLeft: case AppAnimateType.zoomOutRight:
    case AppAnimateType.zoomInFast: case AppAnimateType.zoomInSlow:
    case AppAnimateType.zoomInBounce: return 'Zoom / Scale';

    case AppAnimateType.scaleIn: case AppAnimateType.scaleOut:
    case AppAnimateType.scaleXIn: case AppAnimateType.scaleXOut:
    case AppAnimateType.scaleYIn: case AppAnimateType.scaleYOut:
    case AppAnimateType.scaleInFast: case AppAnimateType.scaleInSlow:
    case AppAnimateType.scaleInBounce: return 'Zoom / Scale';

    case AppAnimateType.pulse: case AppAnimateType.bounce:
    case AppAnimateType.pulseSoft: case AppAnimateType.pulseHard:
    case AppAnimateType.pulseFast: case AppAnimateType.pulseSlow:
    case AppAnimateType.pulseRotate: case AppAnimateType.pulseX:
    case AppAnimateType.pulseY: case AppAnimateType.pulseBorder:
    case AppAnimateType.pulseGlow: return 'Pulse / Bounce';

    case AppAnimateType.rotateIn: case AppAnimateType.rotateOut:
    case AppAnimateType.rotateInFast: case AppAnimateType.rotateInSlow:
    case AppAnimateType.rotateInBounce:
    case AppAnimateType.rotateInDownLeft: case AppAnimateType.rotateInDownRight:
    case AppAnimateType.rotateInUpLeft: case AppAnimateType.rotateInUpRight:
    case AppAnimateType.rotateOutDownLeft: case AppAnimateType.rotateOutDownRight:
    case AppAnimateType.rotateOutUpLeft: case AppAnimateType.rotateOutUpRight:
    case AppAnimateType.flipInX: case AppAnimateType.flipInY:
    case AppAnimateType.flipOutX: case AppAnimateType.flipOutY: return 'Rotate / Flip';

    case AppAnimateType.shimmer: case AppAnimateType.blur: case AppAnimateType.glow:
    case AppAnimateType.shake: case AppAnimateType.jello: case AppAnimateType.swing:
    case AppAnimateType.wobble: case AppAnimateType.flash:
    case AppAnimateType.rubberBand: case AppAnimateType.heartbeat:
    case AppAnimateType.glowPulse: case AppAnimateType.neonPulse:
    case AppAnimateType.gradientShift: case AppAnimateType.scanLine:
    case AppAnimateType.morph: case AppAnimateType.distort: case AppAnimateType.wave:
    case AppAnimateType.rippleExpand: case AppAnimateType.rippleContract:
    case AppAnimateType.vortex: case AppAnimateType.spiral: case AppAnimateType.orbit:
    case AppAnimateType.pendulum: case AppAnimateType.blink: case AppAnimateType.flicker:
    case AppAnimateType.confetti: return 'Special';

    case AppAnimateType.bounceIn: case AppAnimateType.bounceInDown:
    case AppAnimateType.bounceInUp: case AppAnimateType.bounceInLeft:
    case AppAnimateType.bounceInRight: case AppAnimateType.bounceOut:
    case AppAnimateType.bounceOutDown: case AppAnimateType.bounceOutUp:
    case AppAnimateType.bounceInDownLeft: case AppAnimateType.bounceInDownRight:
    case AppAnimateType.bounceInUpLeft: case AppAnimateType.bounceInUpRight:
    case AppAnimateType.bounceOutDownLeft: case AppAnimateType.bounceOutDownRight:
    case AppAnimateType.bounceOutUpLeft: case AppAnimateType.bounceOutUpRight:
    case AppAnimateType.bounceInFade: case AppAnimateType.bounceOutFade: return 'Bounce';

    case AppAnimateType.elasticIn: case AppAnimateType.elasticOut:
    case AppAnimateType.elasticInOut: case AppAnimateType.elasticInDown:
    case AppAnimateType.elasticInUp: case AppAnimateType.elasticInLeft:
    case AppAnimateType.elasticInRight: case AppAnimateType.elasticOutDown:
    case AppAnimateType.elasticOutUp: case AppAnimateType.elasticOutRight:
    case AppAnimateType.elasticOutLeft: case AppAnimateType.elasticInFade:
    case AppAnimateType.elasticOutFade: case AppAnimateType.elasticBounce: return 'Elastic';

    case AppAnimateType.fadeInScale: case AppAnimateType.fadeInSlide:
    case AppAnimateType.fadeInRotate: case AppAnimateType.fadeOutScale:
    case AppAnimateType.fadeOutSlide: case AppAnimateType.fadeOutRotate:
    case AppAnimateType.fadeInScaleRotate: case AppAnimateType.fadeInSlideScale:
    case AppAnimateType.fadeInSlideRotate: case AppAnimateType.fadeOutScaleRotate:
    case AppAnimateType.fadeOutSlideScale: case AppAnimateType.fadeOutSlideRotate:
    case AppAnimateType.zoomInRotate: case AppAnimateType.zoomOutRotate:
    case AppAnimateType.scaleInRotate: return 'Combo';

    case AppAnimateType.typewriter: case AppAnimateType.textReveal:
    case AppAnimateType.marquee: case AppAnimateType.ripple:
    case AppAnimateType.textWave: case AppAnimateType.textBounce:
    case AppAnimateType.textFlip: case AppAnimateType.textSpin:
    case AppAnimateType.letterFade: case AppAnimateType.letterSlide:
    case AppAnimateType.letterScale: case AppAnimateType.letterRotate:
    case AppAnimateType.wordFade: case AppAnimateType.wordSlide:
    case AppAnimateType.wordScale: case AppAnimateType.wordRotate:
    case AppAnimateType.scramble: case AppAnimateType.glitch: return 'Text';

    case AppAnimateType.revealLeft: case AppAnimateType.revealRight:
    case AppAnimateType.revealUp: case AppAnimateType.revealDown:
    case AppAnimateType.shimmerSlide: case AppAnimateType.shimmerWave:
    case AppAnimateType.shakeX: case AppAnimateType.shakeY:
    case AppAnimateType.shakeDiagonal: case AppAnimateType.swingX:
    case AppAnimateType.swingY: case AppAnimateType.swingDiagonal:
    case AppAnimateType.breathe: case AppAnimateType.float: case AppAnimateType.drift:
    case AppAnimateType.wobbleFast: case AppAnimateType.wobbleSlow:
    case AppAnimateType.blinkFast: case AppAnimateType.blinkSlow: return 'Utility';

    case AppAnimateType.loadingDots: case AppAnimateType.skeletonWave: return 'Loader';
  }
}
