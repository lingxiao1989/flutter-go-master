import 'package:flutter/material.dart';

class WidgetItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //backgroundColor: Colors.transparent,
        //elevation: 0,
        //leading: IconButton(
          //icon: ImageIcon(
            //AssetImage('assets/images/Return.png'),
            //color: const Color(0xff042c5c),
            //size: 18
          //),
          //onPressed: () {Navigator.pop(context);},
        //),
      //),
      body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: ImageIcon(
                  AssetImage('assets/images/Return.png'),
                  color: const Color(0xff042c5c),
                  size: 18
                ),
                onPressed: () {Navigator.pop(context);},
              ),
              floating: true,
              pinned: true,
              snap: true,
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text("Item $index"),
                ),
                childCount: 30,
              ),
            ),
          ]
      )


    );
  }
}
