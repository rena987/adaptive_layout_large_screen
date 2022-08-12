import 'package:flutter/material.dart';

class SlotWidget extends StatefulWidget {
  final Widget? child;

  final AnimatedWidget Function(Widget widget, AnimationController controller)?
      animation;

  const SlotWidget({
    this.child,
    this.animation,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SlotWidgetState();

  static horizontalAnimatedSlotEmpty() {
    return SlotWidget(
        key: const Key(""),
        child: Builder(
            builder: ((context) => Container(
                  width: 0,
                ))));
  }

  static verticalAnimatedSlotEmpty() {
    return SlotWidget(
        key: const Key(""),
        child: Builder(
            builder: ((context) => Container(
                  height: 0,
                ))));
  }
}

class _SlotWidgetState extends State<SlotWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child ??
        const SizedBox(
          height: 0,
          width: 0,
        );
  }
}
