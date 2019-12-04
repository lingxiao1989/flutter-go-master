import 'dart:async';
import 'package:flutter_go/event/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_go/components/main_app_bar.dart';
import './values_contents_page.dart';
import './sub_page.dart';
import './search_page.dart';

class _Page {
  final String labelId;

  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  _Page('Spending'),
  _Page('Award Night'),
  _Page('Award Ticket'),
];
class ValuesMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyValuesPageState();
  }
}
class _MyValuesPageState extends State<ValuesMainPage> {
  StreamSubscription _popSheetSubscription;
  bool _hideTitleBar=false;
  @override
  void initState(){
    super.initState();
    _popSheetSubscription = eventBus.on<ApplicationEvent>().listen((event) {
      //缓存主题色
      //_cacheColor(event.popSheetEvent);
      //bool hideNavigationBar = AppColors.getColor(event.popSheetEvent);
      print('popSheetEvent received');
      setState(() {
        _hideTitleBar = event.popSheetEvent;
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
    _popSheetSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    print("MainPagess build......");
    return  DefaultTabController(
        length: _allPages.length,
        child: Scaffold(
          appBar: new MyAppBar(
            //leading: Container(
                //child: new ClipOval(
                  //child: Image.network(
                    //'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658',
                    //scale: 15.0,
                  //),
                //)
            //),
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: _hideTitleBar
                ?SizedBox(height: 0.0)
                :TabLayout(),
            //actions: <Widget>[
              //IconButton(icon:  Icon(Icons.search), onPressed: () {
                   // pushPage(context, SearchPage(), pageName: "SearchPage");})
            //],
          ),
          body:  TabBarViewLayout(),
//          drawer:  Drawer(
//            child:  MainLeftPage(),
//          ),
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
      case 'Spending':
        return FirstPage();
        break;
      case 'Award Night':
        return Container();
        break;
      case 'Award Ticket':
        return SubPage();
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
