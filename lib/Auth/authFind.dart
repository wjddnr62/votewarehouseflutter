import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:votewarehouse/Auth/authFindPasswordChange.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Public/style.dart';
import 'package:votewarehouse/Util/showToast.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

class AuthFind extends StatefulWidget {
  @override
  _AuthFind createState() => _AuthFind();
}

class _AuthFind extends State<AuthFind> {
  bool idFind = true;
  bool passFind = false;
  bool phoneCheck = false;
  bool numberCheck = false;

  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();
  FocusNode smsCodeNode = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  Provider provider = Provider();

  bool authCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            idFind = true;
                            passFind = false;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 31,
                              color: white,
                              child: Center(
                                child: Text(
                                  "이메일 찾기",
                                  style: TextStyle(fontSize: 15, color: black),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: idFind ? mainColor : Color(0xFFDDDDEE),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            idFind = false;
                            passFind = true;
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 31,
                              color: white,
                              child: Center(
                                child: Text(
                                  "비밀번호 찾기",
                                  style: TextStyle(fontSize: 15, color: black),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: passFind ? mainColor : Color(0xFFDDDDEE),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                whiteSpaceH(40),
                passFind
                    ? TextFormField(
                        controller: idController,
                        style: textStyle,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          labelText: "이메일",
                          labelStyle: labelStyle,
                          focusedBorder: textFormBorder,
                        ),
                        cursorColor: mainColor,
                      )
                    : Container(),
                passFind ? whiteSpaceH(40) : Container(),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        child: TextFormField(
                          controller: phoneController,
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            if (value.length > 9) {
                              setState(() {
                                phoneCheck = true;
                              });
                            } else {
                              setState(() {
                                phoneCheck = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: '- 없이 번호 입력',
                            labelStyle: labelStyle,
                            focusedBorder: textFormBorder,
                            contentPadding: EdgeInsets.zero,
                          ),
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
                            if (idFind) {
                              if (phoneCheck) {
                                setState(() {
                                  _sendCodeToPhoneNumber();
                                  FocusScope.of(context)
                                      .requestFocus(smsCodeNode);
                                });
                              } else {
                                showToast("알맞은 휴대폰번호를 입력해주세요.");
                              }
                            } else {
                              if (idController.text.length != 0 && passFind) {
                                if (phoneCheck) {
                                  setState(() {
                                    _sendCodeToPhoneNumber();
                                    FocusScope.of(context)
                                        .requestFocus(smsCodeNode);
                                  });
                                } else {
                                  showToast("알맞은 휴대폰번호를 입력해주세요.");
                                }
                              } else {
                                showToast("이메일을 입력해주세요.");
                              }
                            }

                          },
                          color: phoneCheck ? mainColor : Color(0xFFCCCCCC),
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
                whiteSpaceH(40),
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
                          ),
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
                            if (numberCheck) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              _signInWithPhoneNumber();
                            } else {
                              showToast("인증번호 6자리를 입력해주세요.");
                            }
                          },
                          color: numberCheck ? mainColor : Color(0xFFCCCCCC),
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
                whiteSpaceH(40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      if (idFind) {
                        if (authCheck) {
                          provider.findId(phoneController.text).then((value) {
                            if (value == "") {
                              showToast("가입되지 않은 회원입니다.");
                            } else {
                              findDialog(value);
                            }
                          });
                        } else {
                          showToast("문자 인증을 완료해주세요.");
                        }
                      } else {
                        if (authCheck) {
                          print(idController.text);
                          print(phoneController.text);
                          provider
                              .findPass(idController.text, phoneController.text)
                              .then((value) {
                            if (value == 0) {
                              showToast("가입되지 않은 회원입니다.");
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AuthFindPasswordChange(
                                            email: idController.text,
                                          )));
                            }
                          });
                        } else {
                          showToast("문자 인증을 완료해주세요.");
                        }
                      }
                    },
                    color: authCheck ? mainColor : Color(0xFFCCCCCC),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    elevation: 0.0,
                    child: Container(
                      child: Center(
                        child: Text(
                          idFind ? "이메일찾기" : "비밀번호 변경",
                          style: TextStyle(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _sendCodeToPhoneNumber() async {
    _auth.setLanguageCode("kr");

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {});
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {});
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast("인증 번호가 발송되었습니다. 인증 번호를 입력해주세요.");
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
          setState(() {
            // 인증 성공
            authCheck = true;
            if (idFind) {
              showToast("문자 인증에 성공하였습니다. 이메일찾기 버튼을 눌러주세요.");
            } else {
              showToast("문자 인증에 성공하였습니다. 비밀번호 변경 버튼을 눌러주세요.");
            }
          });
        } else {
          showToast("문자 인증에 실패하였습니다.");
        }
      } else {
        showToast("문자 인증에 실패하였습니다.");
      }
    });
  }

  findDialog(email) {
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
                        whiteSpaceH(30),
                        Text(
                          '해당 연락처로 가입된 이메일은',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(email,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600)),
                            whiteSpaceW(5),
                            Text(
                              "입니다.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: black),
                            )
                          ],
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
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
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
}
