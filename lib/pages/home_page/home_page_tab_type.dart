import 'package:flutter/material.dart';

import 'tabs/tab_1.dart';
import 'tabs/tab_2.dart';
import 'tabs/tab_3.dart';

enum HomePageTabType {
  tab1,
  tab2,
  tab3;

  String _getLabel() {
    switch (this) {
      case HomePageTabType.tab1:
        return 'Tab1';
      case HomePageTabType.tab2:
        return 'Tab2';
      case HomePageTabType.tab3:
        return 'Tab3';
    }
  }

  Widget getTabTile() {
    return Tab(
      iconMargin: EdgeInsets.zero,
      height: 24,
      child: Text(
        _getLabel(),
        textAlign: TextAlign.left,
        maxLines: 1,
      ),
    );
  }

  Widget getTabView() {
    switch (this) {
      case HomePageTabType.tab1:
        return const Tab1();
      case HomePageTabType.tab2:
        return const Tab2();
      case HomePageTabType.tab3:
        return const Tab3();
    }
  }
}
