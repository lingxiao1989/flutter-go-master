import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_go/widgets/elements/Form/Button/FlatButton/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_go/components/list_view_card_item.dart';
import 'package:flutter_go/components/list_refresh.dart' as listComp;
import 'package:flutter_go/components/pagination.dart';
import 'package:flutter_go/views/values_page/first_page_item.dart';
import 'package:flutter_go/components/disclaimer_msg.dart';
import 'package:flutter_go/utils/net_utils.dart';
import 'package:flutter_go/model/category.dart';
import 'package:flutter_go/event/event_bus.dart';

// ValueKey<String> key;

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _unKnow;
  GlobalKey<DisclaimerMsgState> key;
  List<CategoryModel> Categories =[];
  List<dynamic> _categoryList = [
    {'id': 0, 'categoryName':'Non-bonused Spending', 'iconImage':'assets/images/Cate2.png'},
    {'id': 1, 'categoryName':'Restaurant', 'iconImage':'assets/images/restaurant.png'},
    {'id': 2, 'categoryName':'Groceries', 'iconImage':'assets/images/Cate4.png'},
    {'id': 3, 'categoryName':'Gas Station', 'iconImage':'assets/images/Cate3.png'},
    {'id': 4, 'categoryName':'Air Travel', 'iconImage':'assets/images/Cate1.png'},
    {'id': 5, 'categoryName':'a test', 'iconImage': null},
  ];

  var _cashbackValuesDisplay=1;
  bool _noForeignTransactionFee=false;
  bool _noAnnualFee=false;
  bool _showBusinessCreditCards=false;
  var _currentChoice=0;
  @override
  bool get wantKeepAlive => true;

  setCurrentCategory(int index){
    setState(()=>_currentChoice=index);
  }

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
    _categoryList.forEach((item) {
      Categories.add(CategoryModel.fromJson(item));
    });
  }
  _showSettingSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft:Radius.circular(10.0),
                topRight: Radius.circular(10.0)
            )
        ),
        //isScrollControlled: true,
        context: context,
        builder: (context) => FractionallySizedBox(
          heightFactor: 0.68,
          child:
          Column(
            children:<Widget>[
              Container(
                height: 60,
                child:Stack(
                  children:<Widget>[
                    PositionedDirectional(
                      top: 30,
                      start: 16,
                      end:16,
                      child: Container(
                          height: 20,
                          child: Text(
                              "Cashback Values",
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
                          'Show Point Values',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          )
                      ),
                      value: 1,
                      groupValue: _cashbackValuesDisplay,
                      activeColor: const Color(0xff0047cc),
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (value) {
                        (context as Element).markNeedsBuild();
                        _cashbackValuesDisplay=value;
                      },
                    ),
                    RadioListTile(
                      title: const Text(
                          'Show Cash Value Only',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          )
                      ),
                      value: 2,
                      groupValue: _cashbackValuesDisplay,
                      activeColor: const Color(0xff0047cc),
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (value) {
                        (context as Element).markNeedsBuild();
                        _cashbackValuesDisplay=value;
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
                  "Recommendation",
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
                    CheckboxListTile(
                      title: const Text(
                          'No Foreign Transaction Fee',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          )
                      ),
                      activeColor: const Color(0xff0047cc),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: _noForeignTransactionFee,
                      onChanged: (value) {
                        (context as Element).markNeedsBuild();
                        _noForeignTransactionFee=!_noForeignTransactionFee;
                      },
                    ),
                    CheckboxListTile(
                      title: const Text(
                          'No Annual Fee',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          )
                      ),
                      activeColor: const Color(0xff0047cc),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: _noAnnualFee,
                      onChanged: (value) {
                        (context as Element).markNeedsBuild();
                        _noAnnualFee=!_noAnnualFee;
                      },
                    ),
                    CheckboxListTile(
                      //secondary: const Icon(Icons.shutter_speed),
                      title: const Text(
                          'Show Business Credit Cards',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          )
                      ),
                      activeColor: const Color(0xff0047cc),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: _showBusinessCreditCards,
                      onChanged: (value) {
                        (context as Element).markNeedsBuild();
                        _showBusinessCreditCards=!_showBusinessCreditCards;
                      },
                    ),
                  ],
                ),
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
                    onPressed: (){
                      Navigator.pop(context);
                    },
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
  _showCategorySheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
      // 生成一个列表选择器
          children: List.generate(
          Categories.length+1,
          (index) {
            if(index==0){
              return new Container(
                height:75,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                          'Select a category',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          )
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        color: const Color(0xff042c5c),
                        onPressed: (){
                          //eventBus.fire(ApplicationEvent(false));
                          Navigator.pop(context);
                        },
                      )
                    )
                  ],
                )
              );
            }
            index-=1;
            return new InkWell(
              child: Container(
                alignment: Alignment.centerLeft,
                height: 60.0,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 20.0),
                    Text(
                      '${Categories[index].categoryName}',
                      style: const TextStyle(
                        color:  const Color(0xff042c5c),
                        fontWeight: FontWeight.w400,
                        fontFamily: "ProximaNova",
                        fontStyle:  FontStyle.normal,
                        fontSize: 16.0
                      )
                    )
                  ],
                )
              ),
              onTap: () {
                setCurrentCategory(index);
                print('tapped item ${Categories[index].categoryName}');
                //eventBus.fire(ApplicationEvent(false));
                Navigator.pop(context);
              }
            );
          }
        )
      )
      )
    );
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
        FirstPageItem cellData = new FirstPageItem.fromJson(responseList[i]);
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
    return new ListViewCardItem(itemPic: backPic,itemUrl: codeUrl,itemTitle: myCardName,data: myProgramName,);
  }

  headerView(){
    return
      Column(
        children: <Widget>[
          Stack(
            //alignment: const FractionalOffset(0.9, 0.1),//方法一
              children: <Widget>[
                Pagination(),
                Positioned(//方法二
                    top: 50.0,
                    left: 0.0,
                    child: DisclaimerMsg(key:key,pWidget:this)
                ),
              ]),
          SizedBox(height: 1, child:Container(color: Theme.of(context).primaryColor)),
          SizedBox(height: 10),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // super.initState();
    return new CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: new Container(
            height: 180,
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
                      "Categories",
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
                  bottom: 0,
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
                    height: 128,
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
                      children: <Widget>[
                        PositionedDirectional(
                          top: 16,
                          start: 16,
                          child: SizedBox(
                            width: 20 ,
                            height: 18,
                            child: Text(
                              "for",
                              style: const TextStyle(
                                color:  const Color(0xff77869e),
                                fontWeight: FontWeight.w400,
                                fontFamily: "ProximaNova",
                                fontStyle:  FontStyle.normal,
                                fontSize: 14.0
                              )
                            )
                          )
                        ),
                        PositionedDirectional(
                          top: 0,
                          start: 36,
                          child:(Builder (builder:
                              (context) => FlatButton(
                                onPressed: () {
                                  //eventBus.fire(ApplicationEvent(true));
                                  _showCategorySheet();
                                },
                                padding: EdgeInsets.all(0.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      Categories[_currentChoice].categoryName,
                                      style: const TextStyle(
                                        color:  const Color(0xff042c5c),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "ProximaNova",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 14.0
                                      )
                                    ),
                                    const SizedBox(width: 2.0),
                                    const Icon(
                                      Icons.expand_more,
                                      color: const Color(0xff77869e),
                                      size: 15.0
                                    ),
                                  ],
                                ),
                              )
                            )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 36, left: 16),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            primary: true,
                            children: List.generate(
                              Categories.length,
                              (index) {
                                if (Categories[index].iconImage == null) {
                                  return Container();
                                }
                                if (index<Categories.length-1){
                                  return new Container(
                                      width: 75,
                                      height: 60,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              width: 60,
                                              height: 60,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  color: const Color(0xfff5f6f8)
                                              ),
                                              child: FlatButton(
                                                onPressed: () => setCurrentCategory(index),
                                                child: Image.asset(
                                                    Categories[index].iconImage,
                                                    width: 60,
                                                    height: 60,
                                                ),
                                              )
                                          )
                                        ],
                                      )
                                  );
                                }
                                return new Container(
                                  width: 60,
                                  height: 60,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          color: const Color(0xfff5f6f8)
                                        ),
                                        child: FlatButton(
                                          onPressed: () => setCurrentCategory(index),
                                          child: Image.asset(
                                            Categories[index].iconImage,
                                            width: 60,
                                            height: 60,
                                          ),
                                        )
                                      )
                                    ],
                                  )
                                );
                              }
                            )
                          )
                        )
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
                      "Available Cards",
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
                  start: 18,
                  child:
                  SizedBox(
                    width: 199,
                    height: 28,
                    child: Text(
                      "Recommended Cards",
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

