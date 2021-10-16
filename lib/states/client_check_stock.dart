import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:topmaket/models/client_prodct_stock_search.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientCheckStock extends StatefulWidget {
  const ClientCheckStock({Key? key}) : super(key: key);

  @override
  _ClientCheckStockState createState() => _ClientCheckStockState();
}

class _ClientCheckStockState extends State<ClientCheckStock> {
  TextEditingController? txtSearchKey;

  @override
  void initState() {
    super.initState();

    this.txtSearchKey = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        backgroundColor: Colors.purple[200],
        title: TextFormField(
          controller: this.txtSearchKey,
          style: MyTextStyle.getTextStyleWhiteNormalText(isBold: true),
          decoration: InputDecoration(
            hintText: "ค้นหาสินค้า/Barcode",
            hintStyle: MyTextStyle.getTextStyleWhiteNormalText(),
          ),
          onChanged: (String text) {
            this.setState(() {});
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              //-- function scan barcode
              this.scanBarcodeNormal();
            },
            icon: Icon(Icons.qr_code_sharp),
          ),
        ],
      ),
      body: buildProductStockList(),
    );
  }

  FutureBuilder<List<ClientProductStockSearchModel>> buildProductStockList() {
    return FutureBuilder<List<ClientProductStockSearchModel>>(
      future: this.getProductCheckStock(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //print("has data = :" + snapshot.hasData.toString());
          List<ClientProductStockSearchModel> stocks = snapshot.data;
          //print("stock length = " + stocks.length.toString());

          if (stocks.length == 0) {
            return Center(child: Text("ไม่พบรายการสต็อกคงเหลือ"));
          }

          return ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (BuildContext context, int index) {
                ClientProductStockSearchModel stock = stocks[index];
                print(stock.toString());

                return Container(
                  height: 110,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network(
                        //         MyConstant.apiDomainName.toString() +
                        //             "/getproduct_imageicon.php?client=" +
                        //             MyConstant.currentClientID.toString() +
                        //             "&id=" +
                        //             stock.id.toString(),
                        //       ),
                        Text(stock.name.toString(),
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        Row(
                          children: [
                            Card(
                              color: Colors.purple[100],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Lot ที่",
                                      style: MyTextStyle
                                          .getTextStyleWhiteSubTitleText(),
                                    ),
                                    Text(
                                      stock.lot.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.indigo[100],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "วันที่",
                                      style: MyTextStyle
                                          .getTextStyleWhiteSubTitleText(),
                                    ),
                                    Text(stock.formatDate(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.pink[100],
                              child: Column(
                                children: [
                                  Text(
                                    "จำนวนรับ",
                                    style: MyTextStyle
                                        .getTextStyleWhiteSubTitleText(),
                                  ),
                                  Text(stock.quantity.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Card(
                              color: Colors.pink[100],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "คงเหลือ",
                                      style: MyTextStyle
                                          .getTextStyleWhiteSubTitleText(
                                              color: Colors.pink),
                                    ),
                                    Text(stock.remain.toString(),
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
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
              });
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }

  List<ClientProductStockSearchModel> stockModelList = [];
  Future<List<ClientProductStockSearchModel>> getProductCheckStock() async {
    String url = MyConstant.apiDomainName.toString() +
        "/client_product_check_stock.php" +
        "?client=132" +
        "&key=" +
        txtSearchKey!.text.toString();

    print(url);
    stockModelList.clear();

    await Dio().get(url).then(
      (value) {
        var items = json.decode(value.data);
        for (var item in items) {
          ClientProductStockSearchModel model =
              ClientProductStockSearchModel.fromMap(item);
          stockModelList.add(model);
        }

        return this.stockModelList;
      },
    );
    return this.stockModelList;
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print("Barcoe => " + barcodeScanRes);

      this.txtSearchKey!.text = barcodeScanRes;

      this.setState(() {});
    } catch (err) {
      barcodeScanRes = "อุปกรณ์ไม่รองรับ";
    }

//-- ตรวจสอบอะไร บางอย่าง
    if (!mounted) return;

    // setState(() {
    //   //_scanBarcode = barcodeScanRes;
    // });
  }
}
