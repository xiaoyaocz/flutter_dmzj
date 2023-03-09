import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart' as physics;

import 'dart:math' as math;

/// Material header.
class MaterialHeader2 extends Header {
  final Key? key;

  /// See [ProgressIndicator.backgroundColor].
  final Color? backgroundColor;

  /// See [ProgressIndicator.color].
  final Color? color;

  /// See [ProgressIndicator.valueColor].
  final Animation<Color?>? valueColor;

  /// See [ProgressIndicator.semanticsLabel].
  final String? semanticsLabel;

  /// See [ProgressIndicator.semanticsLabel].
  final String? semanticsValue;

  /// Icon when [IndicatorResult.noMore].
  final Widget? noMoreIcon;

  /// Show bezier background.
  final bool showBezierBackground;

  /// Bezier background color.
  /// See [BezierBackground.color].
  final Color? bezierBackgroundColor;

  /// Bezier background animation.
  /// See [BezierBackground.useAnimation].
  final bool bezierBackgroundAnimation;

  /// Bezier background bounce.
  /// See [BezierBackground.bounce].
  final bool bezierBackgroundBounce;

  final Widget child;

  const MaterialHeader2({
    this.key,
    double triggerOffset = 100,
    bool clamping = true,
    IndicatorPosition position = IndicatorPosition.above,
    Duration processedDuration = const Duration(milliseconds: 200),
    physics.SpringDescription? spring,
    bool springRebound = false,
    SpringBuilder? readySpringBuilder,
    FrictionFactor? frictionFactor,
    bool safeArea = true,
    double? infiniteOffset,
    bool? hitOver,
    bool? infiniteHitOver,
    bool hapticFeedback = false,
    bool triggerWhenRelease = false,
    double maxOverOffset = double.infinity,
    required this.child,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.noMoreIcon,
    this.showBezierBackground = false,
    this.bezierBackgroundColor,
    this.bezierBackgroundAnimation = false,
    this.bezierBackgroundBounce = false,
  }) : super(
          triggerOffset: triggerOffset,
          clamping: clamping,
          processedDuration: processedDuration,
          spring: spring,
          readySpringBuilder: readySpringBuilder ??
              (bezierBackgroundAnimation
                  ? kBezierSpringBuilder
                  : kMaterialSpringBuilder),
          springRebound: springRebound,
          frictionFactor: frictionFactor ??
              (showBezierBackground
                  ? kBezierFrictionFactor
                  : kMaterialFrictionFactor),
          horizontalFrictionFactor: frictionFactor ??
              (showBezierBackground
                  ? kBezierHorizontalFrictionFactor
                  : kMaterialHorizontalFrictionFactor),
          safeArea: safeArea,
          infiniteOffset: infiniteOffset,
          hitOver: hitOver,
          infiniteHitOver: infiniteHitOver,
          position: position,
          hapticFeedback: hapticFeedback,
          triggerWhenRelease: triggerWhenRelease,
          maxOverOffset: maxOverOffset,
        );

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _MaterialIndicator(
      key: key,
      state: state,
      disappearDuration: processedDuration,
      reverse: state.reverse,
      backgroundColor: backgroundColor,
      color: color,
      valueColor: valueColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      noMoreIcon: noMoreIcon,
      showBezierBackground: showBezierBackground,
      bezierBackgroundColor: bezierBackgroundColor,
      bezierBackgroundAnimation: bezierBackgroundAnimation,
      bezierBackgroundBounce: bezierBackgroundBounce,
      child: child,
    );
  }
}

class MaterialFooter2 extends Footer {
  final Key? key;

  /// See [ProgressIndicator.backgroundColor].
  final Color? backgroundColor;

  /// See [ProgressIndicator.color].
  final Color? color;

  /// See [ProgressIndicator.valueColor].
  final Animation<Color?>? valueColor;

  /// See [ProgressIndicator.semanticsLabel].
  final String? semanticsLabel;

  /// See [ProgressIndicator.semanticsLabel].
  final String? semanticsValue;

  /// Icon when [IndicatorResult.noMore].
  final Widget? noMoreIcon;

  /// Show bezier background.
  final bool showBezierBackground;

  /// Bezier background color.
  /// See [BezierBackground.color].
  final Color? bezierBackgroundColor;

  /// Bezier background animation.
  /// See [BezierBackground.useAnimation].
  final bool bezierBackgroundAnimation;

  /// Bezier background bounce.
  /// See [BezierBackground.bounce].
  final bool bezierBackgroundBounce;
  final Widget child;
  const MaterialFooter2({
    this.key,
    double triggerOffset = 100,
    bool clamping = true,
    IndicatorPosition position = IndicatorPosition.above,
    Duration processedDuration = const Duration(milliseconds: 200),
    physics.SpringDescription? spring,
    SpringBuilder? readySpringBuilder,
    bool springRebound = false,
    FrictionFactor? frictionFactor,
    bool safeArea = true,
    double? infiniteOffset,
    bool? hitOver,
    bool? infiniteHitOver,
    bool hapticFeedback = false,
    bool triggerWhenRelease = false,
    double maxOverOffset = double.infinity,
    required this.child,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.noMoreIcon,
    this.showBezierBackground = false,
    this.bezierBackgroundColor,
    this.bezierBackgroundAnimation = false,
    this.bezierBackgroundBounce = false,
  }) : super(
          triggerOffset: triggerOffset,
          clamping: clamping,
          processedDuration: processedDuration,
          spring: spring,
          readySpringBuilder: readySpringBuilder ??
              (bezierBackgroundAnimation
                  ? kBezierSpringBuilder
                  : kMaterialSpringBuilder),
          springRebound: springRebound,
          frictionFactor: frictionFactor ??
              (showBezierBackground
                  ? kBezierFrictionFactor
                  : kMaterialFrictionFactor),
          horizontalFrictionFactor: frictionFactor ??
              (showBezierBackground
                  ? kBezierHorizontalFrictionFactor
                  : kMaterialHorizontalFrictionFactor),
          safeArea: safeArea,
          infiniteOffset: infiniteOffset,
          hitOver: hitOver,
          infiniteHitOver: infiniteHitOver,
          position: position,
          hapticFeedback: hapticFeedback,
          triggerWhenRelease: triggerWhenRelease,
          maxOverOffset: maxOverOffset,
        );

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _MaterialIndicator(
      key: key,
      state: state,
      disappearDuration: processedDuration,
      reverse: !state.reverse,
      backgroundColor: backgroundColor,
      color: color,
      valueColor: valueColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      noMoreIcon: noMoreIcon,
      showBezierBackground: showBezierBackground,
      bezierBackgroundColor: bezierBackgroundColor,
      bezierBackgroundAnimation: bezierBackgroundAnimation,
      bezierBackgroundBounce: bezierBackgroundBounce,
      child: child,
    );
  }
}

/// Material indicator.
/// Base widget for [MaterialHeader] and [MaterialFooter].
class _MaterialIndicator extends StatefulWidget {
  /// Indicator properties and state.
  final IndicatorState state;

  /// See [ProgressIndicator.backgroundColor].
  final Color? backgroundColor;

  /// See [ProgressIndicator.color].
  final Color? color;

  /// See [ProgressIndicator.valueColor].
  final Animation<Color?>? valueColor;

  /// See [ProgressIndicator.semanticsLabel].
  final String? semanticsLabel;

  /// See [ProgressIndicator.semanticsLabel].
  final String? semanticsValue;

  /// Indicator disappears duration.
  /// When the mode is [IndicatorMode.processed].
  final Duration disappearDuration;

  /// True for up and left.
  /// False for down and right.
  final bool reverse;

  /// Icon when [IndicatorResult.noMore].
  final Widget? noMoreIcon;

  /// Show bezier background.
  final bool showBezierBackground;

  /// Bezier background color.
  /// See [BezierBackground.color].
  final Color? bezierBackgroundColor;

  /// Bezier background animation.
  /// See [BezierBackground.useAnimation].
  final bool bezierBackgroundAnimation;

  /// Bezier background bounce.
  /// See [BezierBackground.bounce].
  final bool bezierBackgroundBounce;

  final Widget child;

  const _MaterialIndicator({
    Key? key,
    required this.state,
    required this.disappearDuration,
    required this.reverse,
    required this.child,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.noMoreIcon,
    this.showBezierBackground = false,
    this.bezierBackgroundColor,
    this.bezierBackgroundAnimation = false,
    this.bezierBackgroundBounce = false,
  }) : super(key: key);

  @override
  State<_MaterialIndicator> createState() => _MaterialIndicatorState();
}

/// See [ProgressIndicator] _kMinCircularProgressIndicatorSize.
const double _kCircularProgressIndicatorSize = 48;

/// Friction factor used by material.
double kMaterialFrictionFactor(double overscrollFraction) =>
    0.875 * math.pow(1 - overscrollFraction, 2);

/// Friction factor used by material horizontal.
double kMaterialHorizontalFrictionFactor(double overscrollFraction) =>
    1.0 * math.pow(1 - overscrollFraction, 2);

/// Spring description used by material.
physics.SpringDescription kMaterialSpringBuilder({
  required IndicatorMode mode,
  required double offset,
  required double actualTriggerOffset,
  required double velocity,
}) =>
    physics.SpringDescription.withDampingRatio(
      mass: 1,
      stiffness: 500,
      ratio: 1.1,
    );

class _MaterialIndicatorState extends State<_MaterialIndicator> {
  IndicatorMode get _mode => widget.state.mode;

  IndicatorResult get _result => widget.state.result;

  Axis get _axis => widget.state.axis;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  /// Build [RefreshProgressIndicator].
  Widget _buildIndicator() {
    return Container(
      alignment: _axis == Axis.vertical
          ? (widget.reverse ? Alignment.topCenter : Alignment.bottomCenter)
          : (widget.reverse ? Alignment.centerLeft : Alignment.centerRight),
      height: _axis == Axis.vertical ? _actualTriggerOffset : double.infinity,
      width: _axis == Axis.horizontal ? _actualTriggerOffset : double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          if (_mode == IndicatorMode.inactive &&
              _result == IndicatorResult.noMore)
            widget.noMoreIcon ?? const Icon(Icons.inbox_outlined),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double offset = _offset;
    if (widget.state.indicator.infiniteOffset != null &&
        widget.state.indicator.position == IndicatorPosition.locator &&
        (_mode != IndicatorMode.inactive ||
            _result == IndicatorResult.noMore)) {
      offset = _actualTriggerOffset;
    }
    final padding = math.max(_offset - _kCircularProgressIndicatorSize, 0) / 2;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: _axis == Axis.vertical ? double.infinity : offset,
          height: _axis == Axis.horizontal ? double.infinity : offset,
        ),
        if (widget.showBezierBackground)
          Positioned(
            top: _axis == Axis.vertical
                ? widget.reverse
                    ? null
                    : 0
                : 0,
            left: _axis == Axis.horizontal
                ? widget.reverse
                    ? null
                    : 0
                : 0,
            right: _axis == Axis.horizontal
                ? widget.reverse
                    ? 0
                    : null
                : 0,
            bottom: _axis == Axis.vertical
                ? widget.reverse
                    ? 0
                    : null
                : 0,
            child: BezierBackground(
              state: widget.state,
              color: widget.bezierBackgroundColor,
              useAnimation: widget.bezierBackgroundAnimation,
              bounce: widget.bezierBackgroundBounce,
              reverse: widget.reverse,
            ),
          ),
        Positioned(
          top: _axis == Axis.vertical
              ? widget.reverse
                  ? padding
                  : null
              : 0,
          bottom: _axis == Axis.vertical
              ? widget.reverse
                  ? null
                  : padding
              : 0,
          left: _axis == Axis.horizontal
              ? widget.reverse
                  ? padding
                  : null
              : 0,
          right: _axis == Axis.horizontal
              ? widget.reverse
                  ? null
                  : padding
              : 0,
          child: Center(
            child: _buildIndicator(),
          ),
        ),
      ],
    );
  }
}
