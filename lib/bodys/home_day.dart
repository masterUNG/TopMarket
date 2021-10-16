import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_stat_sale_date.dart';
import 'package:topmaket/models/smoke.dart';
import 'package:topmaket/models/all_price_model.dart';
import 'package:intl/intl.dart';
//import 'package:topmaket/states/sale.dart';
import 'package:topmaket/utility/my_constant.dart';
//import 'package:topmaket/utility/my_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class HomeDay extends StatefulWidget {
  const HomeDay({Key? key}) : super(key: key);

  @override
  _HomeDayState createState() => _HomeDayState();
}

class _HomeDayState extends State<HomeDay> {
  double saleSummaryHeadFontSize = 40;
  double listViewClentNameSize = 170;

  NumberFormat numberFormat = NumberFormat.decimalPattern('en');
  Timer? timer;
  @override
  void initState() {
    super.initState();

    this.timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => doSetState());
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //print("in home day in build...");
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/authenbg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            buildSummarySaleTotalPrice(),
            buildSummarySaleList(),

            //  SfCartesianChart(

            //      // Initialize category axis
            //      primaryXAxis: CategoryAxis(),
            //      series: <ChartSeries>[
            //        // Initialize line series
            //        LineSeries<ClientStatSaleDate, String>(
            //          dataSource: clientStatSaleDate,
            //          xValueMapper: (ClientStatSaleDate sales, _) => sales.date,
            //          yValueMapper: (ClientStatSaleDate sales, _) => sales.sale,
            //          //dataLabelSettings: new DataLabelSettings(isVisible: true),
            //        )
            //      ]),
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
//-- ใส่ Charts

          Text(
            "ยอดขายทุกสาขาวันนี้",
            style: TextStyle(color: Colors.redAccent[200]),
          ),
          FutureBuilder(
            future: this.getAllPrice(),
            initialData: "0.00",
            builder: (BuildContext context, AsyncSnapshot snapData) {
              //print("future builder...sumprice");

              String allPrice = this.sumPriceModel.sumprice;
              //print("snapData.hasData ="+snapData.hasData.toString());
              if (snapData.hasData) {
                //print("has data = "+this.sumFinalPrice.toString());
                //print("Has data ");
                return Container(
                  //color: Colors.black,
                  // width: MediaQuery.of(context).size.width,
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
                      color: Colors.redAccent[200],
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
              print("smokeModel.length > 0");
              //timer = Timer.periodic(Duration(seconds: 5), (Timer t) => doSetState());
              return createSmokeListView();
            } else {
              print("else");
              return Column(
                children: [
                  LinearProgressIndicator(
                    color: Colors.brown[300],
                    backgroundColor: Colors.brown[100],
                  ),
                  createSmokeListView(),
                ],
              );
            }
          } else {
            //-- รอ
            print("has no data");
            return Text(
              "ไม่พบข้อมูลการขายของวันนี้",
              style:
                  MyTextStyle.getTextStyleWhiteTitleText(color: Colors.black54),
            );
            // Column(
            //   children: [
            //     LinearProgressIndicator(
            //       color: Colors.brown,
            //       backgroundColor: Colors.brown[100],
            //     ),
            //     createSmokeListView(),
            //   ],
            // );
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
          onTap: () async {
            //print("Tab");
            //-- เรียกหน้า รายละเอียดการขาย
            MyConstant.currentClientID = s.id.toString();
            MyConstant.currentClientName = s.name.toString();
            //MyConstant.currentShopName = ;

            //-- เรียกหน้า รายการขาย
            // Navigator.pushNamed(
            //     context, MyConstant.routerClientSale);
            //-- เปลี่ยนมาเรียก หน้า workpoint
            this.timer!.cancel();
            await Navigator.pushNamed(context, MyConstant.routeClientHome);
            this.timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => doSetState());

            //Navigator.push(context, MyPage.ClientHomePage);
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration:
                        //BoxDecoration(color: Colors.red[300]),
                        BoxDecoration(
                      color: Colors.redAccent[400],
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
                              color: Colors.redAccent[400],
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "บิลล่าสุด " + s.lastbilltime.toString(),
                          style: TextStyle(fontSize: 8, color: Colors.grey),
                        ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.person_add_outlined),
                        //      Text(
                        //   "บิลล่าสุด " + s.e.toString(),
                        //   style: TextStyle(fontSize: 8, color: Colors.grey),
                        // ),
                        //   ],
                        // )
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
    String url = MyConstant.apiDomainName.toString() +
        "/smoke_day.php?client=" +
        MyConstant.currentHeadClientID.toString();
    //     String url = MyConstant.apiDomainName.toString() +
    // "/smoke_day.php?client=147";

    print("Smoke Day => " + url);
    //- ใช้ object Dio  ในการ getข้อมูลจาก Server

    //-- ก่อนดหลด ให้ หยดเวลาไว้ก่อน
    // this.timer!.cancel();
    // print("cancel time");
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

        ///--- โหลดเสร็จ ก็ให้เริ่มนับเวลาใหม่
        ///
        ///
        // print("Start time...");
        // this.timer =
        //     Timer.periodic(Duration(seconds: 5), (Timer t) => doSetState());
        return smokeModel;
      },
    );

    return [];
  }

  NumberFormat formatter = NumberFormat('#,###,0.00');
  NumberFormat formatter2 = NumberFormat.decimalPattern('en');

  String? sumFinalPrice;
  List<ClientStatSaleDate> clientStatSaleDate = [];
  Future<void> getAllPrice() async {
    //print("getAllData function...");
    String url = MyConstant.apiDomainName.toString() +
        "/allprice_day.php?client=" +
        MyConstant.currentHeadClientID.toString();

    //     String url = MyConstant.apiDomainName.toString() +
    // "/allprice_day.php?client=147";

    print("Price Day => " + url);
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

          return this.sumFinalPrice;

          //print("ตัวอย่าง การ format : "+NumberFormat.simpleCurrency(name: '').format(val));
          //print( "ยอดขายดทั้งหมด "+formatter2.format(val));
          //String v = this.sumPriceModel.sumprice.toString();
          break;
        }

        //return smokeModel;
      },
    );

    // //-- get stat
    // String urlStat = MyConstant.apiDomainName.toString() +
    //     "/stat/sale_stat_date.php?client=" +
    //     MyConstant.currentClientID.toString();
    // Dio().get(urlStat).then((value) {
    //   //--
    //   clientStatSaleDate.clear();
    //   var items = json.decode(value.data);

    //   for (var item in items) {
    //     this.clientStatSaleDate.add(ClientStatSaleDate.fromMap(item));
    //   }
    // });

    //return [];
  }
}
