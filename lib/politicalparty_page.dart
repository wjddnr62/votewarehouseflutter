import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class politicalpart extends StatefulWidget {
  @override
  _politicalpartState createState() => _politicalpartState();
}

class _politicalpartState extends State<politicalpart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//
//      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(padding: const EdgeInsets.only(top: 96,left: 16,right: 124,bottom: 40),width: MediaQuery.of(context).size.width,child:Text('본인이 선호하는\n정당은 어디인가요?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),

              Row(
                children: <Widget>[
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"더불어민주당"을\n선택했습니다.');},child:Text('더불어민주당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"자유한국당"을\n선택했습니다.');},child:Text('자유한국당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"바른미래당"을\n선택했습니다.');},child:Text('바른미래당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"민주평화당"을\n선택했습니다.');},child:Text('민주평화당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"정의당"을\n선택했습니다.');},child:Text('정의당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"우리공화당"을\n선택했습니다.');},child:Text('우리공화당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"민주당"을\n선택했습니다.');},child:Text('민주당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                  Container(height: 72,width: MediaQuery.of(context).size.width/3,child: RaisedButton(onPressed: (){Question_choice('"민주평화당"을\n선택했습니다.');},child:Text('민주평화당',style: TextStyle(fontWeight: FontWeight.bold),)),),
                ],
              ),

            ],
          ),
        ),
      ),


    );
  }

  void Question_choice(infomationtext) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          title:  Text('맞게 선택됬는지 확인해주세요.',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          content: Container(height: MediaQuery.of(context).size.height/6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(child:Text(infomationtext,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              ],
            ),),
          actions: <Widget>[
            Container(height: 48,width: MediaQuery.of(context).size.width/2.8,child:RaisedButton(
              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
              color: Color(0xffE8C29D),
              child:  Text('확인',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              onPressed: () {
                Navigator.of(context).pop();
                finish_vote();//////////여기다!!~!!~~~~~~~~~~~~~~~~~~~~

              },
            ),),

            Container(height: 48,width: MediaQuery.of(context).size.width/2.8,child:RaisedButton(
              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
              color: Color(0xffE8C29D),
              child:  Text('취소',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              onPressed: () {
                Navigator.of(context).pop(); //////////여기다!!~!!~~~~~~~~~~~~~~~~~~~~₩
              },
            ),),


          ],
        );
      },
    );
  }


  void finish_vote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
          title:  Text('오늘의 투표가 완료되었습니다.',textAlign: TextAlign.center,),
          content: Container(height: MediaQuery.of(context).size.height/6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('오늘 하루도',style:TextStyle(fontSize: 25),),
                Text('행복한 하루 되세요!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
              ],
            ),),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child:RaisedButton(
                shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
                color: Color(0xffE8C29D),
                child:  Text("제출하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
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



}
