import 'package:flutter/material.dart';
import 'package:adaptive_layout_large_screen/src/breakpoints.dart';
import 'package:adaptive_layout_large_screen/src/slot.dart';
import 'package:adaptive_layout_large_screen/src/slot_widget.dart';
import 'package:masonry_grid/masonry_grid.dart';

const String topPanelKey = 'topPanel';
const String bottomPanelKey = 'bottomPanel';
const String leftPanelKey = 'leftPanel';
const String rightPanelKey = 'rightPanel';
const String bodyKey = 'bodyPanel';

const double materialGutterValue = 8;
const double materialCompactMinMargin = 8;
const double materialMediumMinMargin = 12;
const double materialExpandedMinMargin = 32;

class AdaptiveLayout extends StatefulWidget {
  /// bool value to call the material constructor
  ///
  /// default to false
  bool? useMaterial = false;

  /// bool value to call the custom constructor
  ///
  /// default to false
  bool? useCustom = false;

  /// List of [NavigationDestination]s used in navigation items such as
  /// [BottomNavigationBar] and [NavigationRail] which will respectively have
  /// [BottomNavigationBarItem] and [NavigationRailDestination].
  List<NavigationDestination>? navDestinations;

  /// selected index used in [NavigationRail]
  int? selectedIndex;

  /// Widget to be displayed in the body at the smallest or compact breakpoint
  Widget? compactBody;

  /// Widget to be displayed in the body at the middle or medium breakpoint
  Widget? mediumBody;

  /// Widget to be displayed in the body at the largest or expanded breakpoint
  Widget? expandedBody;

  /// Widget to be displayed in the top panel
  Widget? topWidget;

  /// Slot placed at the top of the screen
  Slot? topPanel;

  /// Slot placed at the bottom of the screen
  Slot? bottomPanel;

  /// Slot placed at the left of the screen
  Slot? leftPanel;

  /// Slot placed at the right of the screen
  Slot? rightPanel;

  /// Slot placed at the body of the screen
  Slot? body;

  /// Color of the background of the app
  Color? backgroundColor;

  List<Breakpoint>? breakpoints = [
    Breakpoints.compact,
    Breakpoints.medium,
    Breakpoints.expanded
  ];

  AdaptiveLayout.material({
    Key? key,
    this.useMaterial = true,
    this.backgroundColor,
    this.navDestinations,
    this.selectedIndex,
    this.topWidget,
    this.compactBody,
    this.mediumBody,
    this.expandedBody,
    this.breakpoints,
  }) : super(key: key);

  AdaptiveLayout.custom({
    Key? key,
    this.useCustom = true,
    this.backgroundColor,
    this.topPanel,
    this.bottomPanel,
    this.rightPanel,
    this.leftPanel,
    this.body,
    this.breakpoints,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (useMaterial == true) {
      return _MaterialAdaptiveLayoutState();
    } else {
      return _CustomAdaptiveLayoutState();
    }
  }

  /// Public helper method to be used for creating a [MasonryGrid] following m3
  /// specs from a list of [Widget]s
  static Builder toMaterialGrid({
    List<Widget> thisWidgets = const [],
    List<Breakpoint> breakpoints = const [],
    double margin = 0,
    int itemColumns = 0,
    required BuildContext context,
  }) {
    return Builder(builder: ((context) {
      Breakpoint? currentBreakpoint;
      for (Breakpoint breakpoint in breakpoints) {
        if (breakpoint.isActive(context)) {
          currentBreakpoint = breakpoint;
        }
      }
      double? thisMargin = margin;

      if (currentBreakpoint == Breakpoints.compact) {
        if (thisMargin < materialCompactMinMargin) {
          thisMargin = materialCompactMinMargin;
        }
      } else if (currentBreakpoint == Breakpoints.medium) {
        if (thisMargin < materialMediumMinMargin) {
          thisMargin = materialMediumMinMargin;
        }
      } else if (currentBreakpoint == Breakpoints.expanded) {
        if (thisMargin < materialExpandedMinMargin) {
          thisMargin = materialExpandedMinMargin;
        }
      }
      return CustomScrollView(
        primary: false,
        controller: ScrollController(),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(thisMargin),
              child: MasonryGrid(
                column: itemColumns,
                crossAxisSpacing: materialGutterValue,
                mainAxisSpacing: materialGutterValue,
                children: thisWidgets,
              ),
            ),
          ),
        ],
      );
    }));
  }

  static Widget appBarBuilder({
    Widget? leading,
    double leadingWidth = 0,
    double height = 40,
    Widget? title,
    double elevation = 0,
    Color backgroundColor = Colors.transparent,
    NavigationRailLabelType labelType = NavigationRailLabelType.none,
    TextStyle? titleTextStyle,
  }) {
    return SizedBox(
      height: height,
      child: AppBar(
        elevation: elevation,
        leading: leading,
        leadingWidth: leadingWidth,
        title: title,
        backgroundColor: backgroundColor,
        titleTextStyle: titleTextStyle,
      ),
    );
  }

  static Widget navigationRailBuilder({
    required List<NavigationDestination> navDestinations,
    Widget? trailing,
    int selectedIndex = 0,
    double width = 72,
    bool extended = false,
    Color backgroundColor = Colors.transparent,
    IconThemeData selectedIconTheme = const IconThemeData(color: Colors.black),
    IconThemeData unselectedIconTheme =
        const IconThemeData(color: Colors.black),
    TextStyle selectedLabelTextStyle = const TextStyle(color: Colors.black),
  }) {
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: (extended == true) ? 150 : width,
            height: MediaQuery.of(context).size.height,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                        selectedIconTheme: selectedIconTheme,
                        selectedLabelTextStyle: selectedLabelTextStyle,
                        unselectedIconTheme: unselectedIconTheme,
                        trailing: trailing,
                        backgroundColor: backgroundColor,
                        extended: extended,
                        selectedIndex: selectedIndex,
                        destinations: <NavigationRailDestination>[
                          for (NavigationDestination destination
                              in navDestinations)
                            NavigationRailDestination(
                              label: Text(destination.label),
                              icon: destination.icon,
                            )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static Widget bottomNavigationBuilder({
    required List<NavigationDestination> navDestinations,
    int currentIndex = 0,
    double iconSize = 24,
    Color unselectedItemColor = Colors.black,
    Color backgroundColor = Colors.transparent,
    Color? selectedItemColor = Colors.black,
    BottomNavigationBarType type = BottomNavigationBarType.shifting,
  }) {
    List<BottomNavigationBarItem> bottomNavigationBarItems = [];
    for (NavigationDestination navigationDestination in navDestinations) {
      bottomNavigationBarItems.add(BottomNavigationBarItem(
          label: navigationDestination.label,
          icon: navigationDestination.icon));
    }
    return BottomNavigationBar(
        type: type,
        currentIndex: currentIndex,
        iconSize: iconSize,
        unselectedItemColor: unselectedItemColor,
        backgroundColor: backgroundColor,
        selectedItemColor: selectedItemColor,
        items: bottomNavigationBarItems);
  }
}

class _MaterialAdaptiveLayoutState extends State<AdaptiveLayout> {
  @override
  Widget build(BuildContext context) {
    Slot topPanel = Slot(
      breakpointWidgets: {
        Breakpoints.compact: SlotWidget(
          key: const Key('AppBar1'),
          child: widget.topWidget,
        )
      },
    );
    Slot bottomPanel = Slot(
      breakpointWidgets: {
        Breakpoints.compact: SlotWidget(
            key: const Key("BottomPanel1"),
            child: AdaptiveLayout.bottomNavigationBuilder(
              backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
              navDestinations: widget.navDestinations!,
            )),
        Breakpoints.medium: const SlotWidget(
            key: Key("BottomPanel2"),
            child: SizedBox(
              width: 0,
              height: 0,
            )),
      },
    );
    Slot leftPanel = Slot(
      breakpointWidgets: {
        Breakpoints.compact: const SlotWidget(
            key: Key("NavRail1"),
            child: SizedBox(
              height: 0,
              width: 0,
            )),
        Breakpoints.medium: SlotWidget(
            key: const Key("NavRail2"),
            child: AdaptiveLayout.navigationRailBuilder(
                backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
                navDestinations: widget.navDestinations!,
                extended: false)),
        Breakpoints.expanded: SlotWidget(
            key: const Key("NavRail3"),
            child: AdaptiveLayout.navigationRailBuilder(
                backgroundColor: const Color.fromRGBO(242, 231, 248, 1),
                navDestinations: widget.navDestinations!,
                extended: true)),
      },
    );

    Map<Breakpoint, SlotWidget> breakpointWidgets2 = {};
    SlotWidget? compactBodySlot = (widget.compactBody != null)
        ? SlotWidget(
            key: const Key("BodyPanel1"),
            child: widget.compactBody,
          )
        : null;
    if (compactBodySlot != null) {
      breakpointWidgets2.addAll({Breakpoints.compact: compactBodySlot});
    }

    SlotWidget? mediumBodySlot = (widget.mediumBody != null)
        ? SlotWidget(
            key: const Key("BodyPanel2"),
            child: widget.mediumBody,
          )
        : null;
    if (mediumBodySlot != null) {
      breakpointWidgets2.addAll({Breakpoints.medium: mediumBodySlot});
    }

    SlotWidget? expandedBodySlot = (widget.expandedBody != null)
        ? SlotWidget(
            key: const Key("BodyPanel3"),
            child: widget.expandedBody,
          )
        : null;
    if (expandedBodySlot != null) {
      breakpointWidgets2.addAll({Breakpoints.expanded: expandedBodySlot});
    }

    Slot bodyPanel = Slot(
      breakpointWidgets: breakpointWidgets2,
    );
    Slot rightPanel = Slot(
      breakpointWidgets: {
        Breakpoints.compact: const SlotWidget(),
      },
    );

    return AdaptiveLayout.custom(
      backgroundColor: widget.backgroundColor,
      topPanel: topPanel,
      bottomPanel: bottomPanel,
      leftPanel: leftPanel,
      body: bodyPanel,
      rightPanel: rightPanel,
    );
  }
}

class _CustomAdaptiveLayoutState extends State<AdaptiveLayout> {
  @override
  Widget build(BuildContext context) {
    Map<String, Slot> totalSlots = {};
    List<Widget> totalWidgets = [];
    totalSlots.addAll({topPanelKey: widget.topPanel!});
    totalSlots.addAll({bottomPanelKey: widget.bottomPanel!});
    totalSlots.addAll({leftPanelKey: widget.leftPanel!});
    totalSlots.addAll({rightPanelKey: widget.rightPanel!});
    totalSlots.addAll({bodyKey: widget.body!});

    totalSlots.forEach(((key, value) {
      totalWidgets.add(LayoutId(id: key, child: value));
    }));

    return Container(
        color: widget.backgroundColor,
        child: CustomMultiChildLayout(
          delegate: _AdaptiveLayoutDelegate(
            totalSlots: totalSlots,
          ),
          children: totalWidgets,
        ));
  }
}

// responsible for delegating the slots in the correct positions
class _AdaptiveLayoutDelegate extends MultiChildLayoutDelegate {
  final Map<String, Slot>? totalSlots;

  _AdaptiveLayoutDelegate({
    this.totalSlots,
  });

  @override
  void performLayout(Size size) {
    double top = 0;
    double bottom = 0;
    double left = 0;
    double right = 0;

    if (hasChild(leftPanelKey)) {
      Size panelSize = layoutChild(leftPanelKey, BoxConstraints.loose(size));
      positionChild(leftPanelKey, Offset(left, top));
      left += panelSize.width;
    }

    if (hasChild(rightPanelKey)) {
      Size panelSize = layoutChild(rightPanelKey, BoxConstraints.loose(size));
      positionChild(rightPanelKey, Offset(size.width - panelSize.width, 0));
      right += panelSize.width;
    }

    if (hasChild(topPanelKey)) {
      Size panelSize = layoutChild(topPanelKey, BoxConstraints.loose(size));
      positionChild(topPanelKey, Offset.zero);
      top += panelSize.height;
    }

    if (hasChild(bottomPanelKey)) {
      Size panelSize = layoutChild(bottomPanelKey, BoxConstraints.loose(size));
      positionChild(bottomPanelKey, Offset(0, size.height - panelSize.height));
      bottom += panelSize.height;
    }

    final double bodyWidth = size.width - right - left;
    final double bodyHeight = size.height - bottom - top;

    if (hasChild(bodyKey)) {
      layoutChild(bodyKey, BoxConstraints.tight(Size(bodyWidth, bodyHeight)));
      positionChild(bodyKey, Offset(left, top));
    }
  }

  @override
  bool shouldRelayout(covariant _AdaptiveLayoutDelegate oldDelegate) {
    return oldDelegate.totalSlots != totalSlots;
  }
}
