enum AppAnimateType {
  // ── Fade ──
  fadeIn,
  fadeOut,
  fadeInDown,
  fadeInUp,
  fadeInLeft,
  fadeInRight,

  // ── Slide ──
  slideInUp,
  slideInDown,
  slideInLeft,
  slideInRight,
  slideOutUp,
  slideOutDown,
  slideOutLeft,
  slideOutRight,

  // ── Zoom / Scale ──
  zoomIn,
  zoomOut,
  scaleIn,
  scaleOut,
  pulse,
  bounce,

  // ── Rotate ──
  rotateIn,
  rotateOut,
  flipInX,
  flipInY,
  flipOutX,
  flipOutY,

  // ── Special ──
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

  // ── Bounce ──
  bounceIn,
  bounceInDown,
  bounceInUp,
  bounceInLeft,
  bounceInRight,
  bounceOut,
  bounceOutDown,
  bounceOutUp,

  // ── Elastic ──
  elasticIn,
  elasticOut,
  elasticInOut,
  elasticInDown,
  elasticInUp,
  elasticInLeft,

  // ── Combo ──
  fadeInScale,
  fadeInSlide,
  fadeInRotate,
  fadeOutScale,
  fadeOutSlide,
  fadeOutRotate,

  // ── Text / Container ──
  typewriter,
  textReveal,
  marquee,
  ripple;

  String get label {
    switch (this) {
      case fadeIn: return 'Fade In';
      case fadeOut: return 'Fade Out';
      case fadeInDown: return 'Fade In Down';
      case fadeInUp: return 'Fade In Up';
      case fadeInLeft: return 'Fade In Left';
      case fadeInRight: return 'Fade In Right';
      case slideInUp: return 'Slide In Up';
      case slideInDown: return 'Slide In Down';
      case slideInLeft: return 'Slide In Left';
      case slideInRight: return 'Slide In Right';
      case slideOutUp: return 'Slide Out Up';
      case slideOutDown: return 'Slide Out Down';
      case slideOutLeft: return 'Slide Out Left';
      case slideOutRight: return 'Slide Out Right';
      case zoomIn: return 'Zoom In';
      case zoomOut: return 'Zoom Out';
      case scaleIn: return 'Scale In';
      case scaleOut: return 'Scale Out';
      case pulse: return 'Pulse';
      case bounce: return 'Bounce';
      case rotateIn: return 'Rotate In';
      case rotateOut: return 'Rotate Out';
      case flipInX: return 'Flip In X';
      case flipInY: return 'Flip In Y';
      case flipOutX: return 'Flip Out X';
      case flipOutY: return 'Flip Out Y';
      case shimmer: return 'Shimmer';
      case blur: return 'Blur';
      case glow: return 'Glow';
      case shake: return 'Shake';
      case jello: return 'Jello';
      case swing: return 'Swing';
      case wobble: return 'Wobble';
      case flash: return 'Flash';
      case rubberBand: return 'Rubber Band';
      case heartbeat: return 'Heartbeat';
      case bounceIn: return 'Bounce In';
      case bounceInDown: return 'Bounce In Down';
      case bounceInUp: return 'Bounce In Up';
      case bounceInLeft: return 'Bounce In Left';
      case bounceInRight: return 'Bounce In Right';
      case bounceOut: return 'Bounce Out';
      case bounceOutDown: return 'Bounce Out Down';
      case bounceOutUp: return 'Bounce Out Up';
      case elasticIn: return 'Elastic In';
      case elasticOut: return 'Elastic Out';
      case elasticInOut: return 'Elastic In Out';
      case elasticInDown: return 'Elastic In Down';
      case elasticInUp: return 'Elastic In Up';
      case elasticInLeft: return 'Elastic In Left';
      case fadeInScale: return 'Fade In + Scale';
      case fadeInSlide: return 'Fade In + Slide';
      case fadeInRotate: return 'Fade In + Rotate';
      case fadeOutScale: return 'Fade Out + Scale';
      case fadeOutSlide: return 'Fade Out + Slide';
      case fadeOutRotate: return 'Fade Out + Rotate';
      case typewriter: return 'Typewriter';
      case textReveal: return 'Text Reveal';
      case marquee: return 'Marquee';
      case ripple: return 'Ripple';
    }
  }

  String get group {
    switch (this) {
      case fadeIn: case fadeOut: case fadeInDown: case fadeInUp: case fadeInLeft: case fadeInRight: return 'Fade';
      case slideInUp: case slideInDown: case slideInLeft: case slideInRight: case slideOutUp: case slideOutDown: case slideOutLeft: case slideOutRight: return 'Slide';
      case zoomIn: case zoomOut: case scaleIn: case scaleOut: case pulse: case bounce: return 'Zoom / Scale';
      case rotateIn: case rotateOut: case flipInX: case flipInY: case flipOutX: case flipOutY: return 'Rotate';
      case shimmer: case blur: case glow: case shake: case jello: case swing: case wobble: case flash: case rubberBand: case heartbeat: return 'Special';
      case bounceIn: case bounceInDown: case bounceInUp: case bounceInLeft: case bounceInRight: case bounceOut: case bounceOutDown: case bounceOutUp: return 'Bounce';
      case elasticIn: case elasticOut: case elasticInOut: case elasticInDown: case elasticInUp: case elasticInLeft: return 'Elastic';
      case fadeInScale: case fadeInSlide: case fadeInRotate: case fadeOutScale: case fadeOutSlide: case fadeOutRotate: return 'Combo';
      case typewriter: case textReveal: case marquee: case ripple: return 'Text / Container';
    }
  }

  bool get isTextOnly => switch (this) {
    typewriter || textReveal || marquee => true,
    _ => false,
  };
}
