import 'dart:core';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<String> letters = [];
  List<PhoneCountryCodeData> data;
  ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("城市地区选择"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          data == null || data.length == 0
              ? Text("")
              : Padding(
            padding: EdgeInsets.only(left: 20),
            child: ListView.builder(
                controller: _scrollController,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PhoneCodeIndexName(data[index].name.toUpperCase()),
                      ListView.builder(
                          itemBuilder:
                              (BuildContext context, int index2) {
                            return Container(
                              height: 46,
                              child: GestureDetector(
//                      behavior: HitTestBehavior.translucent,
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          "${data[index].listData[index2].name}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff434343))),
                                      SizedBox(width: 10),
                                      Text(
                                        "+${data[index].listData[index2].code}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xffD6D6D6)),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pop(
                                      data[index].listData[index2].code);
                                },
                              ),
                            );
                          },
                          itemCount: data[index].listData.length,
                          shrinkWrap: true,
                          physics:
                          NeverScrollableScrollPhysics()) //禁用滑动事件),
                    ],
                  );
                }),
          ),
          Align(
            alignment: new FractionalOffset(1.0, 0.5),
            child: SizedBox(
              width: 25,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: letters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Text(
                        letters[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                        var height = index * 45.0;
                        for (int i = 0; i < index; i++) {
                          height += data[i].listData.length * 46.0;
                        }
                        _scrollController.jumpTo(height);
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PhoneCodeIndexName extends StatelessWidget {
  String indexName;

  PhoneCodeIndexName(this.indexName);

  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Padding(
        child: Text(indexName,
            style: TextStyle(fontSize: 20, color: Color(0xff434343))),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}

class PhoneCountryCodeEntity {
  int code;
  List<PhoneCountryCodeData> data;
  String message;

  PhoneCountryCodeEntity({this.code, this.data, this.message});

  PhoneCountryCodeEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<PhoneCountryCodeData>();
      (json['data'] as List).forEach((v) {
        data.add(new PhoneCountryCodeData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class PhoneCountryCodeData {
  List<PhoneCountryCodeDataListdata> listData;
  String name;

  PhoneCountryCodeData({this.listData, this.name});

  PhoneCountryCodeData.fromJson(Map<String, dynamic> json) {
    if (json['listData'] != null) {
      listData = new List<PhoneCountryCodeDataListdata>();
      (json['listData'] as List).forEach((v) {
        listData.add(new PhoneCountryCodeDataListdata.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listData != null) {
      data['listData'] = this.listData.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    return data;
  }
}

class PhoneCountryCodeDataListdata {
  String code;
  String name;
  int id;
  String groupCode;

  PhoneCountryCodeDataListdata({this.code, this.name, this.id, this.groupCode});

  PhoneCountryCodeDataListdata.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    id = json['id'];
    groupCode = json['groupCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['id'] = this.id;
    data['groupCode'] = this.groupCode;
    return data;
  }
}