import 'package:flutter/material.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

class PlanningNewsDetail extends StatefulWidget {
  List<dynamic> imageData;

  PlanningNewsDetail({Key key, this.imageData}) : super(key: key);

  @override
  _PlanningNewsDetail createState() => _PlanningNewsDetail();
}

class _PlanningNewsDetail extends State<PlanningNewsDetail> {

  List<dynamic> imageData;


  @override
  void initState() {
    super.initState();

    this.imageData = widget.imageData;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          '기획뉴스',
          style: TextStyle(
              fontSize: 15, color: black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, idx) {
                return Image.network(
                  imageData[idx],
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                );
              },
              shrinkWrap: true,
              itemCount: imageData.length,
            ),
            whiteSpaceH(20),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Center(
                  child: Text("원할한 의사소통을 위한\n댓글 서비스가 준비중입니다.", style: TextStyle(
                    color: white, fontSize: 15, fontWeight: FontWeight.w600
                  ), textAlign: TextAlign.center,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
