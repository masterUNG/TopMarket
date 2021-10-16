// import 'dart:async';
// import 'dart:convert';

// import 'package:intl/intl.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/bodys/home_day.dart';
import 'package:topmaket/bodys/home_month.dart';
import 'package:topmaket/bodys/home_year.dart';
import 'package:topmaket/utility/my_application.dart';
import 'package:topmaket/utility/my_constant.dart';
// import 'package:topmaket/models/all_price_model.dart';
// import 'package:topmaket/models/smoke.dart';
// import 'package:topmaket/utility/my_constant.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  //String _CLIENT_ID = "147";
  //MyApplication myApplication = new MyApplication(); 

  //_Home2State({Key? key}) : super(key: key);
  //--
  //int currentSelectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        onTap: (int tabIndex) {

          
//--
          switch (tabIndex) {
            case 0:
              MyConstant.currentSelectedPageIndex = 0;
              
              break;

            case 1:
              MyConstant.currentSelectedPageIndex = 1;
              // this.titleInfo = "ยอดขายทุกสาขาเดือนนี้";
              break;

            case 2:
              MyConstant.currentSelectedPageIndex = 2;
              //this.titleInfo = "ยอดขายทุกสาขาปีนี้";
              break;
          }

          this.setState(() {
            //--
          });
        },
        currentIndex: MyConstant.currentSelectedPageIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "วันนี้"),
          new BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_month), label: "เดือนนี้"),
          new BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_week), label: "ปีนี้"),
        ],
      ),
      body: SafeArea(child: buildHomePageByIndex()),
      //body: new HomeDay(),
    );
  }


HomeDay? homeDay;
HomeMonth? homeMonth;
HomeYear? homeYear; 
  dynamic buildHomePageByIndex() {
    //print("buildHomePageByIndex : " + this.currentSelectedPage.toString());
    switch (MyConstant.currentSelectedPageIndex) {
      case 0:
        if(this.homeDay == null) {
          //print("**************** create new HomeDay()**************");
          this.homeDay = new HomeDay();
        }
        return this.homeDay;
      case 1:
      if(this.homeMonth == null) {
           //print("*************** create new HomeMonth() ******************");
          this.homeMonth = new HomeMonth();
        }
        return  this.homeMonth;
      case 2:
      if(this.homeYear == null) {
           //print("******************* create new HomeYear() **********************");
          this.homeYear = new HomeYear();
        }
        return this.homeYear;
    }
  }

//----- fucntion

}
