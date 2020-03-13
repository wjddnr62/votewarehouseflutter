import 'package:flutter/material.dart';
import 'package:votewarehouse/Home/tabSelect.dart';
import 'package:votewarehouse/Model/user.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/citys.dart';
import 'package:votewarehouse/Public/style.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/showToast.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

import '../Public/color.dart';

class RequiredInfomation extends StatefulWidget {
  @override
  _RequiredInfomation createState() => _RequiredInfomation();
}

class _RequiredInfomation extends State<RequiredInfomation>
    with TickerProviderStateMixin {
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

  bool finishButton = false;

  bool signLoading = false;

  String age = "";
  String genDer = "";
  String address = "";

  Provider provider = Provider();

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

  String titleText = "거주지역을 확인하여 주세요.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        title: Text(
          "필수정보수정",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: modifyView(),
            ),
          ],
        ),
      ),
    );
  }

  modifyView() {
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
                            address = _city + " " + _si + " " + _gu;

                            provider
                                .changeRequiredInfomation(genDer, age, address)
                                .then((value) {
                              if (value == 1) {
                                dataSave.user = User(
                                  addInfomation: dataSave.user.addInfomation,
                                  token: dataSave.user.token,
                                  push: dataSave.user.push,
                                  phone: dataSave.user.phone,
                                  age: age,
                                  address: address,
                                  gender: genDer,
                                  email: dataSave.user.email,
                                  pass: dataSave.user.pass,
                                );

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => TabSelect(0),
                                    ),
                                    (Route<dynamic> route) => false);
                              } else {
                                showToast("필수정보변경을 실패하였습니다.");
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
}
