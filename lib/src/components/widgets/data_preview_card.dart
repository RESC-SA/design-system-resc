import 'package:flutter/material.dart';
////
///
/// as example for use this widget:
///DataPreviewCard(
//   title: 'Temperature',
//   value: '24°C',
//   valueLabel: 'Room',
//   lottieTitle: 'Climate',
//   lottieWidget: _buildMockLottie(Icons.thermostat),
//   borderRadius: 24,
//   padding: const EdgeInsets.all(20),
// ),
///
///
///
///
///
///
///
class DataPreviewCard extends StatelessWidget {
  const DataPreviewCard({
    super.key,
    required this.title,
    required this.value,
    this.lottieTitle,
    this.lottieWidget,
    this.backgroundColor,
    this.titleStyle,
    this.valueStyle,
    this.lottieTitleStyle,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.elevation = 2,
    this.valueLabel = 'Value',
  });

  final String title;
  final String value;
  final String? lottieTitle;
  final Widget? lottieWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? lottieTitleStyle;
  final EdgeInsets padding;
  final double borderRadius;
  final double elevation;
  final String valueLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = backgroundColor ?? theme.cardColor;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side: Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  title,
                  style: titleStyle ??
                      theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 8),
                // Value label and value
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$valueLabel: ',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        value,
                        style: valueStyle ??
                            theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Right side: Lottie animation with title
          if (lottieWidget != null) ...[
            const SizedBox(width: 16),
            SizedBox(
              width: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (lottieTitle != null) ...[
                    Text(
                      lottieTitle!,
                      style: lottieTitleStyle ??
                          theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                  ],
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: lottieWidget,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DataPreviewCardCompact extends StatelessWidget {
  const DataPreviewCardCompact({
    super.key,
    required this.title,
    required this.value,
    this.lottieWidget,
    this.backgroundColor,
    this.titleStyle,
    this.valueStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.borderRadius = 12,
    this.icon,
  });

  final String title;
  final String value;
  final Widget? lottieWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = backgroundColor ?? theme.cardColor;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Icon or Lottie
          if (icon != null || lottieWidget != null) ...[
            SizedBox(
              height: 40,
              width: 40,
              child: icon ?? lottieWidget,
            ),
            const SizedBox(width: 12),
          ],
          // Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: titleStyle ??
                      theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: valueStyle ??
                      theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
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
