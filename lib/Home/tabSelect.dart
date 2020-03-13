import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:votewarehouse/Public/color.dart';
import 'package:votewarehouse/Util/showToast.dart';

import 'eventPage.dart';
import 'homePage.dart';
import 'menuPage.dart';

// ignore: must_be_immutable
class TabSelect extends StatefulWidget {
  int pageCount;

  TabSelect(this.pageCount);

  @override
  _TabSelect createState() => _TabSelect();
}

class _TabSelect extends State<TabSelect> {
  DateTime currentBackPressTime;

  List bottomPage = [HomePage(), EventPage(), MenuPage()];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme.of(context).platform == TargetPlatform.iOS
          ? bottomPage[widget.pageCount]
          : WillPopScope(
              onWillPop: _onPop, child: bottomPage[widget.pageCount]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        currentIndex: widget.pageCount,
        onTap: selectionCheck,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        selectedItemColor: mainColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icon/home_bk.png",
              width: 24,
              height: 24,
            ),
            title: Text('홈'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icon/list_bk.png",
              width: 24,
              height: 24,
            ),
            title: Text('추첨현황'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icon/ham_menu_bk.png",
              width: 24,
              height: 24,
            ),
            title: Text('전체'),
          ),
        ],
      ),
    );
  }

  void selectionCheck(int value) {
    setState(() {
      widget.pageCount = value;
    });
  }

  Future<bool> _onPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast('다시 누르면 앱을 종료합니다');

      return Future.value(false);
    }

    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
