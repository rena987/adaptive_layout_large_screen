import 'package:adaptive_layout_large_screen/src/breakpoints.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_layout_large_screen/src/slot_widget.dart';

/// A Widget that takes a mapping of [SlotWidget]s to [Breakpoint]s and
/// adds the appropriate Widget based on the current screen size.
///
/// added in order to implement animations between the breakpoints
class Slot extends StatefulWidget {
  /// Map of [SlotWidget]s to [Breakpoint]s
  final Map<Breakpoint, SlotWidget>? breakpointWidgets;

  const Slot({
    this.breakpointWidgets,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SlotState();
}

class _SlotState extends State<Slot> with SingleTickerProviderStateMixin {
  late final ValueNotifier<Key> _animationTracker =
      ValueNotifier<Key>(const Key(' '));
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..forward();

  @override
  void initState() {
    _animationTracker.addListener(() {
      _controller.reset();
      _controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SlotWidget? thisWidget = const SlotWidget();
    bool exited = false;
    for (Breakpoint breakpoint in widget.breakpointWidgets!.keys) {
      if (breakpoint.isActive(context)) {
        thisWidget = widget.breakpointWidgets![breakpoint];
      }
    }

    if (thisWidget != null) _animationTracker.value = thisWidget.key!;

    return AnimatedSize(
      curve: Curves.easeIn,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
      child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          reverseDuration: const Duration(seconds: 1),
          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
            return Stack(
              children: <Widget>[
                if (exited)
                  ...previousChildren
                      .where((element) => currentChild!.key != element.key),
                if (currentChild != null) currentChild,
              ],
            );
          },
          transitionBuilder: (Widget child, Animation<double> animation) {
            final SlotWidget slotWidget = child as SlotWidget;

            if (slotWidget.animation == null) {
              return child;
            } else if (child.key != slotWidget.key) {
              exited = true;
            }
            return child.animation!(child, _controller);
          },
          child: thisWidget),
    );
  }
}
