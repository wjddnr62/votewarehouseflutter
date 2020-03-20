import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:votewarehouse/Model/banner.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/whiteSpace.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPage createState() => _EventPage();
}

class _EventPage extends State<EventPage> {
  AppBar appBar;
  bool loading = false;
  List<BannerData> banners = List();

  getEventBanner() async {
    setState(() {
      loading = true;
    });

    QuerySnapshot eventQuery =
        await Firestore.instance.collection("event").getDocuments();

    if (eventQuery.documents.length != 0) {
      for (int i = 0; i < eventQuery.documents.length; i++) {
        banners.add(BannerData(
            image: eventQuery.documents[i].data['image'],
            url: eventQuery.documents[i].data['url']));
      }

      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getEventBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: appBar = AppBar(
          elevation: 1,
          title: Text(
            '이벤트',
            style: TextStyle(
                color: black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
          ),
        ),
        body: !loading
            ? SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  itemBuilder: (context, idx) {
                    if (banners.length == 0) {
                      return Container();
                    } else {
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              launch(banners[idx].url);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 116,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6)),
                              child: Image.network(
                                banners[idx].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          whiteSpaceH(16)
                        ],
                      );
                    }
                  },
                  shrinkWrap: true,
                  itemCount: banners.length,
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    appBar.preferredSize.height,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                  ),
                ),
              ));
  }
}
