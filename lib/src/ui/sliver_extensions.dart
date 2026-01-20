import 'package:flutter/widgets.dart';

/// Extension methods for converting regular widgets to Sliver widgets.
///
/// These extensions make it easier to work with CustomScrollView and other
/// sliver-based layouts by providing convenient conversion methods.
///
/// Example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     Text('Hello').toSliver(),
///     Container(height: 100).toPaddedSliver(padding: EdgeInsets.all(16)),
///     MyWidget().toAnimatedSliver(),
///   ],
/// )
/// ```
extension SliverExtensions on Widget {
  /// Wraps the widget in a [SliverToBoxAdapter].
  ///
  /// This is the most common way to convert a regular widget to a sliver.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello World').toSliver()
  /// ```
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);

  /// Wraps the widget in a [SliverToBoxAdapter] with padding.
  ///
  /// This is a convenience method that combines [toSliver] with [Padding].
  ///
  /// Example:
  /// ```dart
  /// MyWidget().toPaddedSliver(
  ///   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  /// )
  /// ```
  SliverToBoxAdapter toPaddedSliver({required EdgeInsetsGeometry padding}) {
    return SliverToBoxAdapter(
      child: Padding(padding: padding, child: this),
    );
  }

  /// Wraps the widget in an [AnimatedSwitcher] inside a [SliverToBoxAdapter].
  ///
  /// Useful for animating content changes within a sliver list.
  ///
  /// Parameters:
  /// - [duration]: The duration of the animation (default: 300ms)
  /// - [transitionBuilder]: Custom transition builder (default: fade transition)
  /// - [layoutBuilder]: Custom layout builder for positioning widgets
  /// - [switchInCurve]: The curve for the incoming widget animation
  /// - [switchOutCurve]: The curve for the outgoing widget animation
  ///
  /// Example:
  /// ```dart
  /// Obx(() => controller.isLoading.value
  ///   ? CircularProgressIndicator()
  ///   : MyContent()
  /// ).toAnimatedSliver(
  ///   duration: Duration(milliseconds: 500),
  /// )
  /// ```
  SliverToBoxAdapter toAnimatedSliver({
    Duration duration = const Duration(milliseconds: 300),
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
    AnimatedSwitcherLayoutBuilder? layoutBuilder,
    Curve switchInCurve = Curves.linear,
    Curve switchOutCurve = Curves.linear,
  }) {
    return SliverToBoxAdapter(
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        transitionBuilder:
            transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,
        layoutBuilder: layoutBuilder ?? AnimatedSwitcher.defaultLayoutBuilder,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverFillRemaining].
  ///
  /// Useful for creating a sliver that fills the remaining space in the viewport.
  ///
  /// Parameters:
  /// - [hasScrollBody]: Whether the child has a scrollable body (default: true)
  /// - [fillOverscroll]: Whether to fill overscroll area (default: false)
  ///
  /// Example:
  /// ```dart
  /// Center(
  ///   child: Text('This fills remaining space'),
  /// ).toSliverFillRemaining()
  /// ```
  SliverFillRemaining toSliverFillRemaining({
    bool hasScrollBody = true,
    bool fillOverscroll = false,
  }) {
    return SliverFillRemaining(
      hasScrollBody: hasScrollBody,
      fillOverscroll: fillOverscroll,
      child: this,
    );
  }
}
