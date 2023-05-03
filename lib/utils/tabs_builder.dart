import 'package:flutter/material.dart';

typedef TabsWidgetBuilder<T> = Widget Function(
  BuildContext context,
  Widget tabBar,
  Widget tabView,
  TabController controller,
);

class TabsBuilder<T> extends StatefulWidget {
  final List<T> tabs;
  final Widget Function(T item) tabBuilder;
  final Widget Function(T item) tabViewBuilder;
  final TabsWidgetBuilder<T> builder;

  const TabsBuilder({
    Key? key,
    required this.tabs,
    required this.builder,
    required this.tabBuilder,
    required this.tabViewBuilder,
  }) : super(key: key);

  @override
  State<TabsBuilder<T>> createState() => _TabsBuilderState<T>();
}

class _TabsBuilderState<T> extends State<TabsBuilder<T>>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _buildTabBar(),
      _buildTabBarView(),
      _tabController,
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            automaticIndicatorColorAdjustment: false,
            controller: _tabController,
            labelColor: Colors.black,
            labelStyle: const TextStyle(fontSize: 18),
            indicatorColor: Colors.purple,
            indicatorWeight: 2,
            padding: EdgeInsets.zero,
            isScrollable: true,
            tabs: List.generate(
              widget.tabs.length,
              (index) {
                return widget.tabBuilder(
                  widget.tabs[index],
                );
              },
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black54,
          )
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: widget.tabs.map((type) => widget.tabViewBuilder(type)).toList(),
    );
  }
}
