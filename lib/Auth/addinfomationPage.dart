import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:votewarehouse/Home/tabSelect.dart';
import 'package:votewarehouse/Model/infomation.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';
import 'package:votewarehouse/Util/showToast.dart';

// ignore: must_be_immutable
class AddInfoMationPage extends StatefulWidget {

  String email;
  int type;

  AddInfoMationPage({Key key, this.email, this.type}) : super(key : key);

  @override
  _AddInfoMationPage createState() => _AddInfoMationPage();
}

class _AddInfoMationPage extends State<AddInfoMationPage> {

  int checkQuestion = 0;

  String selectedHouse; //주거형태
  List<String> house = ['아파트', '빌라', '오피스텔', '연립, 주택', '원룸', '고시원'];

  String selectedHouseLiving; //주거구분
  List<String> houseLiving = ['자가', '전세', '월세', '기타'];

  String selectedFamily; //세대 구성원
  List<String> family = ['1인', '2인', '3인', '4인', '5인 이상'];

  String selectedMarriage; //혼인여부
  List<String> marriage = ['미혼', '기혼', '이혼'];

  String selectedSchool; //최종학력
  List<String> school = [
    '고졸 이하',
    '전문대(재학 혹은 졸업)',
    '대학교(재학 혹은 졸업)',
    '대학원(재학 혹은 졸업)'
  ];

  String selectedPhoneAgency; //통신사
  List<String> phoneAgency = ['SKT', 'KT', 'LG', '기타(알뜰폰 등)'];

  String selectedPolitics; //정치성향
  List<String> politics = ['진보', '보수', '중도'];

  String selectedJob; //직업
  List<String> job = [
    '무직',
    '학생',
    '자영업',
    '판매/영업 서비스직',
    '기능/직업직',
    '사무/기술직',
    '경영/관리직',
    '자유/전문직',
    '농/임/어/축산업'
  ];

  /*'자영업(종업원 9인 이하 점포 운영 및 가족 종사자, 개인택시 등)',
  '판매/영업 서비스직(세일즈맨, 점원, 보험설계사 등)',
  '기능/직업직 (중장비/트럭운전사, 전자/가전제품 AS기술자 ,숙련공 등)',
  '사무/기술직(과장 이하 회사원, 6급 이하 공무원,교사 등)',
  '경영/관리직(종업원 10인 이상 회사 운영, 일반 기업 부장급 이상, 5급 이상 공무원, 교장 등)',
  '자유/전문직(교수,판사,변호사,의사,약사,간호사,예술가,언론인,프리랜서 등)',
  '농/임/어/축산업 (가족이 하는 일을 돕는 가족종사자 포함)'*/

  String selectedFamilyMoney; //가족 구성원 월 소득
  List<String> familyMoney = [
    '월 100만 원 미만',
    '월 100만 원 이상 ~ 200만 원 미만',
    '월 200만 원 이상 ~ 300만 원 미만',
    '월 300만 원 이상 ~ 400만 원 미만',
    '월 400만 원 이상 ~ 500만 원 미만',
    '월 500만 원 이상 ~ 600만 원 미만',
    '월 600만 원 이상 ~ 700만 원 미만',
    '월 700만 원 이상 ~ 800만 원 미만',
    '월 800만 원 이상 ~ 900만 원 미만',
    '월 900만 원 이상 ~ 1000만 원 미만',
    '월 1000만 원 이상'
  ];

  String selectedMyMoney; //본인 월 소득
  List<String> myMoney = [
    '월 100만 원 미만',
    '월 100만 원 이상 ~ 200만 원 미만',
    '월 200만 원 이상 ~ 300만 원 미만',
    '월 300만 원 이상 ~ 400만 원 미만',
    '월 400만 원 이상 ~ 500만 원 미만',
    '월 500만 원 이상 ~ 600만 원 미만',
    '월 600만 원 이상 ~ 700만 원 미만',
    '월 700만 원 이상 ~ 800만 원 미만',
    '월 800만 원 이상 ~ 900만 원 미만',
    '월 900만 원 이상 ~ 1000만 원 미만',
    '월 1000만 원 이상'
  ];

  String selectedCar; //자가용 보유여부
  List<String> car = ['자가', '렌트', '리스', '없음'];


  @override
  void initState() {
    super.initState();

    print(dataSave.user.addInfomation);
    if (widget.type == 1 && dataSave.user.addInfomation) {
      print("in");
      selectedCar = dataSave.infoMation.car;
      selectedFamily = dataSave.infoMation.family;
      selectedFamilyMoney = dataSave.infoMation.familyMoney;
      selectedHouse = dataSave.infoMation.house;
      selectedJob = dataSave.infoMation.job;
      selectedHouseLiving = dataSave.infoMation.houseLiving;
      selectedMarriage = dataSave.infoMation.marriage;
      selectedMyMoney = dataSave.infoMation.myMoney;
      selectedPhoneAgency = dataSave.infoMation.phoneAgency;
      selectedPolitics = dataSave.infoMation.politics;
      selectedSchool = dataSave.infoMation.school;
      checkQuestion = 11;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backDialog();
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              backDialog();
            },
          ),
          elevation: 0,
          backgroundColor: white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              whiteSpaceH(24),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '추가 정보 입력',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    child: Text(
                      '($checkQuestion/11문항)',
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '1. 주거형태',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedHouse,
                    items: house
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '주거형태를 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedHouse != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedHouse == null) {
                          checkQuestion++;
                        }
                        selectedHouse = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '2. 주거구분',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedHouseLiving,
                    items: houseLiving
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '주거구분을 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedHouseLiving != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedHouseLiving == null) {
                          checkQuestion++;
                        }
                        selectedHouseLiving = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '3. 세대 구성원 수',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedFamily,
                    items: family
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '세대 구성원을 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedFamily != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedFamily == null) {
                          checkQuestion++;
                        }
                        selectedFamily = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '4. 혼인여부',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedMarriage,
                    items: marriage
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '혼인여부를 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedMarriage != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedMarriage == null) {
                          checkQuestion++;
                        }
                        selectedMarriage = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '5. 최종학력',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedSchool,
                    items: school
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '최종 학력을 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedSchool != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedSchool == null) {
                          checkQuestion++;
                        }
                        selectedSchool = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '6. 통신사',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedPhoneAgency,
                    items: phoneAgency
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '사용중인 통신사를 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedPhoneAgency != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedPhoneAgency == null) {
                          checkQuestion++;
                        }
                        selectedPhoneAgency = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '7. 정치 성향',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedPolitics,
                    items: politics
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '본인의 정치 성향을 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedPolitics != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedPolitics == null) {
                          checkQuestion++;
                        }
                        selectedPolitics = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '8. 직업',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedJob,
                    items: job
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: AutoSizeText(
                          label,
                          maxFontSize: 12,
                          minFontSize: 6,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '현재 직업을 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedJob != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedJob == null) {
                          checkQuestion++;
                        }
                        selectedJob = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '9. 가족 구성원 월 소득',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedFamilyMoney,
                    items: familyMoney
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '가족의 월 소득을 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedFamilyMoney != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedFamilyMoney == null) {
                          checkQuestion++;
                        }
                        selectedFamilyMoney = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '10. 본인 월 소득',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedMyMoney,
                    items: myMoney
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '본인의 월 소득을 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedMyMoney != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedMyMoney == null) {
                          checkQuestion++;
                        }
                        selectedMyMoney = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                padding: const EdgeInsets.only(left: 16),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '11. 자가용 보유 여부',
                  style: TextStyle(color: Color(0xffBBBBBB), fontSize: 13),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(fontSize: 14, color: black, decoration: TextDecoration.none),
                    value: selectedCar,
                    items: car
                        .map((label) => DropdownMenuItem(
                      child: Container(
                        child: Text(label),
                        alignment: Alignment.bottomCenter,
                      ),
                      value: label,
                    ))
                        .toList(),
                    decoration: InputDecoration(
                        hintText: '자가용 보유 여부를 선택하여주세요.',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        enabledBorder: selectedCar != null
                            ? UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: mainColor, width: 2))
                            : null),
                    onChanged: (value) {
                      setState(() {
                        if (selectedCar == null) {
                          checkQuestion++;
                        }
                        selectedCar = value;
                      });
                    },
                  )),
              whiteSpaceH(40),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          backDialog();
                        },
                        child: Text(
                          '나중에',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: black),
                        ),
                        color: Color(0xffF7F7F8),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          myPage();
                        },
                        child: Text(
                          '완료',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15, color: white),
                        ),
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  myPage() {
    if (checkQuestion >= 11) {
      finDialog();
    } else {
      showToast("선택하지 않은 추가 정보가 있습니다. 모든 입력해주세요.");
    }
  }

  popVoteFalse(titleText, infoMationText, buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(14.0),
          ),
          title: Text(
            titleText,
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  infoMationText,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(14.0),
                ),
                color: Color(0xffE8C29D),
                child: Text(
                  buttonText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
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

  backDialog() {
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
                          '나중에 입력하시겠습니까?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(20),
                        Text(
                          "지금 돌아가면 처음부터\n다시 입력하셔야 합니다.",
                          style :TextStyle(color: black, fontSize: 22),
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
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => TabSelect(0),
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
                      ))
                ],
              ),
            ),
          );
        });
  }

  finDialog() {
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
                          '추가 정보 입력이 안료되었습니다.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(60),
                        Text(
                          "수고하셨습니다!",
                          style :TextStyle(color: black, fontSize: 22, fontWeight: FontWeight.w600),
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
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Text(
                                    "수정하기",
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
                                  if (widget.type == 0) {
                                    addInfomation();
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => TabSelect(0),
                                        ),
                                            (Route<dynamic> route) => false);
                                  } else {
                                    updateInfomation();
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.of(context).pop();
                                  }
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12))),
                                child: Text(
                                  "제출하기",
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

  Provider provider = Provider();
  String email = "";

  addInfomation() async {
    if (widget.email != "" && widget.email != null) {
      email = widget.email;
    } else {
      email = dataSave.email;
    }

    await provider.addInfomation({
      'email': email,
      'house': selectedHouse, //주거 ex) 아파트 빌라 등
      'houseLiving': selectedHouseLiving, //주거형태 ex) 전세, 월세 등
      'family': selectedFamily, //가족 구성원 몇명이냐
      'marriage': selectedMarriage, //결혼여부
      'school': selectedSchool, //최종학력
      'phoneAgency': selectedPhoneAgency, //핸드폰 통신사
      'politics': selectedPolitics, //정치성향
      'job': selectedJob, //직업
      'familyMoney': selectedFamilyMoney, //가족 구성원 월소득
      'myMoney': selectedMyMoney, // 본인 월소득
      'car': selectedCar, //차 소유여부
    }, email);
  }

  updateInfomation() async {
    await provider.updateInfomation(Infomation(
      school: selectedSchool,
      politics: selectedPolitics,
      phoneAgency: selectedPhoneAgency,
      myMoney: selectedMyMoney,
      marriage: selectedMarriage,
      job: selectedJob,
      houseLiving: selectedHouseLiving,
      house: selectedHouse,
      familyMoney: selectedFamilyMoney,
      family: selectedFamily,
      car: selectedCar,
      email: dataSave.email
    ));
  }
}
