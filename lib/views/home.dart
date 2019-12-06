/// Created with Android Studio.
/// User: 三帆
/// Date: 16/01/2019
/// Time: 11:16
/// email: sanfan.hx@alibaba-inc.com
/// target:  app首页
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_go/utils/shared_preferences.dart';
import 'package:flutter_go/views/values_page/values_contents_page.dart';
import 'package:flutter_go/views/values_page/values_main_page.dart';
import 'package:flutter_go/views/wallet_page/wallet_contents_page.dart';
import 'package:flutter_go/views/wallet_page/wallet_main_page.dart';
import 'package:flutter_go/views/widget_page/widget_page.dart';
import 'package:flutter_go/views/welcome_page/fourth_page.dart';
import 'package:flutter_go/views/collection_page/collection_page.dart';
import 'package:flutter_go/routers/application.dart';
import 'package:flutter_go/utils/provider.dart';
import 'package:flutter_go/model/widget.dart';
import 'package:flutter_go/widgets/index.dart';
import 'package:flutter_go/components/search_input.dart';
import 'package:flutter_go/model/search_history.dart';
import 'package:flutter_go/resources/widget_name_to_icon.dart';
import 'package:flutter_go/event/event_bus.dart';

const int ThemeColor = 0xFFC91B3A;

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<AppPage>
    with SingleTickerProviderStateMixin {
  bool _hideNavigationBar=false;
  StreamSubscription _popSheetSubscription;
  SpUtil sp;
  WidgetControlModel widgetControl = new WidgetControlModel();
  SearchHistoryList searchHistoryList;
  bool isSearch = false;
  String appBarTitle = tabData[0]['text'];
  List<Widget> _list = List();
  int _currentIndex = 0;
  static List tabData = [
    {'text': 'Values', 'icon': ImageIcon(AssetImage('assets/images/Values.png'))},
    {'text': 'Wallet', 'icon': ImageIcon(AssetImage('assets/images/Wallet.png'))},
    {'text': 'Benefits', 'icon': ImageIcon(AssetImage('assets/images/Benefits.png'))},
    {'text': 'Tasks', 'icon': ImageIcon(AssetImage('assets/images/Tasks.png'))},
    {'text': 'Others', 'icon': ImageIcon(AssetImage('assets/images/Offers.png'))},
  ];

  List<BottomNavigationBarItem> _myTabs = [];

  @override
  void initState() {
    super.initState();
    initSearchHistory();
    for (int i = 0; i < tabData.length; i++) {
      _myTabs.add(BottomNavigationBarItem(
        icon: tabData[i]['icon'],
        title: Text(
          tabData[i]['text'],
        ),
      ));
    }
    _list
      ..add(ValuesMainPage())
      ..add(WalletMainPage())
      ..add(WidgetPage(Provider.db))
      ..add(CollectionPage())
      ..add(FourthPage());

    //_setThemeColor();
    //订阅eventbus
    _popSheetSubscription = eventBus.on<ApplicationEvent>().listen((event) {
      //缓存主题色
      //_cacheColor(event.popSheetEvent);
      //bool hideNavigationBar = AppColors.getColor(event.popSheetEvent);
      print('popSheetEvent received');
      setState(() {
        _hideNavigationBar = event.popSheetEvent;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅
    _popSheetSubscription.cancel();
  }

  initSearchHistory() async {
    sp = await SpUtil.getInstance();
    String json = sp.getString(SharedPreferencesKeys.searchHistory);
    print("json $json");
    searchHistoryList = SearchHistoryList.fromJSON(json);
  }

  void onWidgetTap(WidgetPoint widgetPoint, BuildContext context) {
    List widgetDemosList = new WidgetDemoList().getDemos();
    String targetName = widgetPoint.name;
    String targetRouter = '/category/error/404';
    widgetDemosList.forEach((item) {
      if (item.name == targetName) {
        targetRouter = item.routerName;
      }
    });
    searchHistoryList
        .add(SearchHistory(name: targetName, targetRouter: targetRouter));
    print("searchHistoryList1 ${searchHistoryList.toString()}");
    print("searchHistoryList2 ${targetRouter}");
    print("searchHistoryList3 ${widgetPoint.name}");
    Application.router.navigateTo(context, "$targetRouter");
  }

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
        List<WidgetPoint> list = await widgetControl.search(value);
        return list
            .map((item) => new MaterialSearchResult<String>(
                  value: item.name,
                  icon: WidgetName2Icon.icons[item.name] ?? null,
                  text: 'widget',
                  onTap: () {
                    onWidgetTap(item, context);
                  },
                ))
            .toList();
      } else {
        return null;
      }
    }, (value) {}, () {});
  }

  renderAppBar(BuildContext context, Widget widget, int index) {
//    print('renderAppBar=====>>>>>>${index}');
//    if (index == 0) {
//      return null;
//    }
    return AppBar(title: buildSearchInput(context));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: renderAppBar(context, widget, _currentIndex),
      body: IndexedStack(
        index: _currentIndex,
        children: _list,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: const Color(0x14000000), offset: Offset(0,-3), blurRadius: 20)
            ],
        ),
        child: _hideNavigationBar
        ? SizedBox()
        : BottomNavigationBar(
            items: _myTabs,
            //高亮  被点击高亮
            currentIndex: _currentIndex,
            //修改 页面
            onTap: _itemTapped,
            //shifting :按钮点击移动效果
            //fixed：固定
            type: BottomNavigationBarType.fixed,

            fixedColor: Color(0xff0047cc),
        ),
      )
    );
  }

  void _itemTapped(int index) {
    setState(() {
      _currentIndex = index;
      appBarTitle = tabData[index]['text'];
    });
  }
/*
  _cacheColor(String colorStr) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("themeColorStr", colorStr);
  }

  Future<String> _getCacheColor(String colorKey) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String colorStr = sp.getString(colorKey);
    return colorStr;
  }

  void _setThemeColor() async {
    String cacheColorStr = await _getCacheColor("themeColorStr");
    setState(() {
      _primaryColor = AppColors.getColor(cacheColorStr);
    });
  }
*/
}
