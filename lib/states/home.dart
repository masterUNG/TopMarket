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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('en');
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.getAllPrice();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => doSetState());

    //this.getAllData();
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("รายชื่อร้าน"),
        // ),
        body: SafeArea(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            buildSummarySaleTotalPrice(),
            buildSummarySaleList(),
          ],
        ),
      ),
    ));
  }

  Column buildSummarySaleTotalPrice() {
    return Column(
      children: [
        Text(
          "ยอดขายทุกสาขาวันนี้",
          style: TextStyle(color: Colors.redAccent[200]),
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
                        color: Colors.redAccent[200],
                        fontSize: 32,
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
                    color: Colors.redAccent[200],
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              );
            }
          },
        )
      ],
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
              //timer = Timer.periodic(Duration(seconds: 5), (Timer t) => doSetState());
              return createSmokeListView();
            } else {

               print("data == 0 "); 
              return Column(

                children: [
                  LinearProgressIndicator(),
                  createSmokeListView(),
                ],
              );
            }
          } else {
            //-- รอ
               print("has no data"); 
            return Column(
              children: [
                LinearProgressIndicator(),
                createSmokeListView(),
              ],
            );
          }
        },
      ),
    );
  }

  ListView createSmokeListView() {
    return ListView.builder(
      //itemCount:snapData.data.
      itemCount: this.smokeModel.length,
      itemBuilder: (context, index) {
        //print("item builder...");
        //return Text(smokeModel[index].name.toString());
        SmokeModel s = smokeModel[index];
        return GestureDetector(
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
                      color: Colors.cyan[400],
                    ),
                    //color: Colors.redAccent[200],
                    width: 220,
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
                              color: Colors.cyan[400],
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

  Future<List<SmokeModel>> getAllData() async {
    //print("getAllData function...");
    String url = "http://119.59.116.70/flutter/smoke.php";

    //- ใช้ object Dio  ในการ getข้อมูลจาก Server
    Dio().get(url).then(
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
    String url = MyConstant.apiDomainName.toString()+ "/flutter/allprice.php";

    //- ใช้ object Dio  ในการ getข้อมูลจาก Server
    Dio().get(url).then(
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
