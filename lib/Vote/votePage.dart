import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/showToast.dart';
import '../Home/tabSelect.dart';
import '../Public/color.dart';
import '../Util/whiteSpace.dart';
import 'package:votewarehouse/Model/voteResult.dart';

class VotePage extends StatefulWidget {
  @override
  _VotePage createState() => _VotePage();
}

class _VotePage extends State<VotePage> {
  Provider provider = Provider();

  @override
  void initState() {
    super.initState();
  }

  int collectionNum = 1;
  int count = 10;
  String format = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<VoteResult> voteResult = List();
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

  List<int> selectIndex = List();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (collectionNum == 1) {
          backDialog();
        } else {
          setState(() {
            collectionNum--;
            voteResult.removeLast();
          });
        }
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: appBar = AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              if (collectionNum == 1) {
                backDialog();
              } else {
                setState(() {
                  collectionNum--;
                });
              }
            },
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10, top: 10),
              child: Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (collectionNum < 10) {
                        if (voteResult.length >= collectionNum) {
                          collectionNum++;
                        } else {
                          showToast("답안을 선택해주세요.");
                        }

                      } else {
                        voteDialog();
                      }
                    });
                  },
                  child: Container(
                    height: 30,
                    child: Text(
                      "다음",
                      style: TextStyle(color: mainColor, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('voteList')
                    .document(format)
                    .collection("q$collectionNum")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Vote #$collectionNum",
                              style: TextStyle(
                                  color: Color(0xFFCCCCDD), fontSize: 14),
                            ),
                            whiteSpaceW(12),
                            Text(snapshot.data.documents[0].data['category'])
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
                                width: MediaQuery.of(context).size.width,
                                height: 15,
                                child: ListView.builder(
                                  itemBuilder: (context, idx) {
                                    if (snapshot.data.documents[0].data['tag']
                                                [idx] !=
                                            "" &&
                                        snapshot.data.documents[0].data['tag']
                                                [idx] !=
                                            null) {
                                      return GestureDetector(
                                        onTap: () {
                                          print(snapshot.data.documents[0]
                                              .data['url'][idx]);
                                          launch(snapshot.data.documents[0]
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
                                    }
                                    return Container();
                                  },
                                  itemCount: snapshot
                                      .data.documents[0].data['tag'].length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                              )
                            : Container(),
                        whiteSpaceH(40),
                        ListView.builder(
                            itemBuilder: (context, idx) {
                              if (snapshot.data.documents[0].data['answer']
                                          [idx] !=
                                      "" &&
                                  snapshot.data.documents[0].data['answer']
                                          [idx] !=
                                      null) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 56,
                                      child: RaisedButton(
                                        onPressed: () {
                                          if (voteResult.length >=
                                                  collectionNum &&
                                              voteResult.length != 0) {
                                            voteResult[collectionNum - 1] =
                                                VoteResult(
                                                    email: dataSave.email,
                                                    idx: idx,
                                                    answer: snapshot
                                                        .data
                                                        .documents[0]
                                                        .data['answer'][idx],
                                                    date: format,
                                                    question: "q$collectionNum",
                                                    title: snapshot
                                                        .data
                                                        .documents[0]
                                                        .documentID);
                                            setState(() {
                                              print("idx : $idx");
                                              selectIndex[collectionNum - 1] =
                                                  idx;
                                            });
                                          } else {
                                            voteResult.add(VoteResult(
                                                email: dataSave.email,
                                                idx: idx,
                                                answer: snapshot
                                                    .data
                                                    .documents[0]
                                                    .data['answer'][idx],
                                                date: format,
                                                question: "q$collectionNum",
                                                title: snapshot.data
                                                    .documents[0].documentID));
                                            setState(() {
                                              print("idx : $idx");
                                              selectIndex.add(idx);
                                            });
                                          }
                                        },
                                        color:
                                            selectIndex.length >= collectionNum
                                                ? idx ==
                                                        selectIndex[
                                                            collectionNum - 1]
                                                    ? mainColor
                                                    : Color(0xFFF7F7F8)
                                                : Color(0xFFF7F7F8),
                                        highlightColor: mainColor,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              snapshot.data.documents[0]
                                                  .data['answer'][idx],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: black,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    whiteSpaceH(8)
                                  ],
                                );
                              }
                              return Container();
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot
                                .data.documents[0].data['answer'].length)
                      ],
                    );
                  }
                  return Container();
                },
              ),
            )

//              Container(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          whiteSpaceH(40),
//                          Padding(
//                            padding: EdgeInsets.only(left: 16, right: 16),
//                            child: Text(
//                              "본인이 선호하는 정당은\n어디인가요?",
//                              style: TextStyle(
//                                  fontWeight: FontWeight.w600,
//                                  color: black,
//                                  fontSize: 20),
//                            ),
//                          ),
//                          whiteSpaceH(40),
//                          StreamBuilder<QuerySnapshot>(
//                            stream: Firestore.instance
//                                .collection("politics")
//                                .snapshots(),
//                            builder: (context,
//                                AsyncSnapshot<QuerySnapshot> snapshot) {
//                              if (snapshot.hasData) {
//                                return GridView.count(
//                                    crossAxisCount: 3,
//                                    shrinkWrap: true,
//                                    children: List.generate(
//                                        snapshot.data.documents[0]
//                                            .data['politics'].length, (index) {
//                                      return Container(
//                                        width:
//                                            MediaQuery.of(context).size.width,
//                                        height: 72,
//                                        padding: EdgeInsets.all(1),
//                                        child: RaisedButton(
//                                          elevation: 0.0,
//                                          color: Color(0xFFF7F7F8),
//                                          highlightColor: mainColor,
//                                          onPressed: () {
//                                            politics = snapshot
//                                                .data
//                                                .documents[0]
//                                                .data['politics'][index];
//                                            print(politics);
//
//                                            setState(() {
//                                              loading = true;
//                                            });
//
//                                            provider
//                                                .voteResult(
//                                                    voteResult, politics)
//                                                .then((value) {
//                                              if (value == 1) {
//                                                setState(() {
//                                                  loading = false;
//                                                });
//                                                voteFinDialog();
//                                              }
//                                            });
//                                          },
//                                          child: Container(
//                                            child: Center(
//                                              child: Text(
//                                                snapshot.data.documents[0]
//                                                    .data['politics'][index],
//                                                style: TextStyle(
//                                                    fontSize: 15,
//                                                    color: black,
//                                                    fontWeight:
//                                                        FontWeight.w600),
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      );
//                                    }));
//                              }
//                              return Container();
//                            },
//                          )
//                        ],
//                      ),
//                    ),
                ),
            loading
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appBar.preferredSize.height,
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    child: Positioned(
                      top: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              appBar.preferredSize.height) /
                          2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(mainColor),
                          ),
                          whiteSpaceH(10),
                          Text(
                            "투표 결과를 저장중입니다.",
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  voteDialog() {
    return showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: white,
            child: Container(
              width: 300,
              height: 241,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        whiteSpaceH(50),
                        Text(
                          '제출하시겠습니까?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
//                        whiteSpaceH(5),
//                        Text(
//                          "현재까지 참여한\n투표내용은 저장되지 않습니다.",
//                          style: TextStyle(color: black, fontSize: 15),
//                          textAlign: TextAlign.center,
//                        ),
                        whiteSpaceH(20),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  "수정하기",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    loading = true;
                                  });
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  provider.voteResult(voteResult).then((value) {
                                    if (value == 1) {
                                      setState(() {
                                        loading = false;
                                      });
                                      voteFinDialog();
                                    }
                                  });
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Text(
                                    "제출하기",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  backDialog() {
    return showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: white,
            child: Container(
              width: 300,
              height: 241,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        whiteSpaceH(50),
                        Text(
                          '투표를 종료하시겠습니까?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
//                        whiteSpaceH(5),
//                        Text(
//                          "현재까지 참여한\n투표내용은 저장되지 않습니다.",
//                          style: TextStyle(color: black, fontSize: 15),
//                          textAlign: TextAlign.center,
//                        ),
                        whiteSpaceH(20),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  "취소",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => TabSelect(0),
                                      ),
                                      (Route<dynamic> route) => false);
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Text(
                                    "확인",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  voteFinDialog() {
    return showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (_) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: white,
              child: Container(
                width: 300,
                height: 241,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(12)),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          whiteSpaceH(30),
                          Text(
                            '오늘의 투표가 완료되었습니다.',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: black),
                          ),
                          whiteSpaceH(30),
                          Text(
                            "오늘 하루도",
                            style: TextStyle(color: black, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                          whiteSpaceH(5),
                          Text(
                            "행복한 하루 되세요!",
                            style: TextStyle(
                                color: black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          whiteSpaceH(20),
                        ],
                      ),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => TabSelect(0),
                                        ),
                                        (Route<dynamic> route) => false);
                                  },
                                  color: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(12)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "확인",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
