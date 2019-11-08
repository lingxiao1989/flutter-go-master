import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go/components/main_app_bar.dart';
import './wallet_contents_page.dart';


class _Page {
  final String labelId;

  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  _Page('Cards'),
  _Page('Programs'),
  _Page('Bank Accounts'),
];

class WalletMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MainPagess build......");
    return  DefaultTabController(
        length: _allPages.length,
        child: Scaffold(
          appBar: new MyAppBar(
              centerTitle: true,
              title: TabLayout()
          ),
          body:  TabBarViewLayout(),

        ));
  }
}

void pushPage(BuildContext context, Widget page, {String pageName}) {
  if (context == null || page == null) return;
  Navigator.push(context, CupertinoPageRoute<void>(builder: (ctx) => page));
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  TabBar(
      isScrollable: true,
      //labelPadding: EdgeInsets.all(12.0),
      //labelPadding: EdgeInsets.only(top: 12.0,left: 12.0,right:12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages
          .map((_Page page) =>
          Tab(text: page.labelId))
          .toList(),
    );
  }
}

class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.labelId;
    switch (labelId) {
      case 'Cards':
        return Container();
        break;
      case 'Programs':
        return Container();
        break;
      case 'Bank Accounts':
        return Container();
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("TabBarViewLayout build.......");
    return TabBarView(
        children: _allPages.map((_Page page) {
          return buildTabView(context, page);
        }).toList());
  }
}
