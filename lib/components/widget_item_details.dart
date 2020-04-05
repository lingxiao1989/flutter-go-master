import 'dart:ui';
import 'package:flutter/material.dart';

class itemDetailsPage extends StatefulWidget {
  @override
  _itemDetailsState createState() => _itemDetailsState();
}

class _itemDetailsState extends State<itemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("widget.title"),
        ),
        body: Stack( //重叠的Stack Widget，实现重贴
          children: <Widget>[
            ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    "测试$index",
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                  ),
                );
              },
            ),
            Align(
              child: ClipRect( //裁切长方形
                child: BackdropFilter( //背景滤镜器
                  filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0), //图片模糊过滤，横向竖向都设置5.0
                  child: Opacity( //透明控件
                    opacity: 0.5,
                    child: Container(// 容器组件
                      width: 500.0,
                      height: 700.0,
                      decoration: BoxDecoration(color:Colors.grey.shade200), //盒子装饰器，进行装饰，设置颜色为灰色
                      child: Center(
                        child: Text(
                          'JSPang',
                          style: Theme.of(context).textTheme.display3, //设置比较酷炫的字体
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )

//        Center(
//          child: Stack(
//            children: [
//              ListView.builder(
//                itemCount: 100,
//                itemBuilder: (context, index) {
//                  return Container(
//                    alignment: Alignment.center,
//                    child: Text(
//                      "测试$index",
//                      style: TextStyle(color: Colors.blue, fontSize: 30),
//                    ),
//                  );
//                },
//              ),
//              IgnorePointer(
//                ignoring: true,
//                child: BackdropFilter(
//                  filter: new ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                  child: new Container(
//                    color: Colors.white.withOpacity(0.1),
//                    height: 10,
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
//      appBar: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//        leading: IconButton(
//          icon: ImageIcon(
//            AssetImage('assets/images/Return.png'),
//            color: const Color(0xff042c5c),
//            size: 18
//          ),
//          onPressed: () {Navigator.pop(context);},
//        ),
//      ),
//      body: Center(child:Stack(
//        children: <Widget>[
//          ListView.builder(
//            itemCount: 100,
//            itemBuilder: (context, index) {
//              return Container(
//                alignment: Alignment.center,
//                child: Text(
//                  "测试$index",
//                  style: TextStyle(color: Colors.blue, fontSize: 30),
//                ),
//              );
//            },
//          ),
//          IgnorePointer(
//            ignoring: true,
//            child: BackdropFilter(
//              filter: new ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//              child: new Container(
//                color: Colors.white.withOpacity(0.1),
//                height: 500,
//              ),
//            ),
//          ),

//          AppBar(
//            //title: new Text("App bar"),
//            backgroundColor: Colors.transparent,
//            elevation: 0.0,
//            leading: IconButton(
//                icon: ImageIcon(
//                    AssetImage('assets/images/Return.png'),
//                    color: const Color(0xff042c5c),
//                    size: 18
//                ),
//                onPressed: () {Navigator.pop(context);}
//            ),
//          ),



    );
  }
}
