import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votewarehouse/Auth/loginPage.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Public/style.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/showToast.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

class PasswordChange extends StatefulWidget {
  @override
  _PasswordChange createState() => _PasswordChange();
}

class _PasswordChange extends State<PasswordChange>
    with TickerProviderStateMixin {
  TextEditingController nowPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController newPassCheckController = TextEditingController();

  var passwordRule = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,20}$',
  ); //비밀번호 6~20자리까지 특수문자,숫자,문자 최소1개씩 다포함

  SharedPreferences shared;

  logout() async {
    shared = await SharedPreferences.getInstance();

    await shared.clear();

    dataSave.email = null;
    dataSave.user = null;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
            (Route<dynamic> route) => false);
  }

  String changeText = "현재 비밀번호를 입력해주세요.";
  int type = 0;
  bool nowPassReadOnly = false;
  bool newPassReadOnly = false;

  Provider provider = Provider();

  changeDialog() {
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
                        whiteSpaceH(40),
                        Text(
                          '설정하신 비밀번호로',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(5),
                        Text(
                          "비밀번호를 변경하시겠습니까?.",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w600,),
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  provider.passChange(newPassController.text)
                                      .then((value) {
                                    if (value == 1) {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      logout();
                                      showToast("변경하신 비밀번호로 로그인해주세요.");
                                    } else {
                                      showToast("비밀번호가 변경에 실패하였습니다.");
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: black,
          ),
          centerTitle: true,
          title: Text("비밀번호변경", style: TextStyle(
            color: black, fontSize: 15, fontWeight: FontWeight.w600
          ),),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            changeText,
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w600,
                                fontSize: 22),
                          ),
                        ),
                        whiteSpaceH(40),
                        AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            child: type > 1
                                ? Column(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  child: TextFormField(
                                    maxLength: 20,
                                    controller: newPassCheckController,
                                    readOnly: newPassReadOnly,
                                    style: textStyle,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      labelText: '새 비밀번호 확인',
                                      labelStyle: labelStyle,
                                      focusedBorder: textFormBorder,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    cursorColor: mainColor,
                                  ),
                                ),
                                whiteSpaceH(40)
                              ],
                            )
                                : Container()),
                        AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            child: type > 0
                                ? Column(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  child: TextFormField(
                                    maxLength: 20,
                                    controller: newPassController,
                                    readOnly: newPassReadOnly,
                                    style: textStyle,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      labelText: '새 비밀번호',
                                      labelStyle: labelStyle,
                                      focusedBorder: textFormBorder,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    cursorColor: mainColor,
                                  ),
                                ),
                                whiteSpaceH(40)
                              ],
                            )
                                : Container()),
                        AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            child: type >= 0
                                ? Column(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  child: TextFormField(
                                    maxLength: 20,
                                    controller: nowPassController,
                                    readOnly: nowPassReadOnly,
                                    style: textStyle,
                                    obscureText: true,
                                    onChanged: (value) {
                                      if (dataSave.user.pass == value) {
                                        setState(() {
                                          nowPassReadOnly = true;
                                          changeText = "새 비밀번호를 입력해주세요.";
                                          type = 1;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      labelText: '현재 비밀번호',
                                      labelStyle: labelStyle,
                                      focusedBorder: textFormBorder,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    cursorColor: mainColor,
                                  ),
                                ),
                                whiteSpaceH(40)
                              ],
                            )
                                : Container()),
                        whiteSpaceH(40)
                      ]),
                  type > 0 ? Positioned(
                      bottom: 0,
                      child: AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        vsync: this,
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 56,
                          child: RaisedButton(
                            onPressed: () {
                              if (type == 1) {
                                if (passwordRule.hasMatch(newPassController
                                    .text)) {
                                  setState(() {
                                    type = 2;
                                    changeText = "새 비밀번호를 다시 입력해주세요.";
                                  });
                                } else if (newPassController.text.length < 6) {
                                  showToast("6자리 이상 입력해주세요.");
                                } else if (dataSave.user.pass ==
                                    newPassController.text) {
                                  showToast("현재 비밀번호가 다르게 설정해주세요.");
                                } else {
                                  showToast("영문, 숫자, 특수문자를 섞어 작성해주세요.");
                                }
                              } else if (type == 2) {
                                if (newPassController.text ==
                                    newPassCheckController.text) {
                                  changeDialog();
                                } else {
                                  showToast("비밀번호가 일치하지 않습니다.");
                                }
                              }
                            },
                            color: mainColor,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            child: Center(
                              child: Text("다음",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      )) : Container()
                ],
              ),
            )));
  }
}
