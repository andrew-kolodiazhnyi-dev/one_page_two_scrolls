import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';

import '../../utils/tab_builder.dart';
import 'home_page_tab_type.dart';
import 'views/home_page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabsBuilder(
        tabs: HomePageTabType.values,
        tabBuilder: (item) => item.getTabTile(),
        tabViewBuilder: (item) => item.getTabView(),
        builder: (context, tabBar, tabView, controller) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildHeader(),
                _buildSomeUI(),
                _buildTabBar(tabBar),
              ];
            },
            body: tabView,
          );
        },
      ),
    );
  }

  Widget _buildTabBar(Widget tabBar) {
    return SliverPinnedToBoxAdapter(
      child: tabBar,
    );
  }

  Widget _buildSomeUI() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: SizedBox(
          height: 160,
          child: Center(
            child: Text('Here could be some UI'),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: HomePageHeader(
        title: 'Title',
        subtitle: 'Subtitle',
        backgroungImagePath: 'assets/images/background.jpg',
      ),
    );
  }
}
