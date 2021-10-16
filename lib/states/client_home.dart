import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:topmaket/models/sale_summary_model.dart';
import 'package:topmaket/models/sum_work_point_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_decimal_formatter.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('en');

  Timer? timer;

  String? _clientID;
  String? _clientName;

  @override
  void initState() {
    super.initState();

    this.getSumWorkPointModel();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => doSetState());
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    this._clientID = MyConstant.currentClientID.toString();
    this._clientName = MyConstant.currentClientName.toString();

    return Scaffold(
      drawer: createAppDrawer(context),
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        title: Text("สรุปผลประกอบการวันนี้"),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.home_outlined),
          onPressed: () {
            Navigator.pushNamed(context, MyConstant.routeFutureBuilder);
            //-- todo
          }),
      body: buildWorkPointDay(),
    );
  }

  FutureBuilder<SumWorkPointModel> buildWorkPointDay() {
    return FutureBuilder(
      future: this.getSumWorkPointModel(),
      builder: (context, snapshort) {
        //print("OK");

        //print("workPoint");
        //print("sum work point hasdata... "+snapshort.hasData.toString());
        if (snapshort.hasData) {
          SumWorkPointModel workPoint = this.sumWorkPointModel;

          if (workPoint.saleamount != null) {
            return createSummarySale(context, workPoint);
          } else {
            return Column(
              children: [
                LinearProgressIndicator(
                  color: Colors.brown,
                  backgroundColor: Colors.brown[200],
                ),
                createSummarySale(context, workPoint),
              ],
            );
          }
        } else {
          return new Center(child: new CircularProgressIndicator());
        }
      },
    );
  }

  SingleChildScrollView createSummarySale(
      BuildContext context, SumWorkPointModel workPoint) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyConstant.routerClientSale);
                },
                child: createCardSaleAmount(this.sumWorkPointModel),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, MyConstant.routeClientPayinDetail);
                },
                child: createCardExpensive(workPoint),
              ),
              //--
              createCardReturn(workPoint),
              createCardIncomeRemain(workPoint),
              createCardSentAmount(workPoint),
            ],
          ),
        ),
      ),
    );
  }

  Drawer createAppDrawer(BuildContext context) {
    return new Drawer(
      child: SafeArea(
        child: (Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Programmerhero"),
              accountEmail: Text("salampos@gmail.com"),
              currentAccountPicture: Image.network(
                  "http://119.59.116.70/flutter/get_company_logo.php?client=183"),

              // currentAccountPicture: Image,
            ),
            createDrawMenuSale(),
            createDrawMenuProduct(),
            createDrawMenuStock(),
            createDrawMenuEmployee(),
            createDrawProductBestSale(),
/*
            createDrawProductLot(),
            ListTile(
              leading: Icon(Icons.add_a_photo_sharp),
              title: Text("ตัวอย่าง Text"),
              onTap: () {
                Navigator.pushNamed(context, MyConstant.routeTest);
              },
            )
          */
          ],
        )),
      ),
    );
  }

  Card createCardSaleAmount(SumWorkPointModel workPoint) {
    return Card(
      //color: Colors.red[50],
      child: Container(
          width: double.infinity,
          height: 120,
          color: Colors.green[400],
          child: Column(
            children: [
              Text(
                "ยอดขายสุทธิ",
                style: MyTextStyle.getTextStyleWhiteNormalText(),
              ),
              Container(
                height: 50,
                child: Text(
                    MyNumberFormatter.formatDecimal(
                        workPoint.saleamount.toString()),
                    style: MyTextStyle.getTextStyleWhiteHeaderText()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.lightGreen[300],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "ยอดขายทั้งหมด",
                            style: MyTextStyle.getTextStyleWhiteNormalText(),
                          ),
                          Text(
                            "" +
                                MyNumberFormatter.formatDecimal(
                                    workPoint.salebeforediscount.toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightGreen[300],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "ส่วนลด ",
                            style: MyTextStyle.getTextStyleWhiteNormalText(),
                          ),
                          Text(
                            "" +
                                MyNumberFormatter.formatDecimal(
                                    workPoint.discount.toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightGreen[300],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "จำนวนบิล",
                            style: MyTextStyle.getTextStyleWhiteNormalText(),
                          ),
                          Text(
                            "" +
                                MyNumberFormatter.formatInteger(this
                                    .saleSummaryModel
                                    .salebillcount
                                    .toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Card createCardExpensive(SumWorkPointModel workPoint) {
    return Card(
      child: Container(
          width: double.infinity,
          height: 120,
          color: Colors.cyan[400],
          child: Column(
            children: [
              Text(
                "ค่าใช้จ่าย",
                style: MyTextStyle.getTextStyleWhiteNormalText(),
              ),
              Container(
                  height: 50,
                  // color: Colors.green[400],
                  child: Text(
                    MyNumberFormatter.formatDecimal(
                        workPoint.sumexpenditureamount.toString()),
                    style: MyTextStyle.getTextStyleWhiteHeaderText(),
                  )),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.cyan[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "เบิกเงินสด",
                            style: MyTextStyle.getTextStyleWhiteNormalText(),
                          ),
                          Text(
                            "" +
                                MyNumberFormatter.formatDecimal(
                                    workPoint.payinamount.toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.cyan[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text("จ่ายบิล",
                              style: MyTextStyle.getTextStyleWhiteNormalText()),
                          Text(
                            "" +
                                MyNumberFormatter.formatDecimal(
                                    workPoint.payoutamount.toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Card createCardIncomeRemain(SumWorkPointModel workPoint) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 120,
        color: Colors.pinkAccent[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                "รายรับคงเหลือ",
                style: MyTextStyle.getTextStyleWhiteNormalText(),
              ),
              Container(
                height: 50,
                child: Text(
                    MyNumberFormatter.formatDecimal(
                        workPoint.incomeremainamount.toString()),
                    style: MyTextStyle.getTextStyleWhiteHeaderText()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.pinkAccent[100],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text("รายรับสะสม ",
                              style: MyTextStyle.getTextStyleWhiteNormalText()),
                          Text(
                            "" +
                                MyNumberFormatter.formatDecimal(
                                    workPoint.incomeremainamount.toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Card(
                  //   color: Colors.pinkAccent[100],
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         "จ่ายบิล ",
                  //         style: MyTextStyle.getTextStyleWhiteNormalText(),
                  //       ),
                  //       Text(
                  //         "" +
                  //             MyNumberFormatter.formatDecimal(
                  //                 workPoint.discount.toString()),
                  //         style: MyTextStyle.getTextStyleWhiteNormalText(
                  //             isBold: true),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Card createCardReturn(SumWorkPointModel workPoint) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 120,
        color: Colors.orange[300],
        child: Column(
          children: [
            Text(
              "คืนสินค้า",
              style: MyTextStyle.getTextStyleWhiteNormalText(),
            ),
            Container(
                height: 50,
                child: Text(
                  workPoint.returnamount.toString(),
                  style: MyTextStyle.getTextStyleWhiteHeaderText(),
                )),
          ],
        ),
      ),
    );
  }

  Card createCardSentAmount(SumWorkPointModel workPoint) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 120,
        color: Colors.redAccent[200],
        child: Column(
          children: [
            Text(
              "ยอดส่งเงิน",
              style: MyTextStyle.getTextStyleWhiteNormalText(),
            ),
            Container(
              height: 50,
              child: Text(
                  MyNumberFormatter.formatDecimal(
                      workPoint.sentamount.toString()),
                  style: MyTextStyle.getTextStyleWhiteHeaderText()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.redAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "เงินขาด",
                          style: MyTextStyle.getTextStyleWhiteNormalText(),
                        ),
                        Text(
                            "" +
                                MyNumberFormatter.formatDecimal(
                                    workPoint.missingamount.toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true))
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.redAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "ส่งเงินสะสม",
                          style: MyTextStyle.getTextStyleWhiteNormalText(),
                        ),
                        Text("" + workPoint.discount.toString(),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true)),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ListTile createDrawMenuSale() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routerClientSale);
      },
      leading: Icon(Icons.add_business),
      title: Text(
        "รายการขาย",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายการขายทั้งหมดของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuEmployee() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeClientEmployee);
      },
      leading: Icon(Icons.add_business),
      title: Text(
        "รายชื่อพนักงาน",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายชื่อพนักงานทั้งหมดของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuStock() {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, MyConstant.routeProductReorder);
        //-- todo
      },
      leading: Icon(Icons.access_alarm),
      title: Text(
        "สินค้าใกล้หมด",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "แสดงรายการสินค้าใกล้หมดของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuProduct() {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, MyConstant.routeClientProduct);
        //-- todo
      },
      leading: Icon(Icons.ac_unit),
      title: Text(
        "รายการสินค้า",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "แสดงรายการสินค้าของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawProductBestSale() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeClientProductBestSale);
      },
      leading: Icon(Icons.auto_graph),
      title: Text(
        "สินค้าขายดี",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายการสินค้าขายดีประจำเดือน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawProductLot() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeClientProductDetailLOT);
      },
      leading: Icon(Icons.point_of_sale),
      title: Text(
        "สต็อกสินค้า",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายการสต็อกและ Lot สินค้าที่ยังมีคงเหลือ",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Card createHeaderSummary() {
    return Card(
      child: Column(children: [
        Text(
          "ยอดขายปัจจุบัน " + this._clientName.toString(),
          style: TextStyle(color: Colors.blue[200]),
        ),
        Text(
          "0.00",
          style: TextStyle(
              color: Colors.blue[900],
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }

  SumWorkPointModel sumWorkPointModel = new SumWorkPointModel();
  SaleSummaryModel saleSummaryModel = new SaleSummaryModel();

  Future<SumWorkPointModel> getSumWorkPointModel() async {
    //print("in getSumWorkPointList");
    String urlWorkPoint = "http://119.59.116.70/flutter/sum_workpoint.php?id=" +
        this._clientID.toString();

    //print(urlWorkPoint);

    Dio().get(urlWorkPoint).then((value) {
      //--
      var saleItems = json.decode(value.data);

      //this.sumWorkPointModelLists.clear();

      for (var item in saleItems) {
        this.sumWorkPointModel = SumWorkPointModel.fromMap(item);
        //this.sumWorkPointModelLists.add(sale);
        //print("-----------------");
        //print(this.sumWorkPointModel);
      }

      //-- ดึงข้อมุลผลรวมของการขาย ประจำเดือน
      String urlSumSale =
          "http://119.59.116.70/flutter/client_sale_summary.php?id=" +
              this._clientID.toString();
      //print(urlSumSale);
      Dio().get(urlSumSale).then((value) {
        var items = json.decode(value.data);

        for (var item in items) {
          //print(item.toString());
          this.saleSummaryModel = SaleSummaryModel.fromMap(item);
        }
      });
      //print(urlWorkPoint);
      return this.sumWorkPointModel;
    });

    return new SumWorkPointModel();
  }
}
