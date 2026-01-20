import 'package:flutter/material.dart';

/// Extension on [num] to provide convenient spacing and divider widgets.
///
/// This extension allows you to easily create spacing and dividers using numeric values.
///
/// Example:
/// ```dart
/// // Create horizontal spacing
/// 16.width
///
/// // Create vertical spacing
/// 20.height
///
/// // Create horizontal divider
/// 16.hDivider()
///
/// // Create vertical divider with custom color
/// 24.vDivider(color: Colors.grey)
/// ```
extension SpacingExtension on num {
  /// Creates a [SizedBox] with the specified width.
  ///
  /// Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text('Hello'),
  ///     16.width, // Adds 16 logical pixels spacing
  ///     Text('World'),
  ///   ],
  /// )
  /// ```
  SizedBox get width => SizedBox(width: toDouble());

  /// Creates a [SizedBox] with the specified height.
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text('Hello'),
  ///     20.height, // Adds 20 logical pixels spacing
  ///     Text('World'),
  ///   ],
  /// )
  /// ```
  SizedBox get height => SizedBox(height: toDouble());

  /// Creates a horizontal [Divider] with customizable properties.
  ///
  /// Parameters:
  /// - [color]: The color of the divider (default: Color(0xFFE0E0E0))
  /// - [thickness]: The thickness of the divider line (default: 1.0)
  /// - [indent]: Empty space to the leading edge (default: 0.0)
  /// - [endIndent]: Empty space to the trailing edge (default: 0.0)
  ///
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text('Section 1'),
  ///     16.hDivider(color: Colors.grey, thickness: 2),
  ///     Text('Section 2'),
  ///   ],
  /// )
  /// ```
  Widget hDivider({
    Color color = const Color(0xFFE0E0E0),
    double thickness = 1.0,
    double indent = 0.0,
    double endIndent = 0.0,
  }) {
    return SizedBox(
      height: toDouble(),
      child: Divider(
        height: 0,
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }

  /// Creates a vertical [VerticalDivider] with customizable properties.
  ///
  /// Parameters:
  /// - [color]: The color of the divider (default: Color(0xFFE0E0E0))
  /// - [thickness]: The thickness of the divider line (default: 1.0)
  /// - [indent]: Empty space to the top edge (default: 0.0)
  /// - [endIndent]: Empty space to the bottom edge (default: 0.0)
  ///
  /// Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Text('Item 1'),
  ///     24.vDivider(color: Colors.grey.shade300),
  ///     Text('Item 2'),
  ///   ],
  /// )
  /// ```
  Widget vDivider({
    Color color = const Color(0xFFE0E0E0),
    double thickness = 1.0,
    double indent = 0.0,
    double endIndent = 0.0,
  }) {
    return SizedBox(
      width: toDouble(),
      child: VerticalDivider(
        width: 0,
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}
