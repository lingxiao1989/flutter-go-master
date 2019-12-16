import 'dart:typed_data';

/// @Author: 一凨
/// @Date: 2019-01-14 17:53:54 
/// @Last Modified by: 一凨
/// @Last Modified time: 2019-01-14 17:57:51

import 'package:flutter/material.dart';
import '../routers/application.dart';
import '../routers/routers.dart';
import 'dart:core';


class ListViewItem extends StatelessWidget {
  final String itemPic;
  final String itemUrl;
  final String itemTitle;
  final String data;

  const ListViewItem({Key key, this.itemPic, this.itemUrl, this.itemTitle, this.data})
      : super(key: key);

  _showModalBottomSheet(BuildContext context, itemTitle) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft:Radius.circular(10.0),
              topRight: Radius.circular(10.0)
          )
      ),
      context: context,
      builder: (context) =>  Column(
        children:<Widget>[
          Container(
            height: 80,
            child:Stack(
              children:<Widget>[
                PositionedDirectional(
                  top: 30,
                  start: 15,
                  end:15,
                  child: Container(
                    height: 25,
                    child: Text(
                      "American Express® Gold",
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
                  top: 60,
                  start: 15,
                  end:15,
                  child: Container(
                    height: 19,
                    child:  SizedBox(
                      width: 268,
                      height: 14,
                      child:   Text(
                          "1 Membership Reward Points ≈ 1.6¢ (August 2019)",
                          style: const TextStyle(
                              color:  const Color(0xff77869e),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 12.0
                          ),
                          textAlign: TextAlign.center
                      )
                    )
                  )
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
          SizedBox(height: 30),
          Image.asset(itemPic),
          Container(
            height: 100,
            child:Stack(
              children:<Widget>[
                PositionedDirectional(
                  top: 30,
                  start: 30,
                  child: Container(
                    child:Row(
                      children: <Widget>[
                        Text(
                          '4x',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w700,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Groceries',
                          style: const TextStyle(
                              color:  const Color(0xff042c5c),
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          ),
                          textAlign: TextAlign.left
                        ),
                        Text(
                            '6.4%',
                            style: const TextStyle(
                                color:  const Color(0xff1bc773),
                                fontWeight: FontWeight.w700,
                                fontFamily: "ProximaNova",
                                fontStyle:  FontStyle.normal,
                                fontSize: 16.0
                            ),
                            textAlign: TextAlign.right
                        ),
                      ],
                    )
                  )
                ),
                PositionedDirectional(
                  top: 30,
                  end: 30,
                  child: Container(
                    child:Row(
                      children: <Widget>[
                        Text(
                          '6.4%',
                          style: const TextStyle(
                              color:  const Color(0xff1bc773),
                              fontWeight: FontWeight.w700,
                              fontFamily: "ProximaNova",
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          ),
                          textAlign: TextAlign.right
                        ),
                      ],
                    )
                  )
                )
              ]
            )
          ),
          Container(
            height: 60,
            child:Stack(
              children:<Widget>[
                PositionedDirectional(
                  start: 30,
                  end:30,
                  child: RaisedButton(
                    color: const Color(0xff0047cc),
                    onPressed: (){},
                    child:Text(
                      "Card Details",
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
                ),
              ]
            )
          )
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: const Color(0x05000000), offset: Offset(0,0), blurRadius: 16)
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.white,
        elevation: 0.0,
        margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: ListTile(
          onTap: () {
            _showModalBottomSheet(context,itemTitle);
            // _launchURL(itemUrl, context);
            //Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(itemTitle)}&url=${Uri.encodeComponent(itemUrl)}');
          },
          leading:Image.asset(
            //this.data.bank_pic
            itemPic,
            width: 50,
            height: 50,
            //color: Colors.black45,
          ),
          title: Padding(
            child: Text(
              itemTitle,
              style: TextStyle(
                  color:  const Color(0xff042c5c),
                  fontWeight: FontWeight.w700,
                  fontFamily: "ProximaNova",
                  fontStyle:  FontStyle.normal,
                  fontSize: 14.0
              ),
            ),
            padding: EdgeInsets.only(top: 10.0),
          ),
          subtitle: Row(
            children: <Widget>[
              Padding(
                child: Text(data,
                    style: TextStyle(
                        color:  const Color(0xff77869e),
                        fontWeight: FontWeight.w400,
                        fontFamily: "ProximaNova",
                        fontStyle:  FontStyle.normal,
                        fontSize: 12.0
                    )
                ),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              )
            ],
          ),
          trailing: SizedBox(
              width: 45,
              height: 22,
              child:   Text(
                  "1.6%",
                  style: const TextStyle(
                      color:  const Color(0xff1bc773),
                      fontWeight: FontWeight.w700,
                      fontFamily: "ProximaNova",
                      fontStyle:  FontStyle.normal,
                      fontSize: 18.0
                  ),
                  textAlign: TextAlign.right
              )
          )
            //Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),
        ),
      )
    );
  }
}
