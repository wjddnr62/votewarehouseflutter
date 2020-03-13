import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'Home/tabSelect.dart';
import 'Public/color.dart';


class questanswerpage extends StatefulWidget {
  @override
  _questanswerpageState createState() => _questanswerpageState();
}

class _questanswerpageState extends State<questanswerpage> {

  String text_productprice='???';
  TextEditingController question_title = TextEditingController(); //질문제목
  TextEditingController question_Explanation = TextEditingController(); //질문 상세설명

  @override
  void dispose() {
    question_title.dispose();
    question_Explanation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: black
        ),
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){tab_page(context);},),
        backgroundColor: Colors.white,
        title: Text('질문건의',style: TextStyle(color: black,fontWeight: FontWeight.bold,fontSize: 15),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(padding: const EdgeInsets.only(left: 15,top: 20,right: 15),width: MediaQuery.of(context).size.width,child:Text('내일 아침 오늘의 투표에 올라오기 바라는 잘문을 건의 해주세요.',softWrap: true,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(top: 10),),
              Container(padding: const EdgeInsets.only(left: 15,right: 15),width: MediaQuery.of(context).size.width,child: Text('※채택시 $text_productprice 을(를) 드립니다.',style: TextStyle(color: Color(0xff00AAFF),fontSize: 12),textAlign: TextAlign.left,),),

              Padding(padding: const EdgeInsets.only(top: 20),),
              Container(padding: const EdgeInsets.only(left: 15,top: 20,right: 15),width: MediaQuery.of(context).size.width,child:Text('질문 제목',softWrap: true,style: TextStyle(fontSize: 13,color: Color(0xffBBBBBB)),textAlign: TextAlign.left,),),
              Container(padding: const EdgeInsets.only(left: 16,right: 16),width: MediaQuery.of(context).size.width,child: TextField(controller: question_title,decoration: InputDecoration(hintText: '제목을 입력해주세요.',),),),

              Padding(padding: const EdgeInsets.only(top: 15),),
              Container(padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 15),width: MediaQuery.of(context).size.width,child:Text('질문 내용',softWrap: true,style: TextStyle(fontSize: 13,color: Color(0xffBBBBBB)),textAlign: TextAlign.left,),),
              Container(padding:const EdgeInsets.only(right: 16,left: 16),

                decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 1.0,color: Colors.grey),borderRadius: BorderRadius.circular(0.0),),width: MediaQuery.of(context).size.width-25,height: 200,
                child: TextField(maxLength: 500,maxLines: 7,controller: question_Explanation,decoration: InputDecoration(hintText: '내용을 입력해주세요.',border: InputBorder.none),),),

              Padding(padding: const EdgeInsets.only(top: 25),),
//              SizedBox(
//                height: 20,
//              ),
              Container(width: MediaQuery.of(context).size.width-25,height: 56,
                child:RaisedButton(
                  onPressed: (){question_title.text ==''||question_title.text ==null ||question_Explanation.text==''||question_Explanation==null?question_null_popup() :Back_Question('제출완료','제출하시겠습니까?','확인','취소');},
                  color: Color(0xffE8C29D),
                  child: Text('제출하기',style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void tab_page(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabSelect(2)),(Route<dynamic> route) => false);
  }



  void question_null_popup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          title:  Text('빈곳이있습니다.',textAlign: TextAlign.center,),
          content: Container(height: MediaQuery.of(context).size.height/6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('제목과 내용을 입력해주세요.',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
              ],
            ),),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child:RaisedButton(
                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
                color: Color(0xffE8C29D),
                child:  Text("확인",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }


  void Back_Question(titletext, infomationtext, buttontext,buttontext_1) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          title:  Text(titletext,textAlign: TextAlign.center,),
          content: Container(height: MediaQuery.of(context).size.height/6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(width: MediaQuery.of(context).size.width,child:Text(infomationtext,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),softWrap: true,textAlign: TextAlign.center,))
              ],
            ),),
          actions: <Widget>[
            Container(width: MediaQuery.of(context).size.width/3,height: 48,child:RaisedButton(
              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
              color: Color(0xffE8C29D),
              child:  Text(buttontext,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              onPressed: () {
//                quesition_answer();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabSelect(2)),(Route<dynamic> route) => false);
              },
            ),),

            Container(width: MediaQuery.of(context).size.width/3,height: 48,child:RaisedButton(
              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
              color: Color(0xffE8C29D),
              child:  Text(buttontext_1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              onPressed: () {
                Navigator.of(context).pop(); //////////여기다!!~!!~~~~~~~~~~~~~~~~~~~~₩
              },
            ),),

          ],
        );
      },
    );
  }

}
