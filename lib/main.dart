import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votewarehouse/Public/color.dart';
import 'dart:async';

import 'Home/tabSelect.dart';
import 'Provider/provider.dart';

void main() {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  runApp(MaterialApp(
    home: Splash(),
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
  ));
}

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  startTime(type) async {
    var _duration = new Duration(seconds: type == 0 ? 0 : 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => TabSelect(0)));
  }

  SharedPreferences prefs;
  Provider provider = Provider();
  FirebaseMessaging _fcm = FirebaseMessaging();
  bool loading = false;

  loginCheck() async {
    setState(() {
      loading = true;
    });

    prefs = await SharedPreferences.getInstance();

    if (prefs.get("email") != null && prefs.get("email") != "") {
      await provider.login(
          prefs.get("email"), prefs.get("pass"), await _fcm.getToken());

      setState(() {
        loading = false;
      });
      startTime(0);
    } else {
      startTime(1);
    }
  }

  @override
  void initState() {
    super.initState();

    loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF070506),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icon/votehouse_logo.png",
                    width: 96,
                    height: 96,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  child: Image.asset(
                    "assets/icon/searchresearch_logo.png",
                    width: 100,
                    height: 50,
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                    fit: BoxFit.contain,
                  ),
                  bottom: 10,
                  left: 0,
                  right: 0,
                )
              ],
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
