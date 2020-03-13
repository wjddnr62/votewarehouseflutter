

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votewarehouse/Public/color.dart';

import 'loginPage.dart';

class AuthFind extends StatefulWidget {
  @override
  _AuthFind createState() => _AuthFind();
}

class _AuthFind extends State<AuthFind> {

  String number_smscode;
  String verificationId;
  String verification_smsCode;

  TextEditingController textfild_find_id = TextEditingController();
  TextEditingController textfild_find_cellphone = TextEditingController();
  TextEditingController textfild_find_cellphone_admin_number = TextEditingController();

  bool click_button = true;
  bool check_phone_number = false;

  @override
  void dispose() {
    textfild_find_id.dispose();
    textfild_find_cellphone.dispose();
    textfild_find_cellphone_admin_number.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back_ios,),onPressed: (){login_route_page(context);},color: black,),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child:Container(
                      width: MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        border:Border(
                          bottom: BorderSide(
                            color: click_button? Color(0xffE8C29D) :black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child:Container(padding: const EdgeInsets.only(top: 10),child:CupertinoButton(
                        child:Text('아이디 찾기',style: TextStyle(fontSize: 18,color: black),),
                        onPressed: (){Find_id();},
                      ),),
                    ),
                  ),
                  Container(
                    child:Container(
                      width: MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        border:Border(
                          bottom: BorderSide(
                            color: click_button? black:Color(0xffE8C29D),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child:Container(padding: const EdgeInsets.only(top: 10),child:CupertinoButton(
                        child:Text('비밀번호 찾기',style: TextStyle(fontSize: 18,color: black),),
                        onPressed: (){Find_passward();},
                      ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 50),),
              Container(
                child: click_button?Find_id_UI(context):Find_passward_UI(context),
              )

            ],
          ),
        ),
      ),

    );
  }


  void login_route_page(BuildContext context){ //회원가입
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> LoginPage()),(Route<dynamic> route) => false);
  }



  Find_id()
  {
    setState(() {
      click_button = true;
      check_phone_number=false;
    });

  }

  Find_passward()
  {
    setState(() {
      click_button = false;
      check_phone_number = false;
    });
  }

  Widget Find_id_UI(BuildContext context){
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
        Container(width: MediaQuery.of(context).size.width/1.5,padding: const EdgeInsets.only(left: 15,top: 10,right: 15),child:TextField(controller: textfild_find_cellphone, decoration: InputDecoration(hintText: '휴대폰 번호 입력: - 없이 입력'),),),
        Container(width: MediaQuery.of(context).size.width/3,padding: const EdgeInsets.only(right: 15),height: 48,child:RaisedButton(onPressed:(){_cellphonecheck_button();} ,child: Text('인증번호',textAlign: TextAlign.center,),color: Color(0xffE8C29D),))
          ],
        ),
      Padding(padding: const EdgeInsets.only(top: 40),),
      Row(
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width/1.5,padding: const EdgeInsets.only(left: 15,top: 10,right: 15),child:TextField(controller: textfild_find_cellphone_admin_number, decoration: InputDecoration(hintText: '인증번호 입력'),),),
          Container(width: MediaQuery.of(context).size.width/3,padding: const EdgeInsets.only(right: 15),height: 48,child:RaisedButton(onPressed:(){_cellphonecheck_1(textfild_find_cellphone_admin_number.text);} ,child: Text('인증',textAlign: TextAlign.center,),color: Color(0xffE8C29D),))
        ],
      ),
      Padding(padding: const EdgeInsets.only(top: 250),),
      Container(height: 56,width: MediaQuery.of(context).size.width-20,child: RaisedButton(child: Text('아이디찾기',style: TextStyle(color: Color(0xffFFFFFF),fontWeight: FontWeight.bold),),color: Color(0xffE8C29D),onPressed: (){main_route_page_id();},),),
      ],
    );
  }

  Widget Find_passward_UI(BuildContext context){
    return Column(children: <Widget>[
      Container(width: MediaQuery.of(context).size.width,padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 40),child:TextField(controller: textfild_find_id, decoration: InputDecoration(hintText: '이메일을 입력해주세요.'),),),
      Row(
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width/1.5,padding: const EdgeInsets.only(left: 15,top: 10,right: 15),child:TextField(controller: textfild_find_cellphone, decoration: InputDecoration(hintText: '휴대폰 번호 입력: - 없이 입력'),),),
          Container(width: MediaQuery.of(context).size.width/3,padding: const EdgeInsets.only(right: 15),height: 48,child:RaisedButton(onPressed:(){_cellphonecheck_button();} ,child: Text('인증번호',textAlign: TextAlign.center,),color: Color(0xffE8C29D),))
        ],
      ),
      Padding(padding: const EdgeInsets.only(top: 40),),
      Row(
        children: <Widget>[
          Container(width: MediaQuery.of(context).size.width/1.5,padding: const EdgeInsets.only(left: 15,top: 10,right: 15),child:TextField(controller: textfild_find_cellphone_admin_number, decoration: InputDecoration(hintText: '인증번호 입력'),),),
          Container(width: MediaQuery.of(context).size.width/3,padding: const EdgeInsets.only(right: 15),height: 48,child:RaisedButton(onPressed:(){_cellphonecheck_1(textfild_find_cellphone_admin_number.text);} ,child: Text('인증',textAlign: TextAlign.center,),color: Color(0xffE8C29D),))
        ],
      ),
      Padding(padding: const EdgeInsets.only(top: 160),),
      Container(height: 56,width: MediaQuery.of(context).size.width-20,child: RaisedButton(child: Text('비밀번호 변경',style: TextStyle(color: Color(0xffFFFFFF),fontWeight: FontWeight.bold),),color: Color(0xffE8C29D),onPressed: (){main_route_page_passward(context);},),),
    ],
    );
  }


  main_route_page_id() async {
    final QuerySnapshot docs = await Firestore.instance.collection('${textfild_find_cellphone.text}').where('phone',isEqualTo: textfild_find_cellphone.text).getDocuments();
    if(docs.documents.length ==1&&check_phone_number){
      List<DocumentSnapshot> doc = docs.documents;
      AlertDialog_text('해당연락처로 가입된 아이디는','${doc[0].data['id'].toString()} 입니다.','확인');
    }
    else if(!check_phone_number){
      AlertDialog_text('휴대폰 인증','휴대폰 문자메시지를 확인해주세요.','확인');
    }
    else if(docs.documents.length ==0){
      AlertDialog_text('회원정보가 없습니다.','회원가입을 먼저해주세요.','확인');
    }
  }

  main_route_page_passward(BuildContext context) async {
    final QuerySnapshot docs = await Firestore.instance.collection('${textfild_find_id.text}').where('id',isEqualTo: textfild_find_id.text).getDocuments();
    if(docs.documents.length ==1&&check_phone_number){
      //비밀번호변경페이지로 넘겨야함..
//      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>changepassward(textfild_find_id.text,textfild_find_cellphone.text)));
    }
    else if(!check_phone_number){
      AlertDialog_text('휴대폰 인증','휴대폰 문자메시지를 확인해주세요.','확인');
    }
    else if(docs.documents.length ==0){
      AlertDialog_text('회원정보가 없습니다.','회원가입을 먼저해주세요.','확인');
    }
  }

  //휴대폰으로 SMS코드 날리는부분
  void _cellphonecheck_button() async {


    //sms인증이 성공적으로 날라갔을때
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential user) {
      setState(() {
        print('인증번호맞음');
        //_visible_Cellphone_1 = true; //인증요청이 잘 날라가면!
      });
    };

    //문자인증이 sms가 안날라왔을때
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        print(
            'Phone number 확인!!!!! failed. Code: ${authException.code}. Message: ${authException.message}');
      });
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      this.verification_smsCode = verificationId;
      this.number_smscode = forceResendingToken.toString();

    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;

    };


    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+82${textfild_find_cellphone.text}',
      timeout: const Duration(seconds: 60), //문자받고 유효시간 60초
      verificationCompleted: verificationCompleted, //sms인증 문자가 제대로 도착한경우
      verificationFailed: verificationFailed, //sms인증 문자가 제대로 도착하지 못 한 경우
      codeSent: codeSent,//6자리 코드
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,

    );
  }


//인증번호 확인하는부분
  void _cellphonecheck_1(String smsCoderecevie) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential( verificationId: verification_smsCode, smsCode: smsCoderecevie);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.setLanguageCode('KR');

    if (verification_smsCode == null) {
      //휴대폰 인증문자를 안받았을경
      return;
    }
    if (FirebaseAuth.instance.currentUser() != null) {
      try {
        final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        print('인증번호가 맞게 넘어감');
        check_phone_number=true;
        AlertDialog_text('인증이 완료되었습니다.','버튼을 눌러주세요.','확인');

      } on Exception catch (e) {
        if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          //인증번호가 틀렸을때
          check_phone_number=false;
          AlertDialog_text('인증번호를 확인해주세요','인증번호가 틀렸습니다!','확인');
          print('인증번호가 틀림');

        }
      }
    } else {
      print("asdasdwadsadwad");
    }
  }


  void AlertDialog_text(titletext, infomationtext, buttontext) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          title:  Text(titletext,textAlign: TextAlign.center,),
          content: Container(height: MediaQuery.of(context).size.height/6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(infomationtext,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child:RaisedButton(
                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
                color: Color(0xffE8C29D),
                child:  Text(buttontext,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                onPressed: () {
                  Navigator.of(context).pop(); //////////여기다!!~!!~~~~~~~~~~~~~~~~~~~~₩
                },
              ),
            ),
          ],
        );
      },
    );
  }



}
