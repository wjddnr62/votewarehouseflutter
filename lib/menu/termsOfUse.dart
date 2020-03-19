import 'package:flutter/material.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Public/text.dart';

class TermsOfUse extends StatefulWidget {
  @override
  _TermsOfUse createState() => _TermsOfUse();

}

class _TermsOfUse extends State<TermsOfUse> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        centerTitle: true,
        title: Text("이용약관", style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 15, color: black
        ),),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(termsOfUseText, style: TextStyle(
                color: black, fontSize: 12
              ),)
            ],
          ),
        ),
      ),
    );
  }

}