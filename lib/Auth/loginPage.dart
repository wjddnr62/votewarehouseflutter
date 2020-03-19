import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votewarehouse/Home/tabSelect.dart';

import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Util/showToast.dart';

import 'package:votewarehouse/Util/whiteSpace.dart';

import 'authFind.dart';
import 'singupPage.dart';
import 'package:votewarehouse/Public/style.dart';
import 'package:votewarehouse/Public/color.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with TickerProviderStateMixin {
  SharedPreferences shared;
  FirebaseMessaging _fcm = FirebaseMessaging();

  final idController = TextEditingController();
  final passController = TextEditingController();

  final passNode = FocusNode();

  bool loading = false;

  @override
  void initState() {
    super.initState();

  }

  shareInit() async {
    shared = await SharedPreferences.getInstance();

    await shared.setString("email", idController.text);
    await shared.setString("pass", passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => TabSelect(0),
            ),
                (Route<dynamic> route) => false);
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => TabSelect(0),
                  ),
                      (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.arrow_back_ios, color: black,),
          ),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 6),
                      child: Image.asset('images/votehouse_logo.png',
                          fit: BoxFit.contain, height: 96, width: 96)),
                  whiteSpaceH(48),
                  TextFormField(
                    controller: idController,
                    style: textStyle,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passNode);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: "이메일",
                      labelStyle: labelStyle,
                      focusedBorder: textFormBorder,
                    ),
                    cursorColor: mainColor,
                  ),
                  whiteSpaceH(40),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      style: textStyle,
                      focusNode: passNode,
                      obscureText: true,
                      controller: passController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelText: '비밀번호 입력',
                          labelStyle: labelStyle,
                          focusedBorder: textFormBorder),
                      cursorColor: mainColor,
                    ),
                  ),
                  whiteSpaceH(40),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        login();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      color: mainColor,
                      elevation: 0.0,
                    ),
                  ),
                  whiteSpaceH(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AuthFind()));
                        },
                        child: Container(
                          height: 20,
                          child: Text(
                            "계정찾기",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFFBBBBBB),
                                fontSize: 13),
                          ),
                        ),
                      ),
                      whiteSpaceW(12),
                      Text(
                        "·",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color(0xFFBBBBBB),
                            fontSize: 13),
                      ),
                      whiteSpaceW(12),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: Container(
                          height: 20,
                          child: Text(
                            "회원가입",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xFFBBBBBB),
                                fontSize: 13),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            loading ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(mainColor),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  Provider provider = Provider();

  login() async {
    if (idController.text == "" || idController.text == null) {
      setState(() {
        loading = false;
      });
      showToast("이메일을 입력해주세요.");
    } else if (passController.text == "" || passController.text == null) {
      setState(() {
        loading = false;
      });
      showToast("비밀번호를 입력해주세요.");
    } else {
      String fcm = await _fcm.getToken();
      provider.login(idController.text, passController.text, fcm).then((value) {
        if (value == 0) {
          setState(() {
            loading = false;
          });
          showToast("이메일 또는 비밀번호가 틀리거나 존재하지 않는 회원입니다.");
        } else {
          setState(() {
            loading = false;
          });
          shareInit();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TabSelect(0)),
              (Route<dynamic> route) => false);
        }
      });
    }
  }
}
