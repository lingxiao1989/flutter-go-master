import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _Page {
  final String labelId;
  _Page(this.labelId);
}

class addCardPage extends StatefulWidget {
  @override
  addCardPageState createState() => new addCardPageState();
}

class addCardPageState extends State<addCardPage> {
  final List<_Page> _allPages = <_Page>[
    _Page('Credit Cards'),
    _Page('Gift Cards & Vouchers'),
  ];

  @override
  Widget build(BuildContext context) {
    print("MainPagess build......");
    return  DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        appBar: TabBar(tabs: null),
        body:  Container(),
      )
    );
  }
}

