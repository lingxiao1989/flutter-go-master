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


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        onTap: () {
          // _launchURL(itemUrl, context);
          Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(itemTitle)}&url=${Uri.encodeComponent(itemUrl)}');
        },
        leading:Image.asset(
          //this.data.bank_pic
          itemPic,
          width: 50,
          height: 50,
          color: Colors.black45,
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
            width: 39,
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
    );
  }
}
