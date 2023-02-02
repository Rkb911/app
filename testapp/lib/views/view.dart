import 'package:flutter/material.dart';
// import 'package:one_ui/src/physics/scroll_physics.dart';
// import 'package:one_ui/src/widgets/appbar/appbar.dart';

const double _kPhoneExpandedAppBarHeightFactor = 0.3976;
const double _kTabletExpandedAppBarHeightFactor = 0.1878;
const BorderRadius _kRadius = BorderRadius.all(Radius.circular(25.0));

class MainView extends StatefulWidget {
  const MainView({
    Key? key,
    required this.title,
    this.tabBarLength = 1,
    this.scrollController,
    this.tabBarController,
    this.automaticallyImplyLeading = true,
    this.largeTitle,
    this.largeTitleTextStyle,
    this.actions,
    this.collapsedHeight = 2 * kToolbarHeight,
    this.expandedHeight,
    this.expandedHeightRatio,
    this.actionSpacing,
    this.backgroundColor,
    this.child,
    this.slivers,
    this.globalKey,
    this.bottom,
    this.initCollapsed = false,
  })  : assert(child != null || slivers != null),
        assert(expandedHeight == null || expandedHeightRatio == null),
        super(key: key);

  /// The text to display on expanded app bar.
  final Widget? largeTitle;

  /// The style to use for large title text.
  final TextStyle? largeTitleTextStyle;

  final ScrollController? scrollController;
  final TabController? tabBarController;

  /// The text to display on collapsed app bar.
  /// If null, it shows [largeTitle].
  final Widget title;

  final int? tabBarLength;

  /// {@macro  .appbar.actions}
  ///
  /// This property is used to configure an [ AppBar].
  final List<Widget>? actions;

  /// {@macro  .appbar.automaticallyImplyLeading}
  ///
  /// This property is used to configure an [ AppBar].
  final bool automaticallyImplyLeading;

  /// If true, use default One UI text style.

  /// The size of the app bar when it is fully expanded.
  ///
  ///
  /// This height should be big
  /// enough to accommodate whatever that widget contains.
  ///
  /// This does not include the status bar height (which will be automatically
  /// included if [primary] is true).
  ///
  /// Either [expandedHeight] or [expandedHeightRatio] must be null.
  ///
  /// | Ratation  | Phone                                 | Tablet                                |
  /// |-----------|---------------------------------------|---------------------------------------|
  /// | Portrait  | 0.3976 * [MediaQueryData.size.height] | 0.1878 * [MediaQueryData.size.height] |
  /// | Landscape | [collapsedHeight]                     | 0.1878 * [MediaQueryData.size.height] |
  /// {@endtemplate}
  final double? expandedHeight;

  /// The ratio of the app bar
  /// to screen height when it is fully expanded.
  ///
  /// {@macro  .view.expandedHeight}
  final double? expandedHeightRatio;

  /// Defines the height of the app bar when it is collapsed.
  ///
  /// By default, the collapsed height is [toolbarHeight]. If [bottom] widget is
  /// specified, then its height from [PreferredSizeWidget.preferredSize] is
  /// added to the height. If [primary] is true, then the [MediaQuery] top
  /// padding, [EdgeInsets.top] of [MediaQueryData.padding], is added as well.
  ///
  /// If [pinned] and [floating] are true, with [bottom] set, the default
  /// collapsed height is only the height of [PreferredSizeWidget.preferredSize]
  /// with the [MediaQuery] top padding.
  final double collapsedHeight;

  /// The space between [actions].
  final double? actionSpacing;

  /// The background color for app bar.
  final Color? backgroundColor;

  /// The widget below this widget in the tree.
  /// One of [child] and [slivers] must be null and the other must not be null.
  final Widget? child;

  /// The slivers to place inside the viewport.
  /// One of [child] and [slivers] must be null and the other must not be null.
  final List<Widget>? slivers;

  /// If true, display a default collapsed app bar.
  final bool initCollapsed;

  final Widget? bottom;

  /// The globalKey that is used to get innerScrollController
  /// of [NestedScrollViewState].
  final GlobalKey<NestedScrollViewState>? globalKey;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  double get expandedHeight {
    final Size size = MediaQuery.of(context).size;
    return widget.expandedHeight ??
        (widget.expandedHeightRatio != null
            ? widget.expandedHeightRatio! * size.height
            : (size.width > 600
                ? size.height > 600
                    ? _kTabletExpandedAppBarHeightFactor * size.height
                    : collapsedHeight
                : _kPhoneExpandedAppBarHeightFactor * size.height));
  }

  double get collapsedHeight => widget.collapsedHeight;

  @override
  void initState() {
    super.initState();
  }

  double _expandRatio(BoxConstraints constraints) {
    double expandRatio = (constraints.maxHeight - collapsedHeight) /
        (expandedHeight - collapsedHeight);

    if (expandRatio > 1.0) return 1.0;
    if (expandRatio < 0.0) return 0.0;
    return expandRatio;
  }

  Widget _expandedTitle(Animation<double> animation) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: expandedHeight,
        child: AppBar(
          leadingWidth: 48,
          leading: const Icon(
            Icons.menu_rounded,
            color: Colors.transparent,
          ),
          toolbarHeight: expandedHeight,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: widget.backgroundColor,
          shadowColor: widget.backgroundColor,
          automaticallyImplyLeading: false,
          backgroundColor: widget.backgroundColor,
          title: FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
                ),
              ),
              child: widget.largeTitle),
          centerTitle: false,
          // actions: widget.actions,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 0.0, curve: Curves.easeIn),
                ),
              ),
              child: widget.bottom!,
            ),
          ),
        ),
      ),
    );
  }

  Widget _collapsedAppBar(Animation<double> animation) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: collapsedHeight,
        child: AppBar(
          leadingWidth: 48,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          backgroundColor: widget.backgroundColor,
          title: FadeTransition(
            opacity: Tween(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
              ),
            ),
            child: widget.title,
          ),
          centerTitle: false,
          actions: widget.actions,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: FadeTransition(
                opacity: Tween(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.0, 0.0, curve: Curves.easeIn),
                  ),
                ),
                child: widget.bottom!),
          ),
        ),
      ),
    );
  }

  List<Widget> _appBar(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: widget.backgroundColor,
          shadowColor: widget.backgroundColor,
          pinned: true,
          floating: true,
          automaticallyImplyLeading: false,
          backgroundColor: widget.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: expandedHeight,
          toolbarHeight: collapsedHeight,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final expandRatio = _expandRatio(constraints);
              final animation = AlwaysStoppedAnimation(expandRatio);
              return Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  _expandedTitle(animation),
                  _collapsedAppBar(animation),
                ],
              );
            },
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = widget.child ??
        TabBarView(
            // clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            controller: widget.tabBarController,
            children: widget.slivers!);
    final Widget body = SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(top: collapsedHeight),
        child: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: child,
            );
          },
        ),
      ),
    );

    return SafeArea(
      bottom: false,
      child: NestedScrollView(
        // controller: widget.scrollController,
        // key: _nestedScrollViewStateKey,
        // physics:  ScrollPhysics(expandedHeight),
        headerSliverBuilder: _appBar,
        body: body,
      ),
    );
  }
}
