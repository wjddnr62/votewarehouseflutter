import 'package:flutter/material.dart';
import 'package:votewarehouse/LotteryStatus_history.dart';
import 'Home/tabSelect.dart';
import 'Public/color.dart';

class lotteryStatus extends StatefulWidget {
  @override
  _lotteryStatusState createState() => _lotteryStatusState();
}

class _lotteryStatusState extends State<lotteryStatus> {
  var today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Tab_page(context);
          },
          color: black,
        ),
        title: Text(
          '추첨현황',
          style: TextStyle(color: black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 40),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '금주 투표 참여 현황',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 19),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '일',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '월',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '화',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '수',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '목',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '금',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '토',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '※ 상품응모 확인해주세요.',
                  softWrap: true,
                  style: TextStyle(color: Color(0xff00AAFF)),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 43),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 24,
                    width: 24,
                    child: Icon(Icons.assignment_turned_in),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '추첨내역',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffEEEEFF)),
                ),
                child: InkWell(
                  onTap: () {
                    Lottery_history(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 8),
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffBBBBBB),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.year}.${today.month}.${today.day}~${today.year}.${today.month}.${today.day + 30}',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xffBBBBBB)),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.month}월 ${today.day}주차 추첨내역',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffEEEEFF)),
                ),
                child: InkWell(
                  onTap: () {
                    Lottery_history(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 8),
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffBBBBBB),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.year}.${today.month}.${today.day}~${today.year}.${today.month}.${today.day + 30}',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xffBBBBBB)),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.month}월 ${today.day}주차 추첨내역',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffEEEEFF)),
                ),
                child: InkWell(
                  onTap: () {
                    Lottery_history(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 8),
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffBBBBBB),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.year}.${today.month}.${today.day}~${today.year}.${today.month}.${today.day + 30}',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xffBBBBBB)),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.month}월 ${today.day}주차 추첨내역',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffEEEEFF)),
                ),
                child: InkWell(
                  onTap: () {
                    Lottery_history(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 8),
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffBBBBBB),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.year}.${today.month}.${today.day}~${today.year}.${today.month}.${today.day + 30}',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xffBBBBBB)),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.month}월 ${today.day}주차 추첨내역',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffEEEEFF)),
                ),
                child: InkWell(
                  onTap: () {
                    Lottery_history(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 8),
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffBBBBBB),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.year}.${today.month}.${today.day}~${today.year}.${today.month}.${today.day + 30}',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xffBBBBBB)),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${today.month}월 ${today.day}주차 추첨내역',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Lottery_history(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            lotterystatus_history(today.year, today.month, today.day)));
  }

  void Tab_page(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => TabSelect(2)),
        (Route<dynamic> route) => false);
  }
}
