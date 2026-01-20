import 'package:flutter/material.dart';

/// A wrapper widget that controls text scaling and handles safe area padding.
///
/// This widget is useful for:
/// - Limiting text scale to prevent UI breaking on extreme accessibility settings
/// - Automatically handling bottom padding for safe areas (e.g., iPhone notch)
/// - Providing consistent text scaling across the app
///
/// Example:
/// ```dart
/// AppWrapper(
///   minTextScale: 1.0,
///   maxTextScale: 1.3,
///   child: MyApp(),
/// )
/// ```
class AppWrapper extends StatelessWidget {
  /// The child widget to wrap
  final Widget child;

  /// Minimum text scale factor (default: 1.0)
  final double minTextScale;

  /// Maximum text scale factor (default: 1.2)
  final double maxTextScale;

  /// Whether to apply bottom safe area padding (default: true)
  final bool applyBottomPadding;

  /// Custom padding to apply instead of automatic safe area padding
  /// If provided, this overrides [applyBottomPadding]
  final EdgeInsetsGeometry? customPadding;

  const AppWrapper({
    super.key,
    required this.child,
    this.minTextScale = 1.0,
    this.maxTextScale = 1.2,
    this.applyBottomPadding = true,
    this.customPadding,
  }) : assert(
         minTextScale <= maxTextScale,
         'minTextScale must be less than or equal to maxTextScale',
       );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final scale = mediaQuery.textScaler
        .scale(1)
        .clamp(minTextScale, maxTextScale);

    // Determine padding
    final EdgeInsetsGeometry padding =
        customPadding ??
        (applyBottomPadding
            ? EdgeInsets.only(bottom: mediaQuery.padding.bottom)
            : EdgeInsets.zero);

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: TextScaler.linear(scale)),
      child: Padding(padding: padding, child: child),
    );
  }
}
