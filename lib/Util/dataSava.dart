import 'package:votewarehouse/Model/user.dart';
import 'package:votewarehouse/Model/infomation.dart';

class DataSave {
  static final DataSave _dataSave = DataSave._internal();

  factory DataSave(){
    return _dataSave;
  }

  DataSave._internal();

  String _email;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  User _user;

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  Infomation _infoMation;

  Infomation get infoMation => _infoMation;

  set infoMation(Infomation value) {
    _infoMation = value;
  }


}

final dataSave = DataSave();