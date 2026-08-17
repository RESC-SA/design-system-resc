import 'package:flutter/material.dart';

///
/// Example usage:
/// DataPreviewCard(
///   title: 'Server Status',
///   value: 'Operational',
///   valueLabel: 'Status',
///   status: 'Online',
///   statusColor: Colors.green,
///   description: 'All systems are running normally',
///   lottieTitle: 'Health',
///   lottieWidget: Lottie.asset('assets/health.json'),
///   leadingWidget: Icon(Icons.server, color: Colors.blue),
/// );
///

class DataPreviewCard extends StatelessWidget {
  final String title;

  final String? value;
  final String? lottieTitle;
  final Widget? lottieWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? lottieTitleStyle;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? elevation;
  final String? valueLabel;
  final String? status;
  final Color? statusColor;
  final String? description;
  final TextStyle? descriptionStyle;
  final Widget? leadingWidget;
  const DataPreviewCard({
    super.key,
    required this.title,
    this.value,
    this.lottieTitle,
    this.lottieWidget,
    this.backgroundColor,
    this.titleStyle,
    this.valueStyle,
    this.lottieTitleStyle,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.valueLabel,
    this.status,
    this.statusColor,
    this.description,
    this.descriptionStyle,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = backgroundColor ?? theme.cardColor;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: defaultBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
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
          // Leading widget
          if (leadingWidget != null) ...[
            leadingWidget!,
            const SizedBox(width: 12),
          ],
          // Left side: Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status container
                // if (status != null) ...[
                //   Container(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //     decoration: BoxDecoration(
                //       color: statusColor ??
                //           theme.colorScheme.primary.withValues(alpha: 0.1),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //     child: Text(
                //       status!,
                //       style: theme.textTheme.bodySmall?.copyWith(
                //         color: statusColor ?? theme.colorScheme.primary,
                //         fontWeight: FontWeight.w600,
                //         fontSize: 11,
                //       ),
                //     ),
                //   ),
                //   const SizedBox(height: 8),
                // ],
                // Title
                Row(
                  children: [
                    Text(
                      title,
                      style: titleStyle ??
                          theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                    ),
                    if (status != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor ??
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          status!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: statusColor ?? theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ],
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
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        value ?? '',
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
                // Description
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    description!,
                    style: descriptionStyle ??
                        theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
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
  final String title;

  final String value;
  final Widget? lottieWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget? icon;
  final Widget? leadingWidget;
  final String? status;
  final Color? statusColor;
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
    this.leadingWidget,
    this.status,
    this.statusColor,
  });

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
          // Leading widget, Icon or Lottie
          if (leadingWidget != null) ...[
            leadingWidget!,
            const SizedBox(width: 12),
          ] else if (icon != null || lottieWidget != null) ...[
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
                Row(
                  children: [
                    Text(
                      title,
                      style: titleStyle ??
                          theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                    ),
                    if (status != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color:
                              statusColor ?? Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: statusColor ??
                                theme.colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
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
