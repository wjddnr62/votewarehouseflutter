import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'Home/tabSelect.dart';
import 'Provider/provider.dart';

void main() {
  FirebaseAnalytics analytics = FirebaseAnalytics();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    ));
  });

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

  navigationPage() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => TabSelect(0)));
  }

  SharedPreferences prefs;
  Provider provider = Provider();
  FirebaseMessaging _fcm = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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

  Future showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', '알림', ' 투표창고 알림',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  printText() {
    print("select");
  }

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('votehouse_logo');
    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: printText());

    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      showNotification(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      showNotification(message);
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      showNotification(message);
    });

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
//          loading
//              ? Center(
//                  child: CircularProgressIndicator(
//                    valueColor: AlwaysStoppedAnimation<Color>(mainColor),
//                  ),
//                )
//              : Container()
        ],
      ),
    );
  }
}
