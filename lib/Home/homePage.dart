import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/showToast.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';
import 'package:votewarehouse/Vote/votePage.dart';
import 'package:votewarehouse/Vote/voteResultPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var todayMonth = DateTime
      .now()
      .month; //현재 달
  var todayDay = DateTime
      .now()
      .day; //현재 날짜
  var todayHour = DateTime
      .now()
      .hour; //현재 시간
  var todayMin = DateTime
      .now()
      .minute; //현재 분
  var todaySec = DateTime
      .now()
      .second; //현재 시간초

  int timeCheck = 0;
  int timeCheckNum = 0;

  DateTime now = DateTime.now();
  DateTime nowTime;
  DateTime nextTime;
  int time = 0;

  DateTime setTime;

  Provider provider = Provider();
  bool vote = false;

  timeSet() async {
    if (now.hour >= 06 && now.hour < 10) {
      setState(() {
        timeCheck = 1;
      });
    } else if (now.hour >= 18 && now.hour < 20) {
      setState(() {
        timeCheck = 2;
      });
    } else {
      setState(() {
        timeCheck = 0;
      });
    }
  }

  voteCheck() async {
    DateTime now = DateTime.now();
    String format = DateFormat('yyyy-MM-dd').format(now);

    await Firestore.instance.collection("voteList").document(format).get().then((DocumentSnapshot value) {
      print(value.exists);
      if (value.exists) {
        setState(() {
          vote = true;
        });
      } else {
        setState(() {
          vote = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    voteCheck();

    timeSet();
  }

  List<String> testImage = [
    'images/1_price.png',
    'images/2_price.png',
    'images/2_price.png'
  ];
  List<String> testBanner = [
    'images/1_event.png',
    'images/2_event.png',
    'images/3_event.png',
    'images/4_event.png',
    'images/5_event.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Image.asset(
                                  'images/app_icon_2.png',
                                  fit: BoxFit.contain,
                                  width: 93,
                                  height: 30,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => VotePage()));
                              },
                              child: Container(
                                child: Center(
                                  child: Text("투표"),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => VoteResultPage()));
                              },
                              child: Container(
                                child: Center(
                                  child: Text("결과"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: const EdgeInsets.only(
                            top: 21,
                          ),
                          child: Text(
                            '당신의 의견이\n신문에 기재됩니다.',
                            textAlign: TextAlign.left,
                            softWrap: false,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: const EdgeInsets.only(top: 32),
                          child: Text(
                            '$todayMonth월 $todayDay일 오늘의 투표',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            softWrap: false,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        whiteSpaceH(6),
                        vote ?
                        timeCheck == 1
                            ? buttonVote()
                            : timeCheck == 2
                            ? buttonVoteResult()
                            : countDownOpen() : notVote(),
//                        buttonVoteResult(),
                        whiteSpaceH(32),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Color(0xFFEEEEFF))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    '금주 상품',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.left,
                                  )),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 142,
                                child: ListView.builder(
                                  itemBuilder: (context, idx) {
                                    return Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          testImage[idx],
                                          fit: BoxFit.fill,
                                          width: 160,
                                          height: 142,
                                        ),
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
                                    );
                                  },
                                  itemCount: testImage.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              whiteSpaceH(15),
                              Text(
                                "※ 매일 am06:00 전일 투표참여자를 대상으로 2nd상품을, 매주 월요일 am06:00 전주 5회 이상 투표참여자를 대상으로 1st상품의 추첨이 이루어집니다.",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFFBBBBBB)),
                              ),
                            ],
                          ),
                        ),
                        whiteSpaceH(16),
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 104,
                      child: Swiper(
                        itemBuilder: (context, idx) {
                          return GestureDetector(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                testBanner[idx],
                                fit: BoxFit.fill,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 104,
                              ),
                            ),
                          );
                        },
                        itemCount: testBanner.length,
                        itemWidth: MediaQuery
                            .of(context)
                            .size
                            .width - 20,
                        itemHeight: 104,
                        viewportFraction: 0.91,
                        scale: 0.95,
                      )
//                      ListView.builder(
//                      itemBuilder: (context, idx) {
//                        return Row(
//                          children: <Widget>[
//                            GestureDetector(
//                              onTap: () {},
//                              child: ClipRRect(
//                                borderRadius: BorderRadius.circular(6),
//                                child: Image.asset(
//                                  testBanner[idx],
//                                  fit: BoxFit.contain,
//                                  width: MediaQuery.of(context).size.width -
//                                      32,
//                                ),
//                              ),
//                            ),
//                            whiteSpaceW(8)
//                          ],
//                        );
//                      },
//                      scrollDirection: Axis.horizontal,
//                      itemCount: testBanner.length,
//                      shrinkWrap: true,
//                    ),
                  ),
                  whiteSpaceH(24)
                ],
              ),
            ),
//            loading ? Positioned.fill(
//                child: Center(
//              child: CircularProgressIndicator(
//                valueColor: AlwaysStoppedAnimation<Color>(mainColor),
//              ),
//            )) : Container()
          ],
        ),
      ),
    );
  }

  notVote() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: mainColor
      ),
      child: Center(
        child: Text("준비된 투표가 없습니다.", style: TextStyle(
          color: white, fontWeight: FontWeight.w600, fontSize: 24
        ),),
      ),
    );
  }

  buttonVote() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 85,
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          elevation: 0.0,
          padding: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.only(top: 14, left: 16, right: 16, bottom: 14),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '06:00 ~ 10:00',
                        style: TextStyle(
                            fontSize: 13,
                            color: white,
                            fontWeight: FontWeight.normal),
                      ),
                      whiteSpaceH(5),
                      Text(
                        '투표하기',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: white,
                )
              ],
            ),
          ),
          onPressed: () {
            provider.voteCheck().then((value) {
              if (value == 1) {
                showToast('오늘의 투표를 이미 참여하셨습니다.');
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => VotePage()));
              }
            });

          },
          color: mainColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
      ),
    );
  }

  //투표결과
  buttonVoteResult() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 85,
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Text(
                    '18:00 ~ 20:00',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: Color(0xffFFFFFF)),
                    softWrap: false,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        '결과보기',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      child: Container(
                        width: 50,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xffFFFFFF),
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                      ))
                ],
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => VoteResultPage()));
          },
          color: Color(0xff222222),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  //카운트다운 위젯
  countDownOpen() {
    DateTime now = DateTime.now();
    DateTime nowTimeSet =
    DateTime.utc(00, 00, now.day, now.hour, now.minute, now.second);
    DateTime nextTimeSet = DateTime.utc(00, 00, now.day, 10, 00, 00);
    int nowTime = 0;

    int check = 0;

    if (now.hour >= 20 || now.hour <= 5) {
      nextTimeSet = DateTime.utc(00, 00, now.day, 06, 00, 00); //06 시 열릴시간
      nowTime = nextTimeSet
          .toUtc()
          .millisecondsSinceEpoch -
          nowTimeSet
              .toUtc()
              .millisecondsSinceEpoch; //현재시간

      setState(() {
        check = 0;
      });
    } else if (now.hour >= 10 && now.hour < 18) {
      nextTimeSet = DateTime.utc(00, 00, now.day, 18, 00, 00); //18 시 열릴시간
      nowTime = nextTimeSet
          .toUtc()
          .millisecondsSinceEpoch -
          nowTimeSet
              .toUtc()
              .millisecondsSinceEpoch; //현재시간

      setState(() {
        check = 1;
      });
    }

    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 85,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Color(0xFFEEEEFF))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            check == 0
                ? '$todayMonth월 $todayDay일 투표 오픈까지'
                : '$todayMonth월 $todayDay일 결과 보기까지',
            style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
          ),
          whiteSpaceH(4),
//          Text(
//            "${setTime.hour.toString().length == 1 ? "0" + setTime.hour.toString() : setTime.hour}:${setTime.minute.toString().length == 1 ? "0" + setTime.minute.toString() : setTime.minute}:${setTime.second.toString().length == 1 ? "0" + setTime.second.toString() : setTime.second}",
//            style: TextStyle(
//                fontSize: 22,
//                fontWeight: FontWeight.w600,
//                color: Color(0xFFEE0033)),
//          ),
          Countdown(
            duration: Duration(milliseconds: nowTime),
            onFinish: () {
              timeSet();
            },
            builder: (BuildContext context, Duration remaining) {
              return Text(
                '${printDuration(
                  remaining,
                  delimiter: ':',
                  spacer: '',
                )}',
                textAlign: TextAlign.left,
                softWrap: false,
                style: TextStyle(
                    color: Color(0xffEE0033),
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              );
            },
          ),
        ],
      ),
    );
  }
}
