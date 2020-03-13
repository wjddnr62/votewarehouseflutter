import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:votewarehouse/Public/color.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPage createState() => _EventPage();
}

class _EventPage extends State<EventPage> {
  String url_search='https://forms.gle/e3y1Jtj2iYxXzTBv5';
  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('이벤트',style: TextStyle(color: black),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              InkWell(
                child: Image.asset('images/1_event.png',fit: BoxFit.cover,),
                onTap: (){
                  url_survey(url_search);
                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/2_event.png',fit: BoxFit.cover,),
                onTap: (){
                  url_survey(url_search);
                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/3_event.png',fit: BoxFit.cover,),
                onTap: (){
                  url_survey(url_search);
                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/4_event.png',fit: BoxFit.cover,),
                onTap: (){
                  url_survey(url_search);
                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/5_event.png',fit: BoxFit.cover,),
                onTap: (){
                  url_survey(url_search);
                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),


            ],
          ),
        ),

      ),


    );
  }




  url_survey(url_1) async {


    url =url_1;

    String Url_temp = Uri.encodeFull(url);

    if (await canLaunch(Url_temp)) {
      await launch(Url_temp);
    } else {
      AlertDialog_text();
      throw 'Could not launch $Url_temp';
    }
  }


  void AlertDialog_text() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('네트워크 상태를 확인해주세요.'),
          content:  Text('네트워크에 연결할 수 없습니다.',softWrap: true,),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child:  Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
