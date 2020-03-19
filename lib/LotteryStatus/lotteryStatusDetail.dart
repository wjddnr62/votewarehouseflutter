import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:votewarehouse/Model/product.dart';
import 'package:votewarehouse/Model/productUser.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

import '../Public/color.dart';

// ignore: must_be_immutable
class LotteryStatusDetail extends StatefulWidget {
  String startDate;
  String endDate;
  String documentId;

  LotteryStatusDetail({Key key, this.startDate, this.endDate, this.documentId})
      : super(key: key);

  @override
  _LotteryStatusDetail createState() => _LotteryStatusDetail();
}

class _LotteryStatusDetail extends State<LotteryStatusDetail> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateTime startDate, endDate;
  List<String> dates = List();
  List<String> checkDates = List();
  List<bool> voteStatus = List();
  bool loading = false;
  bool firstProduct = false;
  int productCount = 0;
  List<Product> productImages = List();
  List<ProductUser> productUser = List();
  List<ProductData> productData = List();

  dateSideGet() {
    startDate = dateFormat.parse(widget.startDate);
    endDate = dateFormat.parse(widget.endDate);

    int difference = endDate
        .difference(startDate)
        .inDays;
    for (int i = 0; i <= difference; i++) {
      String year = startDate
          .add(Duration(days: i))
          .year
          .toString();
      String month;
      String day;

      if (startDate
          .add(Duration(days: i))
          .month
          .toString()
          .length == 1) {
        month = "0" + startDate
            .add(Duration(days: i))
            .month
            .toString();
      } else {
        month = startDate
            .add(Duration(days: i))
            .month
            .toString();
      }

      if (startDate
          .add(Duration(days: i))
          .day
          .toString()
          .length == 1) {
        dates.add("0" + startDate
            .add(Duration(days: i))
            .day
            .toString());
        day = "0" + startDate
            .add(Duration(days: i))
            .day
            .toString();
      } else {
        dates.add(startDate
            .add(Duration(days: i))
            .day
            .toString());
        day = startDate
            .add(Duration(days: i))
            .day
            .toString();
      }
      setState(() {});
      checkDates.add(year + "-" + month + "-" + day);
    }

    voteCheck();
    productCheck();
  }

  voteCheck() async {
    for (int i = 0; i < checkDates.length; i++) {
      QuerySnapshot voteCheckQuery = await Firestore.instance
          .collection("voteResult")
          .document(checkDates[i])
          .collection("politics")
          .where("email", isEqualTo: dataSave.email)
          .getDocuments();

      if (voteCheckQuery.documents.length != 0) {
        voteStatus.add(true);
      } else {
        voteStatus.add(false);
      }

      if (dates.length - 1 == i) {
        if (voteStatus[i]) {
          setState(() {
            firstProduct = true;
          });
        }
      }
    }
  }

  productCheck() async {
    List<int> numbers = [1, 2, 3, 4];
    for (int i = 0; i < numbers.length; i++) {
      QuerySnapshot countQuery = await Firestore.instance
          .collection("drawResult")
          .document(widget.documentId)
          .collection("product${numbers[i]}")
          .getDocuments();

      if (countQuery.documents.length != 0) {
        productCount++;
      }
    }

    productGet();
  }

  productGet() async {
    QuerySnapshot imageQuery = await Firestore.instance
        .collection("drawResult")
        .where("startDate", isEqualTo: widget.startDate)
        .where("endDate", isEqualTo: widget.endDate)
        .getDocuments();

    if (imageQuery.documents.length != 0) {
      for (int i = 0; i < productCount; i++) {
        productImages.add(Product(
            name: 'product${i + 1}',
            url: imageQuery.documents[0].data['product${i + 1}']));
      }
      drawResultUser();
    }
  }

  drawResultUser() async {
    for (int i = 0; i < productCount; i++) {
      for (int k = 0; k < checkDates.length; k++) {
        productUser.length;
        QuerySnapshot userGetQuery = await Firestore.instance
            .collection("drawResult")
            .document(widget.documentId)
            .collection("product${i + 1}")
            .where("voteDate", isEqualTo: checkDates[k])
            .getDocuments();

        if (userGetQuery.documents.length != 0) {
          for (int j = 0; j < userGetQuery.documents.length; j++) {
            productUser.add(ProductUser(
                voteDate: userGetQuery.documents[j].data['voteDate'],
                email: userGetQuery.documents[j].data['email']));
          }

          productData.add(ProductData(
              name: "product${i + 1}",
              voteDate: checkDates[k],
              productUser: productUser
          ));
        }
      }
    }

    setState(() {
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();

    dateSideGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          '추첨현황',
          style: TextStyle(
              color: black, fontWeight: FontWeight.w600, fontSize: 15),
        ),
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          loading
              ? SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 40, left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.startDate + " ~ " + widget.endDate,
                    style:
                    TextStyle(fontSize: 12, color: Color(0xFFBBBBBB)),
                  ),
                  whiteSpaceH(6),
                  Text(
                    "투표참여 내역",
                    style: TextStyle(
                        color: black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  whiteSpaceH(40),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 30,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, idx) {
                        double width =
                            (MediaQuery
                                .of(context)
                                .size
                                .width - 32) / 7;
                        if (voteStatus.length == dates.length) {
                          return Container(
                            width: width,
                            height: 30,
                            child: Center(
                              child: Text(
                                dates[idx],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: voteStatus[idx]
                                        ? black
                                        : Color(0xFFBBBBBB)),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                      shrinkWrap: true,
                      itemCount: dates.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  whiteSpaceH(5),
                  firstProduct
                      ? Text(
                    "※ 1st 상품에 응모 되셨습니다.",
                    style: TextStyle(
                        color: Color(0xFF00AAFF), fontSize: 12),
                  )
                      : Container(),
                  whiteSpaceH(25),
                  Text(
                    "당첨자",
                    style: TextStyle(
                        fontSize: 15,
                        color: black,
                        fontWeight: FontWeight.w600),
                  ),
                  whiteSpaceH(25),
                  ListView.builder(
                    itemBuilder: (context, idx) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                  width: 160,
                                  height: 142,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius:
                                    BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Color(0xFFEEEEFF)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(4),
                                    child: Image.network(
                                      productImages[idx].url,
                                      fit: BoxFit.fill,
                                      width: 160,
                                      height: 142,
                                    ),
                                  )),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Stack(
                                  children: <Widget>[
                                    Image.asset(
                                      idx == 0
                                          ? "assets/icon/price_tag_color.png"
                                          : "assets/icon/price_tag_grey.png",
                                      width: 24,
                                      height: 30,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        child: Center(
                                          child: Text(
                                            "${idx + 1}",
                                            style: TextStyle(
                                                color: white,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          whiteSpaceH(5),
                          ListView.builder(
                            itemBuilder: (context, index) {
                              if (productData[index].name ==
                                  productImages[idx].name) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(productData[index].voteDate,
                                      style: TextStyle(
                                          color: Color(0xFFBBBBBB), fontSize: 12
                                      ),),
                                    whiteSpaceH(5),
                                    ListView.builder(
                                      itemBuilder: (context, i) {
                                        if (productData[index].voteDate ==
                                            productData[index].productUser[i]
                                                .voteDate) {
                                          List<String> emailSplit = productData[index]
                                              .productUser[i].email.split("@");
                                          String email = emailSplit[0].substring(0, emailSplit[0].length - 2) + "**@" + emailSplit[1];
                                          return Text(
                                              "$email", style: TextStyle(
                                            fontSize: 13, color: black
                                          ),);
                                        }
                                        return Container();
                                      },
                                      shrinkWrap: true,
                                      itemCount: productData[index].productUser
                                          .length,),
                                    whiteSpaceH(15)
                                  ],
                                );
                              }
                              return Container();
                            },
                            itemCount: productData.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),),
                        ],
                      );
                    },
                    shrinkWrap: true,
                    itemCount: productImages.length,
                    physics: NeverScrollableScrollPhysics(),
                  )
                ],
              ),
            ),
          )
              : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(mainColor),
            ),
          )
        ],
      ),
    );
  }
}
