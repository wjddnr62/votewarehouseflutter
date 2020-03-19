import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:votewarehouse/Home/tabSelect.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';
import '../Public/color.dart';
import 'lotteryStatusDetail.dart';

class LotteryStatus extends StatefulWidget {
  @override
  _LotteryStatus createState() => _LotteryStatus();
}

class _LotteryStatus extends State<LotteryStatus> {
  String nowDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TabSelect(0)
        ));
        return null;
      },
      child: Scaffold(
          appBar: appBar = AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TabSelect(0)
                ));
              },
              icon: Icon(Icons.arrow_back_ios, color: black,),
            ),
            title: Text(
              '추첨현황',
              style: TextStyle(
                  color: black, fontSize: 15, fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.white,
            elevation: 0.5,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection("drawResult").orderBy('startDate', descending: true)
                    .where('startDate', isLessThanOrEqualTo: nowDate)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBar.preferredSize.height,
                      child: ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 64,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LotteryStatusDetail(
                                                  documentId: document.documentID,
                                                  startDate: document['startDate'],
                                                  endDate: document['endDate'],
                                                )));
                                  },
                                  color: white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide(color: Color(0xFFEEEEFF))),
                                  elevation: 0.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "추첨내역",
                                                style: TextStyle(
                                                    color: Color(0xFFBBBBBB),
                                                    fontSize: 12),
                                              ),
                                              whiteSpaceH(6),
                                              Text(
                                                document['startDate'] +
                                                    " ~ " +
                                                    document['endDate'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: black,
                                                    fontWeight: FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              whiteSpaceH(16)
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }
}
