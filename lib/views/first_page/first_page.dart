import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_go/components/list_view_item.dart';
import 'package:flutter_go/components/list_refresh.dart' as listComp;
import 'package:flutter_go/components/pagination.dart';
import 'package:flutter_go/views/first_page/first_page_item.dart';
import 'package:flutter_go/components/disclaimer_msg.dart';
import 'package:flutter_go/utils/net_utils.dart';

// ValueKey<String> key;

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => new FirstPageState();
}

class FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _unKnow;
  GlobalKey<DisclaimerMsgState> key;

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
    return new ListViewItem(itemPic: backPic,itemUrl: codeUrl,itemTitle: myCardName,data: myProgramName,);
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
    return new CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: new Container(
          height: 170,
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
                        "Categories",
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
                  height: 113,
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 49, left: 16),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      primary: true,
                      children: <Widget>[
                        _TextImgWidget(
                        //'找电影',
                        'assets/images/Cate1.png',
                        //                tabCallBack: () {
                        //                  print('点击找电影');
                        //                  Router.push(context, Router.searchPage, '找电影');
                        //                },
                        ),
                        new Container(
                          width: 20,
                        ),
                        _TextImgWidget(
                        //'豆瓣榜单',
                        'assets/images/Cate2.png',
                        //                tabCallBack: () {
                        //                  print('点击豆瓣榜单');
                        //                  Router.push(context, Router.searchPage, '豆瓣榜单');
                        //                },
                        ),
                        new Container(
                          width: 20,
                        ),
                        _TextImgWidget(
                        //'豆瓣猜',
                        'assets/images/Cate3.png',
                        //                tabCallBack: () {
                        //                  Router.push(context, Router.searchPage, '豆瓣猜');
                        //                },
                        ),
                        new Container(
                          width: 20,
                        ),
                        _TextImgWidget(
                        //'豆瓣片单',
                        'assets/images/Cate4.png',
                        //                tabCallBack: () {
                        //                  Router.push(context, Router.searchPage, '豆瓣片单');
                        //                },
                        )
                      ],
                    )
                  )
                ),
              ),
            ],
          ),
        ),
        ),
//          new Stack(
//            //alignment: const FractionalOffset(0.9, 0.1),//方法一
//            children: <Widget>[
//            Pagination(),
//            Positioned(//方法二
//              top: 10.0,
//              left: 0.0,
//              child: DisclaimerMsg(key:key,pWidget:this)
//            ),
//          ]),
//          SizedBox(height: 2, child:Container(color: Theme.of(context).primaryColor)),

        SliverToBoxAdapter(
          child:
            new Container(
              height: 30,
              child: Stack(
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 15,
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
        //new ListView(),
    SliverToBoxAdapter(
    child:


              new Container(
                  height: 30,
                  child: Stack(
                      children: <Widget>[
                        PositionedDirectional(
                          top: 0,
                          start: 15,
                          child:
                          SizedBox(
                              width: 199,
                              height: 28,
                              child:	 Text(
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
      SliverFixedExtentList(
        itemExtent: 15,
        delegate: SliverChildBuilderDelegate(
          (_,index)=>Container(
            child: listComp.ListRefresh(getIndexListData,makeCard)
          ),
          childCount: 15
        ),
      ) //new listComp.ListRefresh(getIndexListData,makeCard),
      ]
    );
  }
}


class _TextImgWidget extends StatelessWidget {
  //final String text;
  final String imgAsset;
  //final TapCallback tabCallBack;

  _TextImgWidget(
      //this.text,
      this.imgAsset, {
        Key key,
        //this.tabCallBack,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      onTap: () {
//        if (tabCallBack != null) {
//          tabCallBack();
//        }
//      },
      child: Column(
        children: <Widget>[
          new Container(
            width: 48,
            height: 48,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)
                ),
                color: const Color(0xfff5f6f8)
            ),
            child: Image.asset(
              imgAsset,
              width: 45,
              height: 45,

            ),
            /*Text(
              text,
              style: TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(
                    255,
                    128,
                    128,
                    128,
                  )),
            )*/
          )
        ],
      ),
    );
  }
}
