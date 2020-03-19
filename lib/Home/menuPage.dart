import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votewarehouse/Auth/loginPage.dart';
import 'package:votewarehouse/Home/tabSelect.dart';
import 'package:votewarehouse/MyPage/myPage.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';
import 'package:votewarehouse/menu/eventPage.dart';
import 'package:votewarehouse/menu/question.dart';
import 'package:votewarehouse/menu/termsOfUse.dart';
import 'package:votewarehouse/menu/privacyPolicy.dart';
import 'package:votewarehouse/menu/planningNews.dart';

class MenuPage extends StatefulWidget {
  _MenuPage createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  bool loginCheck = false;

  bool push = true;

  Provider provider = Provider();

  @override
  void initState() {
    super.initState();

    loginC();
  }

  loginC() {
    if (dataSave.email != null && dataSave.email != "") {
      setState(() {
        loginCheck = true;
        pushSet();
      });
    } else {
      setState(() {
        loginCheck = false;
      });
    }
  }

  pushSet() {
    setState(() {
      push = dataSave.user.push;
    });
  }

  final bottomText = TextStyle(fontSize: 13, color: Color(0xFF666666));

  bottomInfo() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              "images/searchresearch_logo.png",
              width: 118,
              height: 60,
              fit: BoxFit.contain,
            ),
            whiteSpaceH(5),
            Text(
              "(주)서치리서치",
              style: bottomText,
            ),
            whiteSpaceH(5),
            Text(
              "사업자등록번호 : 187-15-01111",
              style: bottomText,
            ),
            whiteSpaceH(5),
            Text(
              "주소 : 서울특별시 강남구 테헤란로 216, 12층(역삼동)",
              style: bottomText,
            ),
            whiteSpaceH(5),
            Text(
              "이메일 : help@srchresrch.com",
              style: bottomText,
            ),
            whiteSpaceH(5),
            Text(
              "연락처 : 02-1544-5677 (09:00 ~ 18:00)",
              style: bottomText,
            ),
            whiteSpaceH(10),
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: "Copyright ⓒ", style: bottomText),
                TextSpan(
                    text: "searchresearch.",
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                TextSpan(text: ' All Rights Reserved.', style: bottomText)
              ]),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "전체",
          style: TextStyle(
              color: black, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: loginCheck
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //신상정보
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 72,
                        child: RaisedButton(
                          elevation: 0.5,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyPage()));
                          },
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              whiteSpaceW(10),
                              Expanded(
                                child: Text(
                                  dataSave.email,
                                  style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffBBBBBB),
                                ),
                              ),
                              whiteSpaceW(10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  whiteSpaceH(16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromRGBO(187, 187, 187, 0.5),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: RaisedButton(
                        elevation: 0.5,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabSelect(1)));
                        },
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icon/list_bk.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '추첨현황',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )),
                  whiteSpaceH(1),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: RaisedButton(
                        elevation: 0.5,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EventPage()));
                        },
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icon/event_bk.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '이벤트',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )),
                  whiteSpaceH(1),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: RaisedButton(
                        elevation: 0.5,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlanningNews()));
                        },
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icon/news_bk.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '기획뉴스',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )),
                  whiteSpaceH(16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromRGBO(187, 187, 187, 0.5),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Question()));
                        },
                        elevation: 0.5,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icon/inquiry_bk.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '투표건의',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )),
                  whiteSpaceH(16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromRGBO(187, 187, 187, 0.5),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: RaisedButton(
                        onPressed: null,
                        disabledColor: white,
                        elevation: 0.5,
                        focusColor: white,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icon/push_bk.png",
                              width: 24,
                              height: 24,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '알림',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Switch(
                              activeColor: mainColor,
                              onChanged: (value) {
                                setState(() {
                                  push = value;
                                  provider.pushUpdate(dataSave.email, push);
                                });
                              },
                              value: push,
                            )
                          ],
                        ),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromRGBO(187, 187, 187, 0.5),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TermsOfUse()));
                        },
                        elevation: 0.5,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icon/terms_bk.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '이용약관',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )),
                  whiteSpaceH(1),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PrivacyPolicy()));
                        },
                        elevation: 0.5,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icon/private_bk.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                '개인정보 처리방침',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )),
                  bottomInfo()
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 72,
                  color: white,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    padding: EdgeInsets.zero,
                    color: white,
                    elevation: 0.0,
                    child: Container(
                      child: Row(children: <Widget>[
                        whiteSpaceW(10),
                        Expanded(
                          child: Text(
                            "로그인",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: black),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: black,
                        ),
                        whiteSpaceW(10),
                      ]),
                    ),
                  ),
                ),
                whiteSpaceH(10),
                bottomInfo()
              ],
            ),
    );
  }
}
