import 'package:adaptive_layout_large_screen/src/adaptive_layout.dart';
import 'package:adaptive_layout_large_screen/src/slot.dart';
import 'package:adaptive_layout_large_screen/src/slot_widget.dart';
import 'package:adaptive_layout_large_screen/src/breakpoints.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Breakpoint> breakpoints = [
      Breakpoints.compact,
      Breakpoints.medium,
      Breakpoints.expanded
    ];
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AdaptiveLayout.custom(
          backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
          topPanel: Slot(
            breakpointWidgets: {
              Breakpoints.compact: SlotWidget(
                  key: const Key('AppBar1'),
                  animation: outToDown,
                  child: AdaptiveLayout.appBarBuilder(
                    backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
                    title: const Text("Adaptive Layout Widget"),
                    height: 50,
                    titleTextStyle:
                        TextStyle(color: Colors.grey[800], fontSize: 20),
                  )),
            },
          ),
          bottomPanel: Slot(
            breakpointWidgets: {
              Breakpoints.compact: SlotWidget(
                  key: const Key("BottomPanel1"),
                  animation: outToUp,
                  child: AdaptiveLayout.bottomNavigationBuilder(
                    backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
                    navDestinations: _navDestinations,
                  )),
              Breakpoints.medium: SlotWidget.verticalAnimatedSlotEmpty(),
            },
          ),
          rightPanel: Slot(
            breakpointWidgets: {
              Breakpoints.compact: SlotWidget.horizontalAnimatedSlotEmpty(),
              Breakpoints.medium: SlotWidget(
                  key: const Key("RightPanel1"),
                  animation: outToLeft,
                  child: SizedBox(
                      width: 60,
                      child: Container(
                        color: Colors.purple,
                      ))),
              Breakpoints.expanded: SlotWidget(
                  key: const Key("RightPanel2"),
                  animation: outToLeft,
                  child: SizedBox(
                      width: 130,
                      child: Container(
                        color: Colors.purple,
                      ))),
            },
          ),
          leftPanel: Slot(
            breakpointWidgets: {
              Breakpoints.compact: SlotWidget.horizontalAnimatedSlotEmpty(),
              Breakpoints.medium: SlotWidget(
                  key: const Key("NavRail2"),
                  animation: outToRight,
                  child: AdaptiveLayout.navigationRailBuilder(
                      backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
                      navDestinations: _navDestinations,
                      extended: false)),
              Breakpoints.expanded: SlotWidget(
                  key: const Key("NavRail3"),
                  animation: outToRight,
                  child: AdaptiveLayout.navigationRailBuilder(
                      backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
                      navDestinations: _navDestinations,
                      extended: true)),
            },
          ),
          body: Slot(
            breakpointWidgets: {
              Breakpoints.compact: SlotWidget(
                key: const Key("Body1"),
                child: AdaptiveLayout.toMaterialGrid(
                    context: context,
                    itemColumns: 1,
                    margin: 16,
                    breakpoints: breakpoints,
                    thisWidgets: [
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 75,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 150,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 180,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                    ]),
              ),
              Breakpoints.medium: SlotWidget(
                key: const Key("Body2"),
                child: AdaptiveLayout.toMaterialGrid(
                    context: context,
                    itemColumns: 3,
                    margin: 16,
                    breakpoints: breakpoints,
                    thisWidgets: [
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 75,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 150,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 180,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Container(color: Colors.purple),
                      ),
                    ]),
              ),
            },
          ),
          breakpoints: [
            Breakpoints.compact,
            Breakpoints.medium,
            Breakpoints.expanded
          ],
        ));
  }
}

const List<NavigationDestination> _navDestinations = <NavigationDestination>[
  NavigationDestination(label: 'Featured', icon: Icon(Icons.featured_video)),
  NavigationDestination(label: 'Chat', icon: Icon(Icons.chat_bubble_outline)),
  NavigationDestination(label: 'Rooms', icon: Icon(Icons.room)),
  NavigationDestination(label: 'Meet', icon: Icon(Icons.video_call_outlined)),
];

// inToBottom Animation
AnimatedWidget inToBottom(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1))
        .animate(controller),
    child: widget,
  );
}

// inToTop Animation
AnimatedWidget inToTop(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1))
        .animate(controller),
    child: widget,
  );
}

// inToRight Animation
AnimatedWidget inToRight(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: Offset.zero, end: const Offset(1, 0))
        .animate(controller),
    child: widget,
  );
}

// inToLeft Animation
AnimatedWidget inToLeft(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0))
        .animate(controller),
    child: widget,
  );
}

// outToDown Animation
AnimatedWidget outToDown(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(controller),
    child: widget,
  );
}

// outToUp Animation
AnimatedWidget outToUp(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(controller),
    child: widget,
  );
}

// outToLeft Animation
AnimatedWidget outToLeft(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(controller),
    child: widget,
  );
}

// outToRight Animation
AnimatedWidget outToRight(Widget widget, AnimationController controller) {
  return SlideTransition(
    position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(controller),
    child: widget,
  );
}
