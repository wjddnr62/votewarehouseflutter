import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';
import 'package:votewarehouse/menu/planningNewsDetail.dart';
import '../Public/color.dart';

class PlanningNews extends StatefulWidget {
  @override
  _PlanningNews createState() => _PlanningNews();
}

class _PlanningNews extends State<PlanningNews> {
  List<String> titleImage = List();
  bool loading = false;
  List<dynamic> imageData = List();

  getImage() async {
    setState(() {
      loading = true;
    });

    QuerySnapshot images =
        await Firestore.instance.collection("planNews").getDocuments();

    if (images.documents.length != 0) {
      for (int i = 0; i < images.documents.length; i++) {
        titleImage.add(images.documents[i].data['titleImage']);
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getImage();
  }

  AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appBar = AppBar(
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
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                loading ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                    ),
                  ),
                ) : ListView.builder(
                  itemBuilder: (context, idx) {
                    return Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 116,
                          child: RaisedButton(
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            onPressed: () async {

                              QuerySnapshot images =
                                  await Firestore.instance.collection("planNews").where("titleImage", isEqualTo: titleImage[idx]).getDocuments();

                              if (images.documents.length != 0) {
                                print("imageData : " + images.documents[0].data['images'].length.toString());
                                  imageData = images.documents[0].data['images'];

                                  print("imageLength : ${imageData.length}");
                              }

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlanningNewsDetail(
                                  imageData: imageData,
                                )
                              ));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                titleImage[idx],
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        whiteSpaceH(16)
                      ],
                    );
                  },
                  itemCount: titleImage.length,
                  shrinkWrap: true,
                )
              ],
            )),
      ),
    );
  }
}
