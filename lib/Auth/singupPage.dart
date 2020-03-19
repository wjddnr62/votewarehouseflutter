import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:votewarehouse/Public/citys.dart';
import 'package:votewarehouse/Util/showToast.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Public/style.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

import 'addinfomationPage.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> with TickerProviderStateMixin {
  String titleText = "이메일을 입력해주세요.";

  bool nextInvisible = true;
  int type = 0; // 0 = 아이디
  bool keyBoardHide = true;

  AppBar appBar;

  Provider provider = Provider();

  bool idCheck = false;
  bool phoneCheck = false;
  bool numberCheck = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;
  String msg = "";
  bool authCheck = false;

  final emailController = TextEditingController(); //아이디
  final passController = TextEditingController(); //비밀번호
  final passCheckController = TextEditingController(); //비밀번호확인
  final phoneController = TextEditingController(); //핸드폰번호 입력
  final smsCodeController = TextEditingController(); //sms 인증

  final emailNode = FocusNode();
  final passNode = FocusNode();
  final passCheckNode = FocusNode();
  final phoneNode = FocusNode();
  final smsCodeNode = FocusNode();

  var emailRule = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var passwordRule = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,20}$',
  ); //비밀번호 6~20자리까지 특수문자,숫자,문자 최소1개씩 다포함

  bool nextSign = false;

  String email = "";
  String password = "";
  String phone = "";
  String address = "";
  String age = "";
  String genDer = "";

  @override
  void initState() {
    super.initState();

//    keyBoardCheck();
  }

  Future<void> _sendCodeToPhoneNumber() async {
    _auth.setLanguageCode("kr");

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        msg =
            'Received phone auth credential: ${phoneAuthCredential.toString()}';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        msg =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast("인증 번호가 발송되었습니다.\n인증 번호를 입력해주세요.");
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "+82" + phoneController.text,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCodeController.text,
    );

    // TODO : 테스트 할때만 주석풀고 진행 실제 폰은 아래 코드 있으면 안됨
//    await _auth.signInWithCredential(credential);

    await _auth.currentUser().then((value) {
      if (value != null) {
        if (value.uid != null) {
          msg = 'Successfully signed in, uid: ' + value.uid;
          setState(() {
            authCheck = true;
            nextInvisible = true;
            type = 5;
            titleText = "다음 버튼을 눌러주세요.";
          });
          showToast("문자 인증에 성공하였습니다. 다음 버튼을 눌러주세요.");
        } else {
          showToast("문자 인증에 실패하였습니다.");
        }
      } else {
        showToast("문자 인증에 실패하였습니다.");
      }
    });
  }

  firstSignView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        whiteSpaceH(10),
        Text(
          titleText,
          style: titleTextStyle,
        ),
//        whiteSpaceH(3),
//        Text(
//          "작성완료된 부분은 수정할 수 없습니다.",
//          style: TextStyle(fontSize: 10, color: Colors.black87),
//        ),
        whiteSpaceH(42),
        AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: type > 3
                ? Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: TextFormField(
                                maxLength: 6,
                                controller: smsCodeController,
                                focusNode: smsCodeNode,
                                style: textStyle,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  if (value.length == 6) {
                                    setState(() {
                                      numberCheck = true;
                                    });
                                  } else {
                                    setState(() {
                                      numberCheck = false;
                                    });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    counterText: "",
                                    labelText: '인증번호 입력',
                                    labelStyle: labelStyle,
                                    focusedBorder: textFormBorder,
                                    contentPadding: EdgeInsets.zero,
                                    suffixIcon: smsCodeNode.hasFocus
                                        ? IconButton(
                                            onPressed: () {
                                              smsCodeController.text = "";
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Color.fromARGB(
                                                  255, 197, 197, 197),
                                            ),
                                          )
                                        : null),
                                cursorColor: mainColor,
                              ),
                            ),
                          ),
                          whiteSpaceW(10),
                          Expanded(
                            child: Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                elevation: 0.0,
                                onPressed: () {
                                  if (type < 5) {
                                    if (numberCheck) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      _signInWithPhoneNumber();
                                    } else {
                                      showToast("인증번호 6자리를 입력해주세요.");
                                    }
                                  }
                                },
                                color:
                                    numberCheck ? mainColor : Color(0xFFCCCCCC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "인증",
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      whiteSpaceH(40)
                    ],
                  )
                : Container()),
        AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: type > 2
                ? Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: TextFormField(
                                controller: phoneController,
                                focusNode: phoneNode,
                                maxLength: 11,
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) async {
                                  if (value.length > 9) {
                                    await provider.phoneDuplicate(value.trim()).then((value) {
                                      if (value != 0) {
                                        setState(() {
                                          phoneCheck = false;
                                        });
                                      } else {
                                        setState(() {
                                          phoneCheck = true;
                                        });
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      phoneCheck = false;
                                    });
                                  }
                                },
//                                readOnly: type > 4 ? true : false,
                                decoration: InputDecoration(
                                    counterText: "",
                                    labelText: '- 없이 번호 입력',
                                    labelStyle: labelStyle,
                                    focusedBorder: textFormBorder,
                                    contentPadding: EdgeInsets.zero,
                                    suffixIcon: phoneNode.hasFocus
                                        ? IconButton(
                                            onPressed: () {
                                              phoneController.text = "";
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Color.fromARGB(
                                                  255, 197, 197, 197),
                                            ),
                                          )
                                        : null),
                                cursorColor: mainColor,
                              ),
                            ),
                          ),
                          whiteSpaceW(10),
                          Expanded(
                            child: Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                elevation: 0.0,
                                onPressed: () {
                                  if (type == 3 || type == 4) {
                                    if (phoneCheck) {
                                      setState(() {
                                        _sendCodeToPhoneNumber();
                                        type = 4;
                                        titleText = "인증번호를 입력해주세요.";
                                        FocusScope.of(context)
                                            .requestFocus(smsCodeNode);
                                      });
                                    } else {
                                      showToast("알맞은 형식에 번호가 아니거나 이미 가입된 번호입니다.");
                                    }
                                  }
                                },
                                color:
                                    phoneCheck ? mainColor : Color(0xFFCCCCCC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "인증번호",
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      whiteSpaceH(40)
                    ],
                  )
                : Container()),
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
                          controller: passCheckController,
                          focusNode: passCheckNode,
//                          readOnly: type > 2 ? true : false,
                          style: textStyle,
                          obscureText: true,
                          decoration: InputDecoration(
                              counterText: "",
                              labelText: '비밀번호 확인',
                              labelStyle: labelStyle,
                              focusedBorder: textFormBorder,
                              contentPadding: EdgeInsets.zero,
                              suffixIcon: passCheckNode.hasFocus
                                  ? IconButton(
                                      onPressed: () {
                                        passCheckController.text = "";
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color:
                                            Color.fromARGB(255, 197, 197, 197),
                                      ),
                                    )
                                  : null),
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
                          controller: passController,
                          focusNode: passNode,
//                          readOnly: type > 2 ? true : false,
                          style: textStyle,
                          obscureText: true,
                          decoration: InputDecoration(
                              counterText: "",
                              labelText: '비밀번호',
                              labelStyle: labelStyle,
                              focusedBorder: textFormBorder,
                              contentPadding: EdgeInsets.zero,
                              suffixIcon: passNode.hasFocus
                                  ? IconButton(
                                      onPressed: () {
                                        passController.text = "";
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color:
                                            Color.fromARGB(255, 197, 197, 197),
                                      ),
                                    )
                                  : null),
                          cursorColor: mainColor,
                        ),
                      ),
                      whiteSpaceH(40)
                    ],
                  )
                : Container()),
        Container(
          height: 48,
          child: TextFormField(
            onChanged: (value) async {
              if (value.length != 0) {
                setState(() {
                  nextInvisible = false;
                });
              } else {
                setState(() {
                  nextInvisible = true;
                });
              }

              await provider.idDuplicate(value.trim()).then((value) {
                if (value != 0) {
                  idCheck = false;
                } else {
                  idCheck = true;
                }
              });
            },
            controller: emailController,
//            readOnly: type == 0 ? false : true,
            focusNode: emailNode,
            style: textStyle,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                counterText: "",
                labelText: '이메일',
                labelStyle: labelStyle,
                focusedBorder: textFormBorder,
                contentPadding: EdgeInsets.zero,
                suffixIcon: emailNode.hasFocus
                    ? IconButton(
                        onPressed: () {
                          emailController.text = "";
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Color.fromARGB(255, 197, 197, 197),
                        ),
                      )
                    : null),
            cursorColor: mainColor,
          ),
        ),
        type > 4
            ? Padding(
                padding: EdgeInsets.only(top: 55, bottom: 13),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      if (idCheck &&
                          phoneCheck &&
                          numberCheck &&
                          authCheck &&
                          type == 5) {
                        setState(() {
                          email = emailController.text;
                          password = passController.text;
                          phone = phoneController.text;
                          titleText = "거주지역을 확인하여 주세요.";
                          nextSign = true;
                        });
                      } else {
                        showToast("끝나지 않은 절차가 있습니다.");
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    color: mainColor,
                    elevation: 0.0,
                    child: Container(
                      child: Center(
                        child: Text(
                          "다음",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  String selectValueCity;
  String selectValueSi;
  String selectValueGu;
  String _city = "";
  String _si = "";
  String _gu = "";
  String selectAge;

  List<String> siList = [];
  List<String> guList = [];
  List<String> ageList = ['10대', '20대', '30대', '40대', '50대', '60대', '70대이상'];

  gu() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        child: DropdownButton<String>(
          isExpanded: true,
          elevation: 0,
          style: textStyle,
          items: guList.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(
                  value,
                  style: textStyle,
                ),
              ),
            );
          }).toList(),
          underline: selectValueGu != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: mainColor,
                )
              : null,
          value: selectValueGu,
          onChanged: (value) {
            setState(() {
              selectValueGu = value;
              _gu = value;
              ageView = true;
            });
          },
        ),
      ),
    );
  }

  si() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        child: DropdownButton<String>(
          isExpanded: true,
          elevation: 0,
          style: textStyle,
          items: siList.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: Text(
                  value,
                  style: textStyle,
                ),
              ),
            );
          }).toList(),
          underline: selectValueSi != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: mainColor,
                )
              : null,
          value: selectValueSi,
          onChanged: (value) {
            setState(() {
              selectValueSi = value;
              selectValueGu = null;
              _si = value;
              if (selectValueCity == "경기") {
                if (selectValueSi == "수원시") {
                  guList = gyeongGiSuwon;
                  guSet = true;
                } else if (selectValueSi == "성남시") {
                  guList = gyeongGiSeongnam;
                  guSet = true;
                } else if (selectValueSi == "안양시") {
                  guList = gyeongGiAnyang;
                  guSet = true;
                } else if (selectValueSi == "안산시") {
                  guList = gyeongGiAnsan;
                  guSet = true;
                } else if (selectValueSi == "고양시") {
                  guList = gyeongGiGoyang;
                  guSet = true;
                } else if (selectValueSi == "용인시") {
                  guList = gyeongGiYougin;
                  guSet = true;
                } else {
                  guSet = false;
                  ageView = true;
                }
              } else if (selectValueCity == "충북") {
                if (selectValueSi == "청주시") {
                  guList = chungBugCheongju;
                  guSet = true;
                } else {
                  guSet = false;
                  ageView = true;
                }
              } else if (selectValueCity == "충남") {
                if (selectValueSi == "천안시") {
                  guList = chungNamCheonan;
                  guSet = true;
                } else {
                  guSet = false;
                  ageView = true;
                }
              } else if (selectValueCity == "경북") {
                if (selectValueSi == "포항시") {
                  guList = gyeongBugPohang;
                  guSet = true;
                } else {
                  guSet = false;
                  ageView = true;
                }
              } else if (selectValueCity == "경남") {
                if (selectValueSi == "창원시") {
                  guList = gyeongNamChangwon;
                  guSet = true;
                } else {
                  guSet = false;
                  ageView = true;
                }
              } else if (selectValueCity == "전북") {
                if (selectValueSi == "전주시") {
                  guList = jeonBugJeonju;
                  guSet = true;
                } else {
                  guSet = false;
                  ageView = true;
                }
              } else {
                guSet = false;
                ageView = true;
              }
            });
          },
        ),
      ),
    );
  }

  bool siSet = false;
  bool guSet = false;
  bool ageView = false;
  bool gender = false;
  bool male = false;
  bool feMale = false;

  bool finishButton = false;

  bool signLoading = false;

  signFinDialog() {
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
                          '회원가입이 완료되었습니다.',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
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
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                          (Route<dynamic> route) => false);
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
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddInfoMationPage(
                                              email: email,
                                              type: 0,
                                            ),
                                      ),
                                          (Route<dynamic> route) => false);
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

  secondSignView() {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            whiteSpaceH(10),
            Text(
              titleText,
              style: titleTextStyle,
            ),
            whiteSpaceH(45),
            Text(
              "거주 지역",
              style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 13),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        elevation: 0,
                        style: textStyle,
                        items: city.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                style: textStyle,
                              ),
                            ),
                          );
                        }).toList(),
                        value: selectValueCity,
                        underline: selectValueCity != null
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: mainColor,
                              )
                            : null,
                        onChanged: (value) {
                          setState(() {
                            selectValueCity = value;
                            _city = value;
                            selectValueSi = null;
                            selectValueGu = null;
                            guSet = false;
                            if (selectValueCity == "서울") {
                              siList = seoul;
                              siSet = true;
                            } else if (selectValueCity == "부산") {
                              siList = busan;
                              siSet = true;
                            } else if (selectValueCity == "대구") {
                              siList = daegu;
                              siSet = true;
                            } else if (selectValueCity == "인천") {
                              siList = incheon;
                              siSet = true;
                            } else if (selectValueCity == "대전") {
                              siList = daejeon;
                              siSet = true;
                            } else if (selectValueCity == "광주") {
                              siList = gwangju;
                              siSet = true;
                            } else if (selectValueCity == "울산") {
                              siList = ulsan;
                              siSet = true;
                            } else if (selectValueCity == "경기") {
                              siList = gyeongGi;
                              siSet = true;
                            } else if (selectValueCity == "충북") {
                              siList = chungBug;
                              siSet = true;
                            } else if (selectValueCity == "충남") {
                              siList = chungNam;
                              siSet = true;
                            } else if (selectValueCity == "경북") {
                              siList = gyeongBug;
                              siSet = true;
                            } else if (selectValueCity == "경남") {
                              siList = gyeongNam;
                              siSet = true;
                            } else if (selectValueCity == "전북") {
                              siList = jeonBug;
                              siSet = true;
                            } else if (selectValueCity == "전남") {
                              siList = jeonNam;
                              siSet = true;
                            } else if (selectValueCity == "강원") {
                              siList = gangWon;
                              siSet = true;
                            } else if (selectValueCity == "제주") {
                              siList = jeju;
                              siSet = true;
                            } else if (selectValueCity == "세종") {
                              siSet = false;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  whiteSpaceW(8),
                  siSet
                      ? si()
                      : Expanded(
                          child: Container(),
                        ),
                  whiteSpaceW(8),
                  guSet
                      ? gu()
                      : Expanded(
                          child: Container(),
                        )
                ],
              ),
            ),
            whiteSpaceH(27),
            AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: ageView
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "연령대",
                          style:
                              TextStyle(color: Color(0xFFBBBBBB), fontSize: 13),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            elevation: 0,
                            style: textStyle,
                            items: ageList.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Text(
                                    value,
                                    style: textStyle,
                                  ),
                                ),
                              );
                            }).toList(),
                            underline: selectAge != null
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: mainColor,
                                  )
                                : null,
                            value: selectAge,
                            onChanged: (value) {
                              setState(() {
                                selectAge = value;
                                gender = true;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  : Container(),
            ),
            whiteSpaceH(27),
            AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: gender
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "성별",
                          style:
                              TextStyle(color: Color(0xFFBBBBBB), fontSize: 13),
                        ),
                        whiteSpaceH(10),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                child: RaisedButton(
                                  elevation: 0.0,
                                  onPressed: () {
                                    setState(() {
                                      male = true;
                                      feMale = false;
                                      finishButton = true;
                                    });
                                  },
                                  color: male
                                      ? mainColor
                                      : Color.fromARGB(255, 229, 229, 229),
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "남성",
                                        style: textStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            whiteSpaceW(10),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                child: RaisedButton(
                                  elevation: 0.0,
                                  onPressed: () {
                                    setState(() {
                                      feMale = true;
                                      male = false;
                                      finishButton = true;
                                    });
                                  },
                                  color: feMale
                                      ? mainColor
                                      : Color.fromARGB(255, 229, 229, 229),
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "여성",
                                        style: textStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  : Container(),
            ),
            whiteSpaceH(30),
            AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: finishButton
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async {
                          if (!male && !feMale) {
                            showToast("성별을 선택해주세요.");
                          } else {
                            setState(() {
                              signLoading = true;
                            });

                            if (male) {
                              genDer = "남성";
                            } else if (feMale) {
                              genDer = "여성";
                            }
                            age = selectAge;

                            await provider.addUsers({
                              'email': email,
                              'password': password,
                              'phone': phone,
                              'address': _city + " " + _si + " " + _gu,
                              'gender': genDer,
                              'age': age,
                              'addInfomation': false,
                              'push': true,
                              'signDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              'addInfoDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            }).then((value) {
                              if (value == 1) {
                                setState(() {
                                  signLoading = false;
                                });
//                                signFinDialog();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddInfoMationPage(
                                            email: email,
                                            type: 0,
                                          ),
                                    ),
                                        (Route<dynamic> route) => false);
                              } else {
                                setState(() {
                                  signLoading = false;
                                });
                                showToast("회원가입에 실패하였습니다.");
                              }
                            });
                          }
                        },
                        color: mainColor,
                        child: Container(
                          child: Center(
                            child: Text(
                              "완료",
                              style: textStyle,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
            whiteSpaceH(20)
          ],
        ),
        signLoading
            ? Positioned.fill(
                top: 40,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                  ),
                ))
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appBar = AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: type == 5 ? null : NeverScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: type == 5
              ? null
              : MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  appBar.preferredSize.height,
//          type == 0
//              ? MediaQuery.of(context).size.height -
//                  MediaQuery.of(context).padding.top -
//                  appBar.preferredSize.height
//              : null,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: !nextSign ? firstSignView() : secondSignView(),
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
//                    keyBoardHide ? 0 : MediaQuery.of(context).viewInsets.bottom,
                child: !nextInvisible
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (type == 0) {
                              if (emailRule.hasMatch(emailController.text)) {
                                if (idCheck) {
                                  setState(() {
                                    type = 1;
                                    titleText = "비밀번호를 입력해주세요.";
                                    FocusScope.of(context)
                                        .requestFocus(passNode);
                                  });
                                } else {
                                  showToast("중복된 아이디입니다.");
                                }
                              } else {
                                showToast("알맞지 않은 이메일 형식입니다.");
                              }
                            } else if (type == 1) {
                              if (passwordRule.hasMatch(passController.text)) {
                                setState(() {
                                  type = 2;
                                  titleText = "비밀번호를 확인해주세요.";
                                  FocusScope.of(context)
                                      .requestFocus(passCheckNode);
                                });
                              } else if (passController.text.length < 6) {
                                showToast("6자리 이상 입력해주세요.");
                              } else {
                                showToast("영문, 숫자, 특수문자를 섞어 작성해주세요.");
                              }
                            } else if (type == 2) {
                              if (passController.text ==
                                  passCheckController.text) {
                                setState(() {
                                  type = 3;
                                  titleText = "휴대폰번호를 입력해주세요.";
                                  FocusScope.of(context)
                                      .requestFocus(phoneNode);
                                  nextInvisible = true;
                                });
                              } else {
                                showToast("비밀번호가 일치하지 않습니다.");
                              }
                            }
                          },
                          color: mainColor,
                          elevation: 0.0,
                          child: Container(
                            child: Center(
                              child: Text(
                                "확인",
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
