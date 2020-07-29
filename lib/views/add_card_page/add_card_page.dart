import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go/components/main_app_bar.dart';

import './add_card_detail_page.dart';

class _Page {
  final String labelId;
  _Page(this.labelId);
}
final List<_Page> _allPages = <_Page>[
  _Page('Credit Cards'),
  _Page('Gift Cards & Vouchers'),
];
class addCardPage extends StatefulWidget {
  @override
  addCardPageState createState() => new addCardPageState();
}


class addCardPageState extends State<addCardPage> {


  @override
  Widget build(BuildContext context) {
    print("MainPagess build......");
    return  DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        appBar: MyAppBar(title: TabLayout()),
        body:  TabBarViewLayout(),
      )
    );
  }
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
      case 'Credit Cards':
        return SearchPage();
        break;
      case 'Gift Cards & Vouchers':
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

//ToDo: make a card searching page like this: https://www.jianshu.com/p/8d136f31b8a2