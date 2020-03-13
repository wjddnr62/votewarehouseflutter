import 'package:flutter/material.dart';
import 'Home/tabSelect.dart';
import 'Public/color.dart';

class plainningNews extends StatefulWidget {
  @override
  _plainningNewsState createState() => _plainningNewsState();
}

class _plainningNewsState extends State<plainningNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('기획뉴스',style: TextStyle(fontSize:15,color: black,fontWeight: FontWeight.bold ),),
        leading: IconButton(onPressed: (){tap_page(context);},icon: IconButton(icon: Icon(Icons.arrow_back_ios,color: black,),),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: black
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                child: Image.asset('images/1_plan.png',fit: BoxFit.cover,),
                onTap: (){

                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/2_plan.png',fit: BoxFit.cover,),
                onTap: (){

                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/3_plan.png',fit: BoxFit.cover,),
                onTap: (){

                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/4_plan.png',fit: BoxFit.cover,),
                onTap: (){

                },
              ),
              Padding(padding: const EdgeInsets.only(top: 15),),
              InkWell(
                child: Image.asset('images/5_plan.png',fit: BoxFit.cover,),
                onTap: (){

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void tap_page(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> TabSelect(2)),(Route<dynamic> route) => false);
  }

}
