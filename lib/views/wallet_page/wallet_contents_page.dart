import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_go/components/list_view_item.dart';
import 'package:flutter_go/components/list_refresh.dart' as listComp;
import 'package:flutter_go/components/pagination.dart';
import 'package:flutter_go/views/wallet_page/second_page_item.dart';
import 'package:flutter_go/components/disclaimer_msg.dart';
import 'package:flutter_go/utils/net_utils.dart';
import 'package:flutter_go/model/category.dart';

// ValueKey<String> key;

class SecondPage extends StatefulWidget {
  @override
  SecondPageState createState() => new SecondPageState();
}

class SecondPageState extends State<SecondPage> with AutomaticKeepAliveClientMixin{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _unKnow;
  GlobalKey<DisclaimerMsgState> key;
  List<CategoryModel> Categories;
  List<dynamic> _categoryList = [
    {'id': 0, 'categoryName':'Non-bonused Spending', 'iconImage':'assets/images/Cate2.png'},
    {'id': 1, 'categoryName':'Restaurant', 'iconImage':'assets/images/restaurant.png'},
    {'id': 2, 'categoryName':'Groceries', 'iconImage':'assets/images/Cate4.png'},
    {'id': 3, 'categoryName':'Gas Station', 'iconImage':'assets/images/Cate3.png'},
    {'id': 4, 'categoryName':'Air Travel', 'iconImage':'assets/images/Cate1.png'},
    {'id': 5, 'categoryName':'a test', 'iconImage': null},
  ];
  //var _categories=['Non-bonused Spending', 'Restaurant', 'Groceries', 'Gas Station', 'Air Travel'];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (key == null) {
      key = GlobalKey<DisclaimerMsgState>();
      // key = const Key('__RIKEY1__');
      //获取sharePre
      _unKnow = _prefs.then((SharedPreferences prefs) {
        return (prefs.getBool('disclaimer::Boolean') ?? false);
      });

      /// 判断是否需要弹出免责声明,已经勾选过不在显示,就不会主动弹
      _unKnow.then((bool value) {
        new Future.delayed(const Duration(seconds: 1),(){
          if (!value && key.currentState is DisclaimerMsgState && key.currentState.showAlertDialog is Function) {
            key.currentState.showAlertDialog(context);
          }
        });
      });
    }
  }

  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
    const juejin_flutter = 'https://timeline-merger-ms.juejin.im/v1/get_tag_entry?src=web&tagId=5a96291f6fb9a0535b535438';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    final _param  = {'page':pageIndex,'pageSize':20,'sort':'rankIndex'};
    var responseList = [];
    var  pageTotal = 0;

    try{
      var response = await NetUtils.get(juejin_flutter, _param);
      responseList = response['d']['entrylist'];
      pageTotal = response['d']['total'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    }catch(e){

    }
    pageIndex += 1;
    List resultList = new List();
    for (int i = 0; i < responseList.length; i++) {
      try {
        SecondPageItem cellData = new SecondPageItem.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {"list":resultList, 'total':pageTotal, 'pageIndex':pageIndex};
    return result;
  }

  /// 每个item的样式
  Widget makeCard(index,item){
    var backPic= 'assets/images/goldCardPng.png';
    var myCardName = 'American Express® Gold'; //'${item.CardName}';
    var myProgramName = '4x Membership Reward Points'; //'${item.ProgramName}';
    //'${item.PointValue}';
    //'${item.CardImgID}';
    //var myTitle = '${item.title}';
    //var myUsername = '${'👲'}: ${item.username} ';
    var codeUrl = '${item.detailUrl}';
    return new ListViewItem(itemPic: backPic,itemUrl: codeUrl,itemTitle: myCardName,data: myProgramName,);
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: new Container(
            height: 220,
            color: const Color(0xff0047cc),
            child: Stack(
              children: <Widget>[
                PositionedDirectional(
                  top: 10,
                  start: 15,
                  child: SizedBox(
                    width: 106,
                    height: 28,
                    child: Text(
                      "Summary",
                      style: const TextStyle(
                        color:	const Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                        fontFamily: "Avenir",
                        fontStyle:	FontStyle.normal,
                        fontSize: 20.0
                      )
                    )
                  ),
                ),
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  bottom: -1,
                  child: Container(
                    height: 40,
                    color: const Color(0xfff8f9f9)
                  ),
                ),
                PositionedDirectional(
                  bottom: 5,
                  start: 15,
                  end: 15,
                  child: Container(
                    width: 343,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.grey[300], offset: Offset(1, 1), blurRadius: 1),
                        BoxShadow(color: Colors.grey[300], offset: Offset(-1, 1), blurRadius: 1)
                      ],
                      color: const Color(0xffffffff)
                    ),
                    child: Stack(
                      children: <Widget>[

                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: new Container(
            height: 40,
            child: Stack(
              children: <Widget>[
                PositionedDirectional(
                  top: 10,
                  start: 15,
                  child:
                  SizedBox(
                    width: 146,
                    height: 28,
                    child:	 Text(
                      "Credits Cards",
                      style: const TextStyle(
                      color:	const Color(0xff042c5c),
                      fontWeight: FontWeight.w600,
                      fontFamily: "ProximaNova",
                      fontStyle:	FontStyle.normal,
                      fontSize: 20.0
                      )
                    )
                  ),
                ),
              ]
            )
          ),
        ),
        listComp.ListRefresh(getIndexListData,makeCard),
        SliverToBoxAdapter(
          child: new Container(
            height: 40,
            child: Stack(
              children: <Widget>[
                PositionedDirectional(
                  top: 10,
                  start: 15,
                  child:
                  SizedBox(
                    width: 199,
                    height: 28,
                    child: Text(
                      "Gift Cards & Vouchers",
                      style: const TextStyle(
                        color:	const Color(0xff042c5c),
                        fontWeight: FontWeight.w600,
                        fontFamily: "ProximaNova",
                        fontStyle:	FontStyle.normal,
                        fontSize: 20.0
                      )
                    )
                  ),
                ),
              ]
            )
          ),
        ),//new ListView()

        //new listComp.ListRefresh(getIndexListData,makeCard),
          //child: new List(),
          //child: listComp.ListRefresh(getIndexListData,makeCard,headerView)
        listComp.ListRefresh(getIndexListData,makeCard),
      ]
    );
  }
}

