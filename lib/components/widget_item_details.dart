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
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox( height: 80,),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "American Express® Gold",
                        style: const TextStyle(
                            color:  const Color(0xff042c5c),
                            fontWeight: FontWeight.w700,
                            fontFamily: "ProximaNova",
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.center
                      ),
                      Text(
                        "1002 My Dining Card",
                        style: const TextStyle(
                            color:  const Color(0xff77869e),
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova",
                            fontStyle:  FontStyle.normal,
                            fontSize: 14.0
                        ),
                        textAlign: TextAlign.center
                      )
                    ],
                  )
                ),
                SizedBox(height: 20,),
                Image.asset('assets/images/amex-gold-card.png',height: 220,width: 360,),
                Container(
                  height: 1000,
                  child:Stack(
                    children:<Widget>[
                      PositionedDirectional(
                        top: 30,
                        start: 30,
                        end:30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 16,
                              child: Text(
                                "Card Issuer",
                                style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: Text(
                                "American Express",
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                              child:Text(
                                  "Payment Network",
                                  style: const TextStyle(
                                      color:  const Color(0xff77869e),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "ProximaNova",
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 11.0
                                  ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: Text(
                                "American Express",
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                              child: Text(
                                "Rewards",
                                style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 40,
                              child:
                                  Text(
                                    "Membership Rewards\@",
                                    style: const TextStyle(
                                        color:  const Color(0xff042c5c),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "ProximaNova",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 16.0
                                    ),
                                  ),
//                                  IconButton(
//                                    color: const Color(0xff77869e),
//                                    icon: Icon(Icons.error_outline),
//                                    onPressed:(){},
//                                  )
                            ),
                            Row(
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
                                                "Approval Date",
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
                                                "Feb 25 2018",
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
                                        child: Text(
                                          "\$250",
                                          style: const TextStyle(
                                              color:  const Color(0xff042c5c),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ProximaNova",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 16.0
                                          )
                                        ),
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
                                              "Annual Fee Date",
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
                                                "Mar 1 2020",
                                                style: const TextStyle(
                                                    color:  const Color(0xff042c5c),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ProximaNova",
                                                    fontStyle:  FontStyle.normal,
                                                    fontSize: 16.0
                                                )
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
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
                                            "Next Statement",
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
                                          child: Text(
                                                  "Aug 31 2019",
                                                  style: const TextStyle(
                                                      color:  const Color(0xff042c5c),
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "ProximaNova",
                                                      fontStyle:  FontStyle.normal,
                                                      fontSize: 16.0
                                                  )
                                              ),
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
                                              "Foreign Transaction Fees",
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
                                          child: Text(
                                            "\$0",
                                            style: const TextStyle(
                                                color:  const Color(0xff042c5c),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "ProximaNova",
                                                fontStyle:  FontStyle.normal,
                                                fontSize: 16.0
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
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
                                            "Purchase APR",
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
                                          child: Text(
                                                  "24.99%",
                                                  style: const TextStyle(
                                                      color:  const Color(0xff042c5c),
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "ProximaNova",
                                                      fontStyle:  FontStyle.normal,
                                                      fontSize: 16.0
                                                  )
                                              ),
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
                                          "Cash Advance APR",
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
                                        child: Text(
                                          "26.99%",
                                          style: const TextStyle(
                                              color:  const Color(0xff042c5c),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ProximaNova",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 16.0
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            SizedBox(
                              height: 16,
                              child:Text(
                                "Balance Transfer APR",
                                style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: Text(
                                "25.99%",
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                              child:Text(
                                "Card Status",
                                style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: Text(
                                "Active",
                                style: const TextStyle(
                                    color:  const Color(0xff042c5c),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                              child:Text(
                                "Benefits",
                                style: const TextStyle(
                                    color:  const Color(0xff77869e),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "ProximaNova",
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 11.0
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 360,
                              child: Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(text:"• 4X Membership Rewards® points when you dine at restaurants worldwide\n\n"),
                                  TextSpan(text:"• 4X Membership Rewards® points at US supermarkets, on up to \$25,000 per year in purchases\n\n"),
                                  TextSpan(text:"• 3X Membership Rewards® points on flights booked directly with airlines or on amextravel.com\n\n"),
                                  TextSpan(text:"• \$120 dining credit, \$10 in statement credits monthly at Grubhub, Seamless, The Cheesecake Factory, Ruth's Chris Steak House, Boxed, and participating Shake Shack locations\n\n"),
                                  TextSpan(text:"• \$100 per calendar year in statement credits when incidental fees\n\n"),
                                  TextSpan(text:"• No foreign transaction fees\n\n"),
                                  TextSpan(text:"• Amex Offers, ShopRunner, etc.\n\n"),
                                ]
                                ),
                                style: const TextStyle(
                                  color:  const Color(0xff042c5c),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "ProximaNova",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 14.0
                                )
                              )
                            ),
                            Container(
                              height: 48,
                              width: double.infinity,
                              child: SizedBox(
                                height: 48,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.0)
                                    ),
                                    color: const Color(0xff0047cc),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child:Text(
                                        "Edit",
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
                            ),
                            SizedBox(height: 10,),
                            Container(
                              height: 48,
                              width: double.infinity,
                              child: SizedBox(
                                height: 48,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0)
                                  ),
                                  color: const Color(0xfff24750),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child:Text(
                                      "Delete This Card",
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
                          ]
                        ),
                      ),
                    ]
                  )
                ),
              ]
            ),
            Align(
              alignment: Alignment.topCenter,
              child:ClipRect(
                child: Stack(
                  children: <Widget>[
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.white.withOpacity(0.1),
                        height: 80,
                      ),
                    ),
                    Container(
                      height: 80,
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          focusColor:  Colors.white,
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          color: Colors.white,
                          icon: ImageIcon(
                              AssetImage('assets/images/Return.png'),
                              color: const Color(0xff042c5c),
                              size: 18
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Edit",
                              style: const TextStyle(
                                  color:  const Color(0xff042c5c),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "ProximaNova",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 16.0
                              ),
                            ),
                            onPressed: (){},
                          )
                        ],
                      ),
                    )
                  ]
                )
              ),
            ),
          ]
        )
    );
  }
}
