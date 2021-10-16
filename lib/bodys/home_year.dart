import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/smoke.dart';
import 'package:topmaket/models/all_price_model.dart';
import 'package:intl/intl.dart';
import 'package:topmaket/states/sale.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_page.dart';

class HomeYear extends StatefulWidget {
  const HomeYear({Key? key}) : super(key: key);

  @override
  _HomeYearState createState() => _HomeYearState();
}

class _HomeYearState extends State<HomeYear> {
  double saleSummaryHeadFontSize = 40;
  double listViewClentNameSize = 170;

  NumberFormat numberFormat = NumberFormat.decimalPattern('en');

  @override
  Widget build(BuildContext context) {
    print("in home day in build...");
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/appbg1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            buildSummarySaleTotalPrice(),
            buildSummarySaleList(),
          ],
        ),
      ),
    );
  }

  //--- all funtion

  Container buildSummarySaleTotalPrice() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "ยอดขายทุกสาขาปีนี้",
            style: TextStyle(color: Colors.green[200]),
          ),
          FutureBuilder(
            future: this.getAllPrice(),
            initialData: "0.00",
            builder: (BuildContext context, AsyncSnapshot snapData) {
              //print("future builder...sumprice");

              //String allPrice = this.sumPriceModel.sumprice;
              if (snapData.hasData) {
                //print("has data = "+this.sumFinalPrice.toString());
                //print("Has data ");
                return Container(
                  //color: Colors.black,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Card(
                    child: Text(
                      this.sumFinalPrice.toString()
                      //Int32 _price = Int32.parse( this.sumFinalPrice.toString());
                      //formatter2.format(1234567)
                      //formatter2.format(int.parse( this.sumFinalPrice.toString()))
                      , //-- ยอดรวมทั้งหมด
                      style: TextStyle(
                          color: Colors.greenAccent[200],
                          fontSize: this.saleSummaryHeadFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              } else {
                //print("no data = "+this.sumFinalPrice.toString());
                String value = this
                            .sumFinalPrice
                            .toString()
                            .toUpperCase()
                            .compareTo("NULL") ==
                        0
                    ? "0.00"
                    : this.sumFinalPrice.toString();
                return Text(
                  value
                  //Int32 _price = Int32.parse( this.sumFinalPrice.toString());
                  //formatter2.format(1234567)
                  //formatter2.format(int.parse( this.sumFinalPrice.toString()))
                  , //-- ยอดรวมทั้งหมด
                  style: TextStyle(
                      color: Colors.greenAccent[700],
                      fontSize: this.saleSummaryHeadFontSize,
                      fontWeight: FontWeight.bold),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Expanded buildSummarySaleList() {
    return Expanded(
      child: FutureBuilder(
        //-- function ที่จะทำการดึงข้อมูล และจะคืนมาใน อนาคต หรือไม่รู้ว่าจะคืน มาเมือไหร่
        future: this.getAllData(),
        //-- function ที่จะทำหลังจากได้ข้อมูล
        builder: (context, snapData) {
          if (snapData.hasData) {
            if (smokeModel.length > 0) {
              print("data > 0");
              try {
                this.smokeModelTemp = this.smokeModel;
                return createSmokeListView(this.smokeModelTemp);
              } catch (Ex) {
                return this.createSmokeListView(this.smokeModelTemp);
              }
            } else {
              print("data == 0 ");
              return Column(
                children: [
                  LinearProgressIndicator(
                    color: Colors.green[400],
                    backgroundColor: Colors.green[100],
                  ),
                  //print("show Temp smoke model...");
                  this.createSmokeListView(this.smokeModelTemp),
                ],
              );
            }
          } else {
            //-- รอ
            print("has no data");
            return Column(
              children: [
                LinearProgressIndicator(
                  color: Colors.brown[300],
                  backgroundColor: Colors.brown[100],
                ),
                createSmokeListView(this.smokeModelTemp),
              ],
            );
          }
        },
      ),
    );
  }

  ListView createSmokeListView(List<SmokeModel> smokeModelToShow) {
    return ListView.builder(
      //itemCount:snapData.data.
      itemCount: this.smokeModel.length,
      itemBuilder: (context, index) {
        //print("item builder...");
        //return Text(smokeModel[index].name.toString());
        SmokeModel s = smokeModelToShow[index];
        return GestureDetector(
//           onHorizontalDragEnd: (DragEndDetails drag) {
// print("velocity : "+drag.velocity.toString()); 
// print("primaryVelocity : "+drag.primaryVelocity.toString()); 
//           },
          onPanEnd: (DragEndDetails drag) {
print("velocity : "+drag.velocity.toString()); 
print("primaryVelocity : "+drag.primaryVelocity.toString()); 
          },
          onTap: () {
            //print("Tab");
            //-- เรียกหน้า รายละเอียดการขาย
            MyConstant.currentClientID = s.id.toString();
            MyConstant.currentClientName = s.name.toString();

            //-- เรียกหน้า รายการขาย
            // Navigator.pushNamed(
            //     context, MyConstant.routerClientSale);
            //-- เปลี่ยนมาเรียก หน้า workpoint
            Navigator.pushNamed(context, MyConstant.routeClientHome);

            //Navigator.push(context, MyPage.ClientHomePage);
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Card(
              child: Row(
                children: [
                  Container(
                    //alignment: AlignmentGeometry(),

                    decoration:
                        //BoxDecoration(color: Colors.red[300]),
                        BoxDecoration(
                      color: Colors.green[400],
                    ),
                    //color: Colors.redAccent[200],
                    width: this.listViewClentNameSize,
                    height: 80,
                    child: Text(
                      s.name.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    //height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          //"" + double.parse( numberFormat.format(double.parse(s.price.toString()) )).toString(),
                          s.getPriceForrmated(),
                          style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "บิลล่าสุด " + s.lastbilltime.toString(),
                          style: TextStyle(fontSize: 8),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//-- การประกาศ List
  SumPriceModel sumPriceModel = new SumPriceModel();
  List<SmokeModel> smokeModel = [];
  List<SmokeModel> smokeModelTemp = [];

  Future<List<SmokeModel>> getAllData() async {
    print("getAllData function...");
    String url = MyConstant.apiDomainName.toString() +
        "/smoke_year.php?client=" +
        MyConstant.currentHeadClientID.toString();

    print(url);
    //- ใช้ object Dio  ในการ getข้อมูลจาก Server
    await Dio().get(url).then(
      //-- เมือทำงานเสร็จแ้วจ คืนมาเปน value
      (value) {
        //-- convert คืน ให้มาเป็น json
        var jsonData = json.decode(value.data);

        //-- วนลูป
        this.smokeModel.clear();
        for (var item in jsonData) {
          SmokeModel smoke = SmokeModel.fromMap(item);
          smokeModel.add(smoke);
          //print(smoke.toString());
        }
        return smokeModel;
      },
    );

    return [];
  }

  NumberFormat formatter = NumberFormat('#,###,0.00');
  NumberFormat formatter2 = NumberFormat.decimalPattern('en');
  String? sumFinalPrice;
  Future<void> getAllPrice() async {
    //print("getAllData function...");
    String url = MyConstant.apiDomainName.toString() +
        "/allprice_year.php?client=" +
        MyConstant.currentHeadClientID.toString();
    print(url);
    //- ใช้ object Dio  ในการ getข้อมูลจาก Server
    await Dio().get(url).then(
      //-- เมือทำงานเสร็จแ้วจ คืนมาเปน value
      (value) {
        //-- convert คืน ให้มาเป็น json
        var jsonData = json.decode(value.data);

        //-- วนลูป
        this.smokeModel.clear();
        for (var item in jsonData) {
          this.sumPriceModel = SumPriceModel.fromMap(item);
          //Rprint( this.sumPriceModel.toString());

          this.sumFinalPrice = this.sumPriceModel.sumprice.toString();

          double val = double.parse(this.sumPriceModel.sumprice.toString());
          this.sumFinalPrice = formatter2.format(val);

          //print("ตัวอย่าง การ format : "+NumberFormat.simpleCurrency(name: '').format(val));
          //print( "ยอดขายดทั้งหมด "+formatter2.format(val));
          //String v = this.sumPriceModel.sumprice.toString();
          break;
        }
        //return smokeModel;
      },
    );

    //return [];
  }
}
