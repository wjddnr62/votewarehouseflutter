import 'package:flutter/material.dart';
import 'package:votewarehouse/LotteryStatus_page.dart';

import 'Public/color.dart';

class lotterystatus_history extends StatefulWidget {

  int year;
  int month;
  int today;
  lotterystatus_history(this.year,this.month,this.today);

  @override
  _lotterystatus_historyState createState() => _lotterystatus_historyState();
}

class _lotterystatus_historyState extends State<lotterystatus_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('추첨현황',style: TextStyle(color: black),),
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: black,),onPressed: (){Lottery_history(context);},),
        backgroundColor: Colors.white,
        centerTitle: true,

      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 40),),
              Container(width: MediaQuery.of(context).size.width,child: Text('${widget.year}.${widget.month}.${widget.today} ~ ${widget.year}.${widget.month}.${widget.today}',style: TextStyle(color: Color(0xffBBBBBB),fontSize: 12),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(top: 6),),
              Container(width: MediaQuery.of(context).size.width,child: Text('${widget.month}월 ${widget.today} 투표참여 내역',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(top: 19 ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('일'),
                  Text('월'),
                  Text('화'),
                  Text('수'),
                  Text('목'),
                  Text('금'),
                  Text('토'),
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 16),),
              Container(padding: const EdgeInsets.only(top: 16),width: MediaQuery.of(context).size.width,child:Text('※ 상품응모 확인해주세요.',softWrap: true,style: TextStyle(color: Color(0xff00AAFF)),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(top: 18),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',style: TextStyle(fontWeight: FontWeight.bold,fontSize:22 ),),),
              Padding(padding: const EdgeInsets.only(top: 19),),

              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 156,
                  height: 146,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffEEEEFF))
                  ),
                  child: Image.asset('images/1_price.png',fit: BoxFit.cover),
                ) ,
              ),
              Padding(padding: const EdgeInsets.only(top: 14),),
              Container(width: MediaQuery.of(context).size.width,child: Text('${widget.year}.${widget.month}.${widget.today} ~ ${widget.year}.${widget.month}.${widget.today}',style: TextStyle(color: Color(0xffBBBBBB),fontSize: 12),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(top: 8),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),

              Padding(padding: const EdgeInsets.only(top: 28),),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 156,
                  height: 146,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffEEEEFF))
                  ),
                  child: Image.asset('images/2_price.png',fit: BoxFit.cover),
                ) ,
              ),
              Padding(padding: const EdgeInsets.only(top: 14),),
              Container(width: MediaQuery.of(context).size.width,child: Text('${widget.year}.${widget.month}.${widget.today}',style: TextStyle(color: Color(0xffBBBBBB),fontSize: 12),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(top: 10),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),

              Padding(padding: const EdgeInsets.only(top: 22),),
              Container(width: MediaQuery.of(context).size.width,child: Text('${widget.year}.${widget.month}.${widget.today+1}',style: TextStyle(color: Color(0xffBBBBBB),fontSize: 12),textAlign: TextAlign.left,),),
              Padding(padding: const EdgeInsets.only(top: 10),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),
              Container(width: MediaQuery.of(context).size.width,child: Text('당첨자',textAlign: TextAlign.left,),),

              Padding(padding: const EdgeInsets.only(top: 22),),

            ],
          ),
        ),
      ),
    );
  }
  void Lottery_history(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> lotteryStatus()));
  }
}
