import 'dart:async';
import 'dart:convert';
//import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/sale_detail_model.dart';
import 'package:topmaket/utility/my_constant.dart';

class MySaleDetail extends StatefulWidget {
  const MySaleDetail({Key? key}) : super(key: key);

  @override
  _MySaleDetailState createState() => _MySaleDetailState();
}

class _MySaleDetailState extends State<MySaleDetail> {
  String? saleID;
  String? clientID;
  Timer? timer;
  bool isSearch = false;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => doSetState());
    //timer.cancel();
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //NumberFormat numberFormat = NumberFormat.decimalPattern('en');

    this.saleID = MyConstant.currentSaleID;
    this.clientID = MyConstant.currentClientID;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        title: Text("บิล :" + this.saleID.toString()),
        backgroundColor: Colors.brown[200],
 
      ),
      body: FutureBuilder(
          future: getClientSaleDetail(),
          builder: (context, snapshot) {
            //print("Snapshot.hasData : " + snapshot.hasData.toString());
            if (snapshot.hasData) {
              if (this.saleDetailModelList.length > 0) {
                this.timer!.cancel();
                return buildeListViewProductItems();
              } else {
                return LinearProgressIndicator(
                    backgroundColor: Colors.brown[100],
                    color: Colors.brown[400]);
              }
              //print("Has Data");

            } else {
              return LinearProgressIndicator();
            }
          }),
    );
  }

  ListView buildeListViewProductItems() {
    return new ListView.builder(
        //-- จำนวน
        itemCount: this.saleDetailModelList.length,
        //-- ตัว builder
        itemBuilder: (context, index) {
          //print("in builder");
          //-- listview body
          SaleDetailModel saleDetail = this.saleDetailModelList[index];
          //--
          //print("สินค้า : " + saleDetail.product.toString());
          return Card(
            child: Container(
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    child: Image.network(
                      MyConstant.apiDomainName.toString() +
                          "/getproduct_imageicon.php?client=" +
                          MyConstant.currentClientID.toString() +
                          "&id=" +
                          saleDetail.id.toString(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          saleDetail.product.toString(),
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: createProductListViewBuilder(saleDetail),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container createProductListViewBuilder(SaleDetailModel saleDetail) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Card(
                color: Colors.greenAccent[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "ราคา: ",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            saleDetail.getPriceForrmated().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Card(
                color: Colors.indigoAccent[100],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "จำนวน: ",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            saleDetail.quantity.toString() +
                                " " +
                                saleDetail.unit.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Card(
                color: Colors.redAccent[100],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "รวม: ",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            saleDetail.getSumPriceForrmated().toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<SaleDetailModel> saleDetailModelList = [];
  Future<List<SaleDetailModel>> getClientSaleDetail() async {
    String url = "http://119.59.116.70/flutter/sale_detail.php?client=" +
        this.clientID.toString() +
        "&sale=" +
        this.saleID.toString() +
        "";
    Dio().get(url).then((value) {
      var saleItems = json.decode(value.data);
//print("url => "+url);
      saleDetailModelList.clear();
      for (var item in saleItems) {
        saleDetailModelList.add(SaleDetailModel.fromMap(item));
        print("product => " + item.toString());
      }

      return saleDetailModelList;
    });

    return [];
  }
}
