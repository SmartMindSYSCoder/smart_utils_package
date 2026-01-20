import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A wrapper widget that requires double-tap on the back button to exit the app.
///
/// This widget wraps your main screen and intercepts back button presses.
/// On the first press, it shows a snackbar message. On the second press within
/// the timeout period, it exits the app.
///
/// Example:
/// ```dart
/// DoubleTapExitWrapper(
///   child: MyHomePage(),
///   exitMessage: 'Press back again to exit',
///   exitTimeoutSeconds: 2,
/// )
/// ```
class DoubleTapExitWrapper extends StatefulWidget {
  /// The child widget to wrap
  final Widget child;

  /// The message to display when the user presses back once
  final String exitMessage;

  /// The timeout in seconds before requiring another double-tap
  final int exitTimeoutSeconds;

  /// Whether to show a snackbar message
  final bool showSnackbar;

  /// Background color of the snackbar
  final Color? snackbarBackgroundColor;

  /// Text color of the snackbar
  final Color? snackbarTextColor;

  /// Margin around the snackbar
  final EdgeInsetsGeometry? snackbarMargin;

  /// Border radius of the snackbar
  final double? snackbarBorderRadius;

  const DoubleTapExitWrapper({
    super.key,
    required this.child,
    this.exitMessage = 'Press back again to exit',
    this.exitTimeoutSeconds = 2,
    this.showSnackbar = true,
    this.snackbarBackgroundColor,
    this.snackbarTextColor,
    this.snackbarMargin,
    this.snackbarBorderRadius,
  });

  @override
  State<DoubleTapExitWrapper> createState() => _DoubleTapExitWrapperState();
}

class _DoubleTapExitWrapperState extends State<DoubleTapExitWrapper> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final now = DateTime.now();
        final isWarning =
            _lastPressedAt == null ||
            now.difference(_lastPressedAt!) >
                Duration(seconds: widget.exitTimeoutSeconds);

        if (isWarning) {
          _lastPressedAt = now;
          if (widget.showSnackbar) {
            _showExitSnackbar();
          }
        } else {
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }

  void _showExitSnackbar() {
    final theme = Theme.of(context);
    final backgroundColor =
        widget.snackbarBackgroundColor ??
        theme.colorScheme.secondary.withOpacity(0.9);
    final textColor = widget.snackbarTextColor ?? Colors.white;
    final margin = widget.snackbarMargin ?? const EdgeInsets.all(16.0);
    final borderRadius = widget.snackbarBorderRadius ?? 12.0;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.exitMessage, style: TextStyle(color: textColor)),
        duration: Duration(seconds: widget.exitTimeoutSeconds),
        backgroundColor: backgroundColor,
        margin: margin,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
