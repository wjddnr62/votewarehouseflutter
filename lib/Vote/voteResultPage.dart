import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';
import '../Public/color.dart';

class VoteResultPage extends StatefulWidget {
  @override
  _VoteResultPage createState() => _VoteResultPage();
}

class _VoteResultPage extends State<VoteResultPage> {
  Provider provider = Provider();
  int collectionNum = 1;
  int count = 10;
  String format = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String politics;
  AppBar appBar;
  bool loading = false;

  tabs(num) {
    return Expanded(
      child: num == count
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: 6,
              color: collectionNum >= num
                  ? black
                  : Color.fromRGBO(232, 194, 157, 0.3),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: 6,
              color: collectionNum >= num
                  ? black
                  : Color.fromRGBO(232, 194, 157, 0.3),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (collectionNum == 1) {
          Navigator.of(context).pop();
        } else {
          setState(() {
            collectionNum--;
          });
        }
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (collectionNum == 1) {
                Navigator.of(context).pop();
              } else {
                setState(() {
                  collectionNum--;
                });
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            InkWell(
              onTap: () {
                if (collectionNum < 11) {
                  setState(() {
                    collectionNum++;
                  });
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    collectionNum < 11 ? "다음" : "종료",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: mainColor),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: collectionNum < 11
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('voteList')
                            .document(format)
                            .collection("q$collectionNum")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Vote #$collectionNum",
                                      style: TextStyle(
                                          color: Color(0xFFCCCCDD),
                                          fontSize: 14),
                                    ),
                                    whiteSpaceW(12),
                                    Text(snapshot
                                        .data.documents[0].data['category'])
                                  ],
                                ),
                                whiteSpaceH(10),
                                Row(
                                  children: <Widget>[
                                    tabs(1),
                                    whiteSpaceW(4),
                                    tabs(2),
                                    whiteSpaceW(4),
                                    tabs(3),
                                    whiteSpaceW(4),
                                    tabs(4),
                                    whiteSpaceW(4),
                                    tabs(5),
                                    whiteSpaceW(4),
                                    tabs(6),
                                    whiteSpaceW(4),
                                    tabs(7),
                                    whiteSpaceW(4),
                                    tabs(8),
                                    whiteSpaceW(4),
                                    tabs(9),
                                    whiteSpaceW(4),
                                    tabs(10)
                                  ],
                                ),
                                whiteSpaceH(40),
                                Text(
                                  snapshot.data.documents[0].documentID,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                                whiteSpaceH(20),
                                snapshot.data.documents[0].data['tag'] != null
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 15,
                                        child: ListView.builder(
                                          itemBuilder: (context, idx) {
                                            return GestureDetector(
                                              onTap: () {
                                                print(snapshot.data.documents[0]
                                                    .data['url'][idx]);
                                                launch(snapshot
                                                    .data
                                                    .documents[0]
                                                    .data['url'][idx]);
                                              },
                                              child: Container(
                                                height: 20,
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "#${snapshot.data.documents[0].data['tag'][idx]}",
                                                      style: TextStyle(
                                                          color: mainColor,
                                                          fontSize: 14),
                                                    ),
                                                    whiteSpaceW(10)
                                                  ],
                                                ),
                                                color: white,
                                              ),
                                            );
                                          },
                                          itemCount: snapshot.data.documents[0]
                                              .data['tag'].length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      )
                                    : Container(),
                                whiteSpaceH(40),
                                StreamBuilder<List<double>>(
                                    stream: provider
                                        .voteCount(
                                            "q$collectionNum",
                                            snapshot
                                                .data.documents[0].documentID)
                                        .asStream(),
                                    builder: (context, double) {
                                      if (double.hasData &&
                                          double.data.length ==
                                              snapshot.data.documents[0]
                                                  .data['answer'].length) {
                                        return ListView.builder(
                                            itemBuilder: (context, idx) {
                                              return StreamBuilder<int>(
                                                stream: provider
                                                    .checkAnswer(
                                                        'q$collectionNum',
                                                        snapshot
                                                            .data
                                                            .documents[0]
                                                            .documentID)
                                                    .asStream(),
                                                builder: (context, int) {
                                                  if (int.hasData) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          snapshot
                                                                  .data
                                                                  .documents[0]
                                                                  .data[
                                                              'answer'][idx],
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        whiteSpaceH(8),
                                                        LinearPercentIndicator(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              50,
                                                          animation: true,
                                                          lineHeight: 28.0,
                                                          animationDuration:
                                                              1000,
                                                          percent:
                                                              double.data[idx] /
                                                                  100,
                                                          center: Text(
                                                            "${double.data[idx]}%",
                                                            style: TextStyle(
                                                                color: white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 15),
                                                          ),
                                                          linearStrokeCap:
                                                              LinearStrokeCap
                                                                  .roundAll,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          progressColor: int
                                                                          .data -
                                                                      1 ==
                                                                  idx
                                                              ? mainColor
                                                              : Color(
                                                                  0xFFCFCFCF),
                                                        ),
                                                        whiteSpaceH(20)
                                                      ],
                                                    );
                                                  }
                                                  return Container();
                                                },
                                              );
                                            },
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: snapshot
                                                .data
                                                .documents[0]
                                                .data['answer']
                                                .length);
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  mainColor),
                                        ),
                                      );
                                    }),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          whiteSpaceH(40),
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              "본인이 선호하는 정당은\n어디인가요?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: black,
                                  fontSize: 20),
                            ),
                          ),
                          whiteSpaceH(40),
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("politics")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return StreamBuilder<List<double>>(
                                  stream: provider.politicsCount().asStream(),
                                  builder: (context, double) {
                                    if (double.hasData) {
                                      return StreamBuilder<QuerySnapshot>(
                                          stream: Firestore.instance
                                              .collection("voteResult")
                                              .document(DateFormat("yyyy-MM-dd")
                                                  .format(DateTime.now()))
                                              .collection("politics")
                                              .where("email",
                                                  isEqualTo: dataSave.email)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  select) {
                                            if (select.hasData) {
                                              return GridView.count(
                                                  crossAxisCount: 3,
                                                  shrinkWrap: true,
                                                  children: List.generate(
                                                      snapshot
                                                          .data
                                                          .documents[0]
                                                          .data['politics']
                                                          .length, (index) {
                                                    return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 72,
                                                      padding:
                                                          EdgeInsets.all(1),
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        color: snapshot
                                                                        .data
                                                                        .documents[
                                                                            0]
                                                                        .data['politics']
                                                                    [index] ==
                                                                select
                                                                        .data
                                                                        .documents[
                                                                            0]
                                                                        .data[
                                                                    'selectPolitics']
                                                            ? mainColor
                                                            : Color(0xFFF7F7F8),
                                                        onPressed: () {},
                                                        child: Container(
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  snapshot
                                                                          .data
                                                                          .documents[
                                                                              0]
                                                                          .data[
                                                                      'politics'][index],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color:
                                                                          black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                whiteSpaceH(8),
                                                                Text(
                                                                  "${double.data[index]}%",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: snapshot.data.documents[0].data['politics'][index] ==
                                                                              select.data.documents[0].data[
                                                                                  'selectPolitics']
                                                                          ? black
                                                                          : Color(
                                                                              0xFFBBBBBB),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }));
                                            }
                                            return Container();
                                          });
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                mainColor),
                                      ),
                                    );
                                  },
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
