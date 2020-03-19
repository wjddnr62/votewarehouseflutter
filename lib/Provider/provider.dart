import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votewarehouse/Model/infomation.dart';
import 'package:votewarehouse/Model/user.dart';
import 'package:votewarehouse/Model/voteResult.dart';
import 'package:votewarehouse/Util/dataSava.dart';

class Provider {
  SharedPreferences shared;

  Future<int> addUsers(userData) async {
    await Firestore.instance.collection("users").add(userData).then((value) {
      return 1;
    }).catchError((error) {
      return 0;
    });

    return 1;
  }

  Future<int> questionAdd(questionData) async {
    await Firestore.instance.collection("suggestion").add(questionData);

    return 1;
  }

  Future<int> addInfomation(infoMation, email) async {
    CollectionReference userCollection = Firestore.instance.collection("users");
    QuerySnapshot userQuery =
        await userCollection.where('email', isEqualTo: email).getDocuments();

    await Firestore.instance
        .collection("infomation")
        .add(infoMation)
        .then((value) {

      return 1;
    }).catchError((error) {
      return 0;
    });

    await Firestore.instance
        .collection("users")
        .document(userQuery.documents[0].documentID)
        .updateData({'addInfomation': true});

    return 1;
  }

  Future<int> updateInfomation(Infomation infomation) async {
    CollectionReference infoCollection =
        Firestore.instance.collection("infomation");
    QuerySnapshot infoQuery = await infoCollection
        .where("email", isEqualTo: dataSave.email)
        .getDocuments();

    CollectionReference userCollection = Firestore.instance.collection("users");
    QuerySnapshot userQuery = await userCollection
        .where('email', isEqualTo: dataSave.email)
        .getDocuments();

    if (infoQuery.documents.length == 0) {

      addInfomation({
        'car': infomation.car,
        'email': infomation.email,
        'family': infomation.family,
        'familyMoney': infomation.familyMoney,
        'house': infomation.house,
        'houseLiving': infomation.houseLiving,
        'job': infomation.job,
        'marriage': infomation.marriage,
        'myMoney': infomation.myMoney,
        'phoneAgency': infomation.phoneAgency,
        'politics': infomation.politics,
        'school': infomation.school
      }, dataSave.email);

      dataSave.infoMation = Infomation(
          email: infomation.email,
          car: infomation.car,
          family: infomation.family,
          familyMoney:  infomation.familyMoney,
          house: infomation.house,
          houseLiving: infomation.houseLiving,
          job: infomation.job,
          marriage: infomation.marriage,
          myMoney:  infomation.myMoney,
          phoneAgency: infomation.phoneAgency,
          politics: infomation.politics,
          school: infomation.school);

      return 0;
    } else {
      await Firestore.instance
          .collection("infomation")
          .document(infoQuery.documents[0].documentID)
          .updateData({
        'car': infomation.car,
        'email': infomation.email,
        'family': infomation.family,
        'familyMoney': infomation.familyMoney,
        'house': infomation.house,
        'houseLiving': infomation.houseLiving,
        'job': infomation.job,
        'marriage': infomation.marriage,
        'myMoney': infomation.myMoney,
        'phoneAgency': infomation.phoneAgency,
        'politics': infomation.politics,
        'school': infomation.school
      });


      await Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .updateData({'addInfomation': true});

      dataSave.infoMation = Infomation(
        email: infomation.email,
        car: infomation.car,
        family: infomation.family,
        familyMoney: infomation.familyMoney,
        house: infomation.house,
        houseLiving: infomation.houseLiving,
        job: infomation.job,
        marriage: infomation.marriage,
        myMoney: infomation.myMoney,
        phoneAgency: infomation.phoneAgency,
        politics: infomation.politics,
        school: infomation.school,
      );

      return 1;
    }
  }

  Future<int> idDuplicate(id) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("email", isEqualTo: id).getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<int> phoneDuplicate(phone) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("phone", isEqualTo: phone).getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<String> findId(phone) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("phone", isEqualTo: phone).getDocuments();

    if (userQuery.documents.length == 0) {
      return "";
    } else {
      return userQuery.documents[0].data['email'];
    }
  }

  Future<int> findPass(email, phone) async {
    print("email : " + email);
    print("phone : " + phone);
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery = await userCollection
        .where("email", isEqualTo: email)
        .where("phone", isEqualTo: phone)
        .getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<int> login(email, pass, token) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery = await userCollection
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: pass)
        .getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      await Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .updateData({'token': token});

      dataSave.email = userQuery.documents[0].data['email'];
      dataSave.user = User(
          email: userQuery.documents[0].data['email'],
          pass: userQuery.documents[0].data['password'],
          gender: userQuery.documents[0].data['gender'],
          address: userQuery.documents[0].data['address'],
          age: userQuery.documents[0].data['age'],
          phone: userQuery.documents[0].data['phone'],
          token: userQuery.documents[0].data['token'],
          push: userQuery.documents[0].data['push'],
          addInfomation: userQuery.documents[0].data['addInfomation']);

      if (userQuery.documents[0].data['addInfomation']) {
        CollectionReference infoCollection =
            Firestore.instance.collection("infomation");

        QuerySnapshot infoQuery = await infoCollection
            .where("email", isEqualTo: email)
            .getDocuments();

        dataSave.infoMation = Infomation(
            email: infoQuery.documents[0].data['email'],
            car: infoQuery.documents[0].data['car'],
            family: infoQuery.documents[0].data['family'],
            familyMoney: infoQuery.documents[0].data['familyMoney'],
            house: infoQuery.documents[0].data['house'],
            houseLiving: infoQuery.documents[0].data['houseLiving'],
            job: infoQuery.documents[0].data['job'],
            marriage: infoQuery.documents[0].data['marriage'],
            myMoney: infoQuery.documents[0].data['myMoney'],
            phoneAgency: infoQuery.documents[0].data['phoneAgency'],
            politics: infoQuery.documents[0].data['politics'],
            school: infoQuery.documents[0].data['school']);
      }

      return 1;
    }
  }

  Future<int> authFindPassChange(password, email) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("email", isEqualTo: email).getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      await Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .updateData({'password': password});

      return 1;
    }
  }

  Future<int> passChange(password) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery = await userCollection
        .where("email", isEqualTo: dataSave.email)
        .getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      await Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .updateData({'password': password});

      return 1;
    }
  }

  pushUpdate(email, push) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("email", isEqualTo: email).getDocuments();

    if (userQuery.documents.length != 0) {
      await Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .updateData({'push': push});
    }
  }

  Future<int> withdrawalUser(email) async {
    CollectionReference userCollection = Firestore.instance.collection("users");
    CollectionReference infoCollection =
        Firestore.instance.collection("infomation");

    QuerySnapshot userQuery =
        await userCollection.where("email", isEqualTo: email).getDocuments();

    QuerySnapshot infoQuery =
        await infoCollection.where("email", isEqualTo: email).getDocuments();

    if (infoQuery.documents.length != 0) {
      await Firestore.instance
          .collection("infomation")
          .document(infoQuery.documents[0].documentID)
          .delete();
    }

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      await Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .delete();

      shared = await SharedPreferences.getInstance();

      await shared.clear();

      dataSave.email = null;
      dataSave.user = null;

      return 1;
    }
  }

  Future<int> changeRequiredInfomation(gender, age, address) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery = await userCollection
        .where("email", isEqualTo: dataSave.email)
        .getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      await Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .updateData({'gender': gender, 'age': age, 'address': address});

      return 1;
    }
  }

  Future<int> voteResult(List<VoteResult> voteResult) async {
    CollectionReference voteCollection =
        Firestore.instance.collection("voteResult");

    for (int i = 0; i < voteResult.length; i++) {
      await voteCollection
          .document(voteResult[i].date)
          .collection(voteResult[i].question)
          .document(voteResult[i].title)
          .collection(dataSave.email)
          .add({'answer': voteResult[i].answer, 'idx':voteResult[i].idx});

      await voteCollection
          .document(voteResult[i].date)
          .collection(voteResult[i].question)
          .document(voteResult[i].title)
          .setData({"1": "1"});
    }

    QuerySnapshot existsCheck = await voteCollection.document(voteResult[0].date).collection("email").getDocuments();
    DocumentSnapshot documentSnapshot = await voteCollection.document(voteResult[0].date).get();
    int index = 1;
    if (existsCheck.documents.length != 0) {
      index = documentSnapshot.data['index'];
    }

    await voteCollection
        .document(voteResult[0].date)
        .setData({'date': voteResult[0].date, 'index': index});

    await voteCollection.document(voteResult[0].date).collection("email").add({'email': dataSave.email});

    return 1;
  }

  Future<int> voteCheck() async {
    CollectionReference voteCollection =
        Firestore.instance.collection("voteResult");

    String nowDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    QuerySnapshot voteQuery = await voteCollection
        .document(nowDate)
        .collection("email")
        .where("email", isEqualTo: dataSave.email)
        .getDocuments();

    if (voteQuery.documents.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<List<double>> voteCount(question, title) async {
    CollectionReference voteCollection =
        Firestore.instance.collection("voteResult");
    CollectionReference voteListCollection =
        Firestore.instance.collection("voteList");

    String nowDate = DateFormat("yyyy-MM-dd").format(DateTime.now());


    DocumentSnapshot voteQuery = await voteCollection.document(nowDate).get();
    QuerySnapshot voteEmail = await voteCollection.document(nowDate).collection('email').getDocuments();

    QuerySnapshot voteCountQuery = await voteListCollection
        .document(nowDate)
        .collection(question)
        .getDocuments();

    int allPersonCount = voteQuery.data['index'];

    int answerCount = voteCountQuery.documents[0].data['answer'].length;

    List<String> email = List();
    List<int> answerCountList = List();

    for (int i = 0; i < voteQuery.data['index']; i++) {
      email.add(voteEmail.documents[i].data['email']);
    }
    for (int i = 0; i < email.length; i++) {
      await voteCollection
          .document(nowDate)
          .collection(question)
          .document(title)
          .collection(email[i])
          .getDocuments()
          .then((value) {
        answerCountList.add(value.documents[0].data['idx']);
      });
    }

    List<double> finalCount = List();

    for (int i = 0; i < answerCount; i++) {
      int count = 0;
      for (int j = 0; j < answerCountList.length; j++) {
        if (answerCountList[j] == i) {
          count++;
        }
      }
      finalCount.add(count / allPersonCount * 100);
    }

    return finalCount;
  }

  Future<int> checkAnswer(question, title) async {
    String nowDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    CollectionReference voteCollection =
        Firestore.instance.collection("voteResult");

    QuerySnapshot voteQuery = await voteCollection
        .document(nowDate)
        .collection(question)
        .document(title)
        .collection(dataSave.email)
        .getDocuments();

    return voteQuery.documents[0].data['idx'];
  }

  Future<List<double>> politicsCount() async {
    String nowDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    CollectionReference politicsCollection =
        Firestore.instance.collection("politics");

    QuerySnapshot politicsQuery = await politicsCollection.getDocuments();

    List<String> politics = List();

    CollectionReference voteCollection =
        Firestore.instance.collection("voteResult");

    QuerySnapshot voteQuery = await voteCollection
        .document(nowDate)
        .collection("politics")
        .getDocuments();

    int personCount = voteQuery.documents.length;

    int answerCount = politicsQuery.documents[0].data['politics'].length;

    List<String> answerCountList = List();

    for (int i = 0;
        i < politicsQuery.documents[0].data['politics'].length;
        i++) {
      politics.add(politicsQuery.documents[0].data['politics'][i]);
    }

    await voteCollection
        .document(nowDate)
        .collection("politics")
        .getDocuments()
        .then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        answerCountList.add(value.documents[i].data['selectPolitics']);
      }
    });

    List<double> finalCount = List();

    for (int i = 0; i < answerCount; i++) {
      int count = 0;
      for (int j = 0; j < answerCountList.length; j++) {
//        print(answerCountList[j] + ", " + politics[i]);
        if (answerCountList[j] == politics[i]) {
          count++;
        }
      }
      finalCount.add(count / personCount * 100);
    }

    return finalCount;
  }
}
