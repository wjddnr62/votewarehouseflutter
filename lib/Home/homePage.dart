import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:votewarehouse/Auth/addinfomationPage.dart';
import 'package:votewarehouse/Model/banner.dart';
import 'package:votewarehouse/Model/product.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/dataSava.dart';
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

    await Firestore.instance
        .collection("voteList")
        .document(format)
        .get()
        .then((DocumentSnapshot value) {
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

    productCheck();

    getBanner();

    addInfoCheck();
  }

  bool bannerSet = false;

  List<BannerData> banners = List();

  getBanner() async {
    QuerySnapshot bannerQuery = await Firestore.instance.collection("banner").getDocuments();

    for (int i = 0; i < bannerQuery.documents.length; i++) {
      banners.add(BannerData(
        url: bannerQuery.documents[i].data['url'],
        image: bannerQuery.documents[i].data['image']
      ));
    }

    setState(() {
      bannerSet = true;
    });
  }

  List<Product> productData = List();

  int productCount = 0;

  String startDate;
  String endDate;

  bool loading = false;

  productCheck() async {
    setState(() {
      loading = true;
    });
    List<int> numbers = [1, 2, 3, 4];
    for (int i = 0; i < numbers.length; i++) {
      QuerySnapshot countQuery = await Firestore.instance
          .collection("drawResult").orderBy('startDate', descending: true)
          .where('startDate',
          isLessThanOrEqualTo: DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .getDocuments();


      if (countQuery.documents[0].data['product${i + 1}'] != null &&
          countQuery.documents[0].data['product${i + 1}'] != "") {
        startDate = countQuery.documents[0].data['startDate'];
        endDate = countQuery.documents[0].data['endDate'];
        productCount++;
      }
    }

    productGet();
  }

  productGet() async {
    QuerySnapshot imageQuery = await Firestore.instance
        .collection("drawResult")
        .where("startDate", isEqualTo: startDate)
        .where("endDate", isEqualTo: endDate)
        .getDocuments();

    if (imageQuery.documents.length != 0) {
      for (int i = 0; i < productCount; i++) {
        productData.add(Product(
            name: 'product${i + 1}',
            url: imageQuery.documents[0].data['product${i + 1}']));
      }
      setState(() {
        loading = false;
      });
    }
  }

  addInfoPageMove() {
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
                        whiteSpaceH(20),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "간단한 ",
                                style: TextStyle(color: black, fontSize: 22)),
                            TextSpan(
                                text: "추가 정보면",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600))
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "금주 상품에 ",
                                style: TextStyle(color: black, fontSize: 22)),
                            TextSpan(
                                text: "자동응모가!",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600))
                          ]),
                        ),
                        whiteSpaceH(28),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "추가 정보를",
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 13,
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text: " 입력하시겠습니까?",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline))
                          ]),
                        ),
                        whiteSpaceH(5),
                        Text("※ 미 입력시 3개월에 한번 권유", style: TextStyle(
                            color: black, fontSize: 12
                        ),),
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
                                      bottomLeft: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Text(
                                    "나중에",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
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
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) => AddInfoMationPage(type: 1,)));
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12))),
                                child: Text(
                                  "입력하기",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: white,
                                      fontWeight: FontWeight.w600),
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

  addInfoCheck() async {
    if (dataSave.email != null && dataSave.email != "") {
      QuerySnapshot addInfoQuery = await Firestore.instance.collection("users").where("email", isEqualTo: dataSave.email).where("addInfomation", isEqualTo: false).getDocuments();

      if (addInfoQuery.documents.length != 0) {
        DateFormat dateFormat = DateFormat('yyyy-MM-dd');

        DateTime nowDate = DateTime.now();
        DateTime infoDate = dateFormat.parse(addInfoQuery.documents[0].data['addInfoDate']);

        print("check : " + nowDate.difference(infoDate).inDays.toString());
        if (nowDate.difference(infoDate).inDays > 89) {

          await Firestore.instance
              .collection("users")
              .document(addInfoQuery.documents[0].documentID)
              .updateData({'addInfoDate': dateFormat.format(DateTime.now())});

          addInfoPageMove();


        }
      }
    }

  }
  
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
                                if (dataSave.email != "" &&
                                    dataSave.email != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VotePage()));
                                } else {
                                  showToast("로그인이 필요한 서비스입니다.");
                                }
                              },
                              child: Container(
                                child: Center(
                                  child: Text("투표"),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (dataSave.email != "" &&
                                    dataSave.email != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VoteResultPage()));
                                } else {
                                  showToast("로그인이 필요한 서비스입니다.");
                                }
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
                        vote
                            ? timeCheck == 1
                            ? buttonVote()
                            : timeCheck == 2
                            ? buttonVoteResult()
                            : countDownOpen()
                            : notVote(),
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
                              loading ? Container(
                                height: 142,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        mainColor),
                                  ),
                                ),
                              ) : Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 142,
                                child: ListView.builder(
                                  itemBuilder: (context, idx) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Stack(
                                        children: <Widget>[
                                          Image.network(
                                            productData[idx].url,
                                            fit: BoxFit.contain,
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
                                      ),
                                    );
                                  },
                                  itemCount: productData.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              whiteSpaceH(15),
                              Text(
                                "※ 1st : 매주 5회 이상 투표 참여자 대상, 매주 월 오전 6시 발표\n※ 2nd : 전날 투표 참여자 대상, 매일 오전 6시 발표",
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
                      height: 116,
                      child: bannerSet ? Swiper(
                        itemBuilder: (context, idx) {
                          return GestureDetector(
                            onTap: () {
                              if (banners[idx].url != null && banners[idx].url != "") {
                                launch(banners[idx].url);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                banners[idx].image,
                                fit: BoxFit.contain,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 116,
                              ),
                            ),
                          );
                        },
                        itemCount: banners.length,
                        itemWidth: MediaQuery
                            .of(context)
                            .size
                            .width - 20,
                        itemHeight: 104,
                        viewportFraction: 0.91,
                        scale: 0.95,
                      ) : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                        ),
                      )
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
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: mainColor),
      child: Center(
        child: Text(
          "준비된 투표가 없습니다.",
          style: TextStyle(
              color: white, fontWeight: FontWeight.w600, fontSize: 24),
        ),
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
            if (dataSave.email != "" && dataSave.email != null) {
              provider.voteCheck().then((value) {
                if (value == 1) {
                  showToast('오늘의 투표를 이미 참여하셨습니다.');
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VotePage()));
                }
              });
            } else {
              showToast("로그인이 필요한 서비스입니다.");
            }
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
                        '결과 보기',
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
            if (dataSave.email != "" && dataSave.email != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VoteResultPage()));
            } else {
              showToast("로그인이 필요한 서비스입니다.");
            }
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
                ? '투표 오픈까지'
                : '결과 보기까지',
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
