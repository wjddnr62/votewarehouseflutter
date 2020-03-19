import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:votewarehouse/Provider/provider.dart';
import 'package:votewarehouse/Public/style.dart';
import 'package:votewarehouse/Util/dataSava.dart';
import 'package:votewarehouse/Util/showToast.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';
import '../Public/color.dart';

class Question extends StatefulWidget {
  @override
  _Question createState() => _Question();
}

class _Question extends State<Question> {
  TextEditingController questionTitleController = TextEditingController();
  TextEditingController questionContentController = TextEditingController();

  FocusNode questionContentFocus = FocusNode();

  Provider provider = Provider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            '질문건의',
            style: TextStyle(
                color: black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          centerTitle: true,
          elevation: 0.5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    '내일 아침 오늘의 투표에 올라오길\n바라는 잘문을 건의해 주세요.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: black),
                  ),
                ),
                whiteSpaceH(8),
                Text(
                  "※ 채택 시 스타벅스커피 기프티콘을 드립니다.\n(중복 질문 시 선착순 지급)",
                  style: TextStyle(color: Color(0xFF00AAFF), fontSize: 12),
                ),
                whiteSpaceH(45),
                TextFormField(
                  controller: questionTitleController,
                  style: textStyle,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(questionContentFocus);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    labelText: "질문 제목",
                    labelStyle: labelStyle,
                    focusedBorder: textFormBorder,
                  ),
                  cursorColor: mainColor,
                ),
                whiteSpaceH(48),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: questionContentFocus.hasFocus ? mainColor : Color(0xFFDDDDEE)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: questionContentController,
                    focusNode: questionContentFocus,
                    style: textStyle,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: "질문 내용",
                      labelStyle: labelStyle,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none
                    ),
                    cursorColor: mainColor,
                  ),
                ),
                whiteSpaceH(32),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      provider.questionAdd({
                        'email': dataSave.email,
                        'title': questionTitleController.text,
                        'content': questionContentController.text,
                        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        'type': '신규'
                      }).then((value) {
                        if (value == 1) {
                          showToast("정상적으로 건의되었습니다.");
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    color: mainColor,
                    elevation: 0.0,
                    child: Container(
                      child: Center(
                        child: Text(
                          '제출하기',
                          style: TextStyle(
                              fontSize: 15,
                              color: white,
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
}
