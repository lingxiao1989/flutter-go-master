import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_go/components/list_view_item.dart';
import 'package:flutter_go/components/list_refresh.dart' as listComp;
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
                    //width: 343,
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
                        PositionedDirectional(
                          top:15,
                          start:15,
                          height: 50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "Total Cards",
                                    style: const TextStyle(
                                        color:  const Color(0xff77869e),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "ProximaNova",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 11.0
                                    )
                                )
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "10",
                                  style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                  )
                                )
                              )
                            ],
                          )
                        ),
                        PositionedDirectional(
                          top:15,
                          start:120,
                          height: 50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 100,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Annual Fees",
                                  style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                  )
                                )
                              ),
                              Container(
                                height: 20,
                                width: 100,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "\$799",
                                      style: const TextStyle(
                                          color:  const Color(0xff042c5c),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "ProximaNova",
                                          fontStyle:  FontStyle.normal,
                                          fontSize: 16.0
                                      )
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(5.0),
                                      color: const Color(0xff77869e),
                                      iconSize: 12.0,
                                      alignment: Alignment.topLeft,
                                      icon: Icon(Icons.error_outline),
                                      onPressed:(){},
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                        PositionedDirectional(
                          top:15,
                          start:220,
                          height: 50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 100,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Annual Credits",
                                  style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                  )
                                )
                              ),
                              Container(
                                height: 20,
                                width: 100,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "\$520+",
                                      style: const TextStyle(
                                        color:  const Color(0xff042c5c),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "ProximaNova",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 16.0
                                      )
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(5.0),
                                      color: const Color(0xff77869e),
                                      iconSize: 12.0,
                                      alignment: Alignment.topLeft,
                                      icon: Icon(Icons.error_outline),
                                      onPressed:(){},
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                        PositionedDirectional(
                          top:65,
                          start:15,
                          height: 50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "GCs & Vouchers",
                                  style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                  )
                                )
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "\$367.12",
                                  style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                  )
                                )
                              )
                            ],
                          )
                        ),
                        PositionedDirectional(
                          top:65,
                          start:120,
                          height: 50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Max Unit Value",
                                  style: const TextStyle(
                                      color:  const Color(0xff77869e),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "ProximaNova",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 11.0
                                  )
                                )
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        "1.6¢",
                                        style: const TextStyle(
                                            color:  const Color(0xff042c5c),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "ProximaNova",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 16.0
                                        )
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(5.0),
                                      color: const Color(0xff77869e),
                                      iconSize: 12.0,
                                      alignment: Alignment.topLeft,
                                      icon: Icon(Icons.error_outline),
                                      onPressed:(){},
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                        PositionedDirectional(
                          top:65,
                          start:220,
                          height: 50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "AmEx Slots",
                                    style: const TextStyle(
                                        color:  const Color(0xff77869e),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "ProximaNova",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 11.0
                                    )
                                )
                              ),
                              Container(
                                height: 20,
                                width: 80,
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "1/5",
                                    style: const TextStyle(
                                        color:  const Color(0xff042c5c),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "ProximaNova",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 16.0
                                    )
                                )
                              )
                            ],
                          )
                        ),
                        PositionedDirectional(
                          top:115,
                          start:15,
                          height:50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: 15,
                                  width: 140,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Next Annual Fee Due",
                                    style: const TextStyle(
                                        color:  const Color(0xff77869e),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "ProximaNova",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 11.0
                                    )
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 140,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        "Nov 1 2019",
                                        style: const TextStyle(
                                            color:  const Color(0xff042c5c),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "ProximaNova",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 16.0
                                        )
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(5.0),
                                      color: const Color(0xff77869e),
                                      iconSize: 12.0,
                                      alignment: Alignment.topLeft,
                                      highlightColor: const Color(0xffffffff),
                                      splashColor: const Color(0xffffffff),
                                      icon: Icon(Icons.error_outline),
                                      onPressed:(){},
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                        PositionedDirectional(
                          top:115,
                          start:155,
                          height:50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 140,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Opened in 24 Months",
                                  style: const TextStyle(
                                      color:  const Color(0xff77869e),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "ProximaNova",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 11.0
                                  )
                                )
                              ),
                              Container(
                                height: 20,
                                width: 140,
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        "2",
                                        style: const TextStyle(
                                            color:  const Color(0xff042c5c),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "ProximaNova",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 16.0
                                        )
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.all(5.0),
                                      color: const Color(0xff77869e),
                                      iconSize: 12.0,
                                      alignment: Alignment.topLeft,
                                      highlightColor: const Color(0xffffffff),
                                      splashColor: const Color(0xffffffff),
                                      icon: Icon(Icons.error_outline),
                                      onPressed:(){},
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
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

