import 'package:flutter/material.dart';

const double defaultCompactBreakpoint = 0;
const double defaultMediumBreakpoint = 600;
const double defaultExpandedBreakpoint = 840;

/// a group of breakpoints which already includes default breakpoint values
/// abiding to the Material 3 Design Spec.
class Breakpoints {
  static Breakpoint compact =
      const ThisBreakpoint(width: defaultCompactBreakpoint);

  static Breakpoint medium =
      const ThisBreakpoint(width: defaultMediumBreakpoint);

  static Breakpoint expanded =
      const ThisBreakpoint(width: defaultExpandedBreakpoint);
}

/// a class that extends Breakpoint that generates it depending on the width of
/// the screen
class ThisBreakpoint extends Breakpoint {
  const ThisBreakpoint({
    required this.width,
  });
  final double width;
  @override
  bool isActive(BuildContext context) {
    return MediaQuery.of(context).size.width >= width;
  }
}

/// interface to define features that distinguish between breakpoints
///
/// for instance, these breakpoints distinguish between the context of different
/// screens or width of these screens.
abstract class Breakpoint {
  /// returns a [Breakpoint]
  const Breakpoint();

  /// boolean method that returns true if meets criteria based on the context
  /// of the screen (MediaQuery).
  bool isActive(BuildContext context);
}
