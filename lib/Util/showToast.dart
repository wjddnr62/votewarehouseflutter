import 'package:fluttertoast/fluttertoast.dart';
import 'package:votewarehouse/Public/color.dart';

showToast(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: mainColor,
      textColor: black,
      fontSize: 14);
}