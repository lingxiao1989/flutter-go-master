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
  bool _viewCreditCard = true;
  bool _viewDebitCard = true;
  bool _viewGiftCard = false;
  bool _viewShowClosedCard = false;
  var _layoutDisplay = 1;

  var _display = 1;
  var _sortBy = 1;
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
  _showSettingSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(10.0),
          topRight: Radius.circular(10.0)
        )
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.76,
        child: Column(
          children:<Widget>[
            Container(
              height: 60,
              child:Stack(
                children:<Widget>[
                  PositionedDirectional(
                    top: 30,
                    start: 15,
                    end:15,
                    child: Container(
                        height: 20,
                        child: Text(
                            "View Options",
                            style: const TextStyle(
                                color:  const Color(0xff042c5c),
                                fontWeight: FontWeight.w500,
                                fontFamily: "ProximaNova",
                                fontStyle:  FontStyle.normal,
                                fontSize: 16.0
                            ),
                            textAlign: TextAlign.center
                        )
                    ),
                  ),
                  PositionedDirectional(
                      top: 1,
                      end: 1,
                      child: IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.clear),
                        color: const Color(0xff042c5c),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,right: 4),
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                    //secondary: const Icon(Icons.shutter_speed),
                    title: const Text(
                      'Credit Card',
                      style: const TextStyle(
                        color:  const Color(0xff042c5c),
                        fontWeight: FontWeight.w400,
                        fontFamily: "ProximaNova",
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.0
                      )
                    ),
                    value: _viewCreditCard,
                    activeColor: const Color(0xff0047cc),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                      _viewCreditCard=!_viewCreditCard;
                    },
                  ),
                  CheckboxListTile(
                    //secondary: const Icon(Icons.shutter_speed),
                    title: const Text(
                        'Debit Card',
                        style: const TextStyle(
                            color:  const Color(0xff042c5c),
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova",
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        )
                    ),
                    value: _viewDebitCard,
                    activeColor: const Color(0xff0047cc),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                      _viewDebitCard=!_viewDebitCard;
                    },
                  ),
                  CheckboxListTile(
                    //secondary: const Icon(Icons.shutter_speed),
                    title: const Text(
                        'Gift Card',
                        style: const TextStyle(
                            color:  const Color(0xff042c5c),
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova",
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        )
                    ),
                    value: _viewGiftCard,
                    activeColor: const Color(0xff0047cc),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                      _viewGiftCard=!_viewGiftCard;
                    },
                  ),
                  CheckboxListTile(
                    title: const Text(
                        'Show Closed Card',
                        style: const TextStyle(
                            color:  const Color(0xff042c5c),
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova",
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        )
                    ),
                    value: _viewShowClosedCard,
                    activeColor: const Color(0xff0047cc),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                      _viewShowClosedCard=!_viewShowClosedCard;
                    },
                  ),
                ]
              )
            ),
            Padding(
                padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
                child: Divider(height: 1.0, color: Colors.grey)
            ),
            Text(
              "Layout",
              style: const TextStyle(
                  color:  const Color(0xff042c5c),
                  fontWeight: FontWeight.w500,
                  fontFamily: "ProximaNova",
                  fontStyle:  FontStyle.normal,
                  fontSize: 16.0
              ),
              textAlign: TextAlign.center
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,right: 4, top: 10),
              child: Column(
                children: <Widget>[
                  RadioListTile(
                    title: const Text(
                        'List View',
                        style: const TextStyle(
                            color:  const Color(0xff042c5c),
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova",
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        )
                    ),
                    value: 1,
                    groupValue: _layoutDisplay,
                    activeColor: const Color(0xff0047cc),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                      _layoutDisplay=value;
                      //});
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                        'Slide View',
                        style: const TextStyle(
                            color:  const Color(0xff042c5c),
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova",
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        )
                    ),
                    //value: true,
                    value: 2,
                    groupValue: _layoutDisplay,
                    activeColor: const Color(0xff0047cc),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                      _layoutDisplay=value;
                    },
                  ),
                ]
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 30, right: 30),
              child: Container(
                height: 48,
                width: double.infinity,
                child: SizedBox(
                  height: 48,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)
                    ),
                    color: const Color(0xff0047cc),
                    onPressed: (){},
                    child:Text(
                      "Apply",
                      style: const TextStyle(
                          color:  const Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                          fontFamily: "ProximaNova",
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.center
                    )
                  )
                )
              )
            )
          ],
        )
      )
    );
  }

  _showSortingSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft:Radius.circular(10.0),
              topRight: Radius.circular(10.0)
          )
      ),
      context: context,
      builder: (context) =>FractionallySizedBox(
          heightFactor: 0.76,
          child: Column(
              children:<Widget>[
                Container(
                    height: 60,
                    child:Stack(
                      children:<Widget>[
                        PositionedDirectional(
                          top: 30,
                          start: 15,
                          end:15,
                          child: Container(
                              height: 20,
                              child: Text(
                                  "Display",
                                  style: const TextStyle(
                                      color:  const Color(0xff042c5c),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "ProximaNova",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 16.0
                                  ),
                                  textAlign: TextAlign.center
                              )
                          ),
                        ),
                        PositionedDirectional(
                            top: 1,
                            end: 1,
                            child: IconButton(
                              iconSize: 20,
                              icon: Icon(Icons.clear),
                              color: const Color(0xff042c5c),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            )
                        )
                      ],
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16,right: 4),
                    child: Column(
                        children: <Widget>[
                          RadioListTile(
                            title: const Text(
                                'Show Bank Account Name',
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                )
                            ),
                            value: 1,
                            groupValue: _display,
                            activeColor: const Color(0xff0047cc),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                              _display=value;
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                                'Show Next Statement Date',
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                )
                            ),
                            value: 2,
                            groupValue: _display,
                            activeColor: const Color(0xff0047cc),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                              _display=value;
                            },
                          ),
                        ]
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
                    child: Divider(height: 1.0, color: Colors.grey)
                ),
                Text(
                    "Sort by",
                    style: const TextStyle(
                        color:  const Color(0xff042c5c),
                        fontWeight: FontWeight.w500,
                        fontFamily: "ProximaNova",
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.0
                    ),
                    textAlign: TextAlign.center
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16,right: 4, top: 10),
                    child: Column(
                        children: <Widget>[
                          RadioListTile(
                            title: const Text(
                                'Card Name: A to Z',
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                )
                            ),
                            value: 1,
                            groupValue: _sortBy,
                            activeColor: const Color(0xff0047cc),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                              _sortBy=value;
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                                'Card Name: Z to A',
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                )
                            ),
                            value: 2,
                            groupValue: _sortBy,
                            activeColor: const Color(0xff0047cc),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                              _sortBy=value;
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                                'Account Opening Date: New to Old',
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                )
                            ),
                            value: 3,
                            groupValue: _sortBy,
                            activeColor: const Color(0xff0047cc),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                              _sortBy=value;
                            },
                          ),
                          RadioListTile(
                            title: const Text(
                                'Account Opening Date: Old to New',
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                )
                            ),
                            value: 4,
                            groupValue: _sortBy,
                            activeColor: const Color(0xff0047cc),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                              _sortBy=value;
                            },
                          ),
                        ]
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, left: 30, right: 30),
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)
                        ),
                        color: const Color(0xff0047cc),
                        onPressed: (){},
                        child:Text(
                            "Apply",
                            style: const TextStyle(
                                color:  const Color(0xffffffff),
                                fontWeight: FontWeight.w500,
                                fontFamily: "ProximaNova",
                                fontStyle:  FontStyle.normal,
                                fontSize: 16.0
                            ),
                            textAlign: TextAlign.center
                        )
                    ),
                  ),
                )
              ]
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: new Container(
              height: 220,
              color: const Color(0xff0047cc),
              child: Stack(
                children: <Widget>[
                  PositionedDirectional(
                    top: 10,
                    start: 18,
                    child: SizedBox(
                      width: 106,
                      height: 28,
                      child: Text(
                        "Summary",
                        style: const TextStyle(
                          color:	const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                          fontFamily: "ProximaNova",
                          fontStyle:	FontStyle.normal,
                          fontSize: 20.0
                        )
                      )
                    ),
                  ),
                  PositionedDirectional(
                    top: 2,
                    end: 16,
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 18.0,
                      icon: ImageIcon(AssetImage('assets/images/Settings.png')),
                      onPressed:()=>_showSettingSheet(),
                    )
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
                    bottom: 4,
                    start: 16,
                    end: 16,
                    child: Container(
                      height: 164,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(color: const Color(0x05000000), offset: Offset(0,0), blurRadius: 16)
                          ],
                          color: Colors.white
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          PositionedDirectional(
                            top:16,
                            start:16,
                            end:0,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 96,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: 16,
                                          width: 96,
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
                                          width: 96,
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
                                Container(
                                  width: 96,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: 16,
                                          width: 96,
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
                                        width: 96,
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
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 96,
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: 16,
                                          width: 96,
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
                                          width: 96,
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
                                  ),
                                )
                              ],
                              )
                          ),

                          PositionedDirectional(
                            top:66,
                            start:16,
                            end:0,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 96,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: 16,
                                          width: 96,
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
                                          width: 96,
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
                                Container(
                                  width: 96,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: 16,
                                          width: 96,
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
                                          width: 96,
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
                                Container(
                                  width: 96,
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: 15,
                                          width: 96,
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
                                          width: 96,
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
                                )
                              ],
                              ),
                            ),

                          PositionedDirectional(
                            top:116,
                            start:16,
                            end:0,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 16,
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
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: 16,
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
                                  ),
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
                    start: 18,
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
                  PositionedDirectional(
                    end: 16,
                    child: IconButton(
                      color: const Color(0xff042c5c),
                      iconSize: 18.0,
                      highlightColor: const Color(0xffffffff),
                      splashColor: const Color(0xffffffff),
                      icon: ImageIcon(AssetImage('assets/images/Sliders.png')),
                      onPressed:()=>_showSortingSheet(),
                    )
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
                  PositionedDirectional(
                      end: 16,
                      child: IconButton(
                        color: const Color(0xff042c5c),
                        iconSize: 18.0,
                        highlightColor: const Color(0xffffffff),
                        splashColor: const Color(0xffffffff),
                        icon: ImageIcon(AssetImage('assets/images/Sliders.png')),
                        onPressed:()=>_showSortingSheet(),
                      )
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff2e66e7),
        child: Icon(Icons.add,size: 20,color: Colors.white,),
        onPressed: (){print('hahaha');},
      ),
    );
  }
}

