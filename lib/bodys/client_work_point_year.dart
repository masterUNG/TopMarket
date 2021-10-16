import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/sale_summary_model.dart';
import 'package:topmaket/models/sum_work_point_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_decimal_formatter.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientWorkPointYear extends StatefulWidget {
  const ClientWorkPointYear({Key? key}) : super(key: key);

  @override
  _ClientWorkPointYearState createState() => _ClientWorkPointYearState();
}

class _ClientWorkPointYearState extends State<ClientWorkPointYear> {
  //NumberFormat numberFormat = NumberFormat.decimalPattern('en');

  Timer? timer;

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
    return buildWorkPointDay();
  }

  //-- funciton สำค้ญ -------------------------
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  LinearProgressIndicator(
                    color: Colors.brown,
                    backgroundColor: Colors.brown[200],
                  ),
                  createSummarySale(context, workPoint),
                ],
              ),
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
              this.createCardReturn(workPoint),
              this.createCardIncomeRemain(workPoint),
              this.createCardSentAmount(workPoint),
              this.createCardProfit(workPoint),
            ],
          ),
        ),
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

  Card createCardProfit(SumWorkPointModel workPoint) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 120,
        color: Colors.redAccent[700],
        child: Column(
          children: [
            Text(
              "ผลกำไร",
              style: MyTextStyle.getTextStyleWhiteNormalText(),
            ),
            Container(
              height: 50,
              child: Text(
                MyNumberFormatter.formatDecimal(
                    workPoint.finalProfit().toString()),
                style: MyTextStyle.getTextStyleWhiteHeaderText(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.redAccent[400],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "กำไรสะสม",
                          style: MyTextStyle.getTextStyleWhiteNormalText(),
                        ),
                        Text(
                                MyNumberFormatter.formatDecimal(
                                    workPoint.finalProfit().toString()),
                            style: MyTextStyle.getTextStyleWhiteNormalText(
                                isBold: true))
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.redAccent[400],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "ต้นทุนทั้งหมด",
                          style: MyTextStyle.getTextStyleWhiteNormalText(),
                        ),
                        Text(
                            "" +
                                MyNumberFormatter.formatDecimal(
                                    workPoint.sumcost.toString()),
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

  SumWorkPointModel sumWorkPointModel = new SumWorkPointModel();
  SaleSummaryModel saleSummaryModel = new SaleSummaryModel();

  Future<SumWorkPointModel> getSumWorkPointModel() async {
    //print("in getSumWorkPointList");
    String urlWorkPoint = MyConstant.apiDomainName.toString() +
        "/sum_workpoint_year.php?id=" +
        MyConstant.currentClientID.toString();

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
      String urlSumSale = MyConstant.apiDomainName.toString() +
          "/client_sale_summary.php?id=" +
          MyConstant.currentClientID.toString();
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
