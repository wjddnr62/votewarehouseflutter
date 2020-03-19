import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votewarehouse/Home/tabSelect.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/showToast.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

import '../Auth/passwordChange.dart';
import '../Auth/requiredInfomation.dart';
import '../Auth/addinfomationPage.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPage createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  SharedPreferences shared;
  Provider provider = Provider();
  bool loading = false;

  logout() async {
    shared = await SharedPreferences.getInstance();

    await shared.clear();

    dataSave.email = null;
    dataSave.user = null;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => TabSelect(0)),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();

    addInfoData();
  }

  withdrawalDialog() {
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
                        Text(
                          '회원탈퇴 안내',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(38),
                        Text(
                          "정말로 회원을",
                          style: TextStyle(color: black, fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                        whiteSpaceH(5),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: '탈퇴',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: '하시겠습니까?',
                                style: TextStyle(
                                  color: black,
                                  fontSize: 22,
                                ))
                          ]),
                        ),
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
                                  setState(() {
                                    loading = true;
                                  });
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  provider
                                      .withdrawalUser(dataSave.email)
                                      .then((value) {
                                    if (value == 1) {
                                      setState(() {
                                        loading = false;
                                      });
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabSelect(0)),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      showToast("회원탈퇴를 실패하였습니다.");
                                    }
                                  });
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Text(
                                    "확인",
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
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12))),
                                child: Text(
                                  "취소",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
  
  bool addInfoCheck = false;
  bool getData = false;
  
  addInfoData() async {
    QuerySnapshot addInfoQuery = await Firestore.instance.collection("users").where("email", isEqualTo: dataSave.email).getDocuments();

    if (addInfoQuery.documents.length != 0) {
      if (!addInfoQuery.documents[0].data['addInfomation']) {
        setState(() {
          addInfoCheck = false;
        });
      } else {
        setState(() {
          addInfoCheck = true;
        });
      }
    }

    setState(() {
      getData = true;
    });
  }

  AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar = AppBar(
        title: Text(
          '마이페이지',
          style: TextStyle(
              color: black, fontWeight: FontWeight.w600, fontSize: 15),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: black,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 72,
                    color: white,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: white,
                            child: Text(
                              '${dataSave.email}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PasswordChange()));
                            },
                            child: Text('비밀번호변경',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFFBBBBBB),
                                  fontSize: 13,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Color(0xFFEEEEFF),
                  ),
                  whiteSpaceH(16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Color(0xFFEEEEFF),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    color: white,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "필수정보",
                            style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RequiredInfomation()));
                          },
                          child: Image.asset(
                            "assets/icon/modify_grey.png",
                            width: 24,
                            height: 24,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Color(0xFFEEEEFF),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 116,
                    color: white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 53,
                              child: Text(
                                "거주 지역",
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFFBBBBBB)),
                              ),
                            ),
                            whiteSpaceW(33),
                            Text(
                              dataSave.user != null ? dataSave.user.address : "",
                              style:
                              TextStyle(color: Color(0xFF666666), fontSize: 14),
                            )
                          ],
                        ),
                        whiteSpaceH(10),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 53,
                              child: Text(
                                "연령대",
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFFBBBBBB)),
                              ),
                            ),
                            whiteSpaceW(33),
                            Text(
                              dataSave.user != null ? dataSave.user.age : "",
                              style:
                              TextStyle(color: Color(0xFF666666), fontSize: 14),
                            )
                          ],
                        ),
                        whiteSpaceH(10),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 53,
                              child: Text(
                                "성별",
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFFBBBBBB)),
                              ),
                            ),
                            whiteSpaceW(33),
                            Text(
                              dataSave.user != null ? dataSave.user.gender : "",
                              style:
                              TextStyle(color: Color(0xFF666666), fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Color(0xFFEEEEFF),
                  ),
                  whiteSpaceH(16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Color(0xFFEEEEFF),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: RaisedButton(
                      elevation: 0,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddInfoMationPage(
                              type: 1,
                            )));
                      },
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              '추가정보',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          whiteSpaceW(10),
                          Expanded(
                            child: getData ? Text(addInfoCheck ? "입력한 정보 확인하기" : "추가 정보 입력 시 편의점 기프티콘을 100% 드립니다.", style: TextStyle(
                                color: Color(0xFFCCCCCC), fontSize: 10, fontWeight: FontWeight.w600
                            ),) : Container(),
                          ),
                          Image.asset(
                            "assets/icon/modify_grey.png",
                            width: 24,
                            height: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    color: Color(0xFFEEEEFF),
                  ),
                  whiteSpaceH(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          withdrawalDialog();
                        },
                        child: Container(
                          height: 20,
                          child: Center(
                            child: Text(
                              "회원탈퇴",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFBBBBBB),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ),
                      whiteSpaceW(12),
                      Text(
                        "·",
                        style: TextStyle(color: Color(0xFFCCCCCC)),
                      ),
                      whiteSpaceW(12),
                      GestureDetector(
                        onTap: () {
                          logout();
                        },
                        child: Container(
                          height: 20,
                          child: Center(
                            child: Text(
                              "로그아웃",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFBBBBBB),
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            loading
                ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height,
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(mainColor),
                ),
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
