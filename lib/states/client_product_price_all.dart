import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:topmaket/models/client_product_price2_mode.dart';
//import 'package:topmaket/models/client_produt_price_model.dart';
import 'package:topmaket/states/client_product_price_detail.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductPriceAll extends StatefulWidget {
  const ClientProductPriceAll({Key? key}) : super(key: key);

  @override
  _ClientProductPriceAllState createState() => _ClientProductPriceAllState();
}

class _ClientProductPriceAllState extends State<ClientProductPriceAll> {
  TextEditingController txtSearchKey = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
          title: TextFormField(
            controller: txtSearchKey,
            style: MyTextStyle.getTextStyleWhiteNormalText(isBold: true),
            decoration: InputDecoration(
              hintText: " ค้นหาสินค้า/Barcode",
              hintStyle: MyTextStyle.getTextStyleWhiteNormalText(),
              focusColor: Colors.white,
            ),
            onChanged: (String text) {
              this.setState(() {});
            },
          ),
          backgroundColor: Colors.brown[200],
          actions: [
            this.txtSearchKey.text.length > 0
                ? IconButton(
                    onPressed: () {
                      this.txtSearchKey.text = "";
                      this.setState(() {});
                    },
                    icon: Icon(Icons.cancel))
                : IconButton(
                    onPressed: () {
                      this.scanBarcodeNormal();
                    },
                    icon: Icon(Icons.qr_code),
                  ),
          ]),
      body: FutureBuilder(
          future: this.getClientProductPrice(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // print(
              //     "data length : " + this.clientProductPrice.length.toString());
              if (this.clientProductPrice.length == 0) {
                //return new LinearProgressIndicator();
                return Center(
                  child: Text(
                    "ไม่พบข้อมูล",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return createPriceListView();
              }
            } else {
              return new LinearProgressIndicator(
                color: Colors.brown[400],
                backgroundColor: Colors.brown[200],
              );
            }
          }),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      //print("Barcoe => " + barcodeScanRes);

      this.txtSearchKey.text = barcodeScanRes;

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

  ListView createPriceListView() {
    return new ListView.builder(
        itemCount: this.clientProductPrice.length,
        itemBuilder: (BuildContext context, int index) {
          ClientProdctPrice2Model price = this.clientProductPrice[index];
          return GestureDetector(
            onTap: () async {
              MyConstant.currentProductID = price.id.toString();
              //-- price type id
              MyConstant.currentProductPriceTypeID =
                  price.pricetypeid.toString();

              //-- unitid
              MyConstant.currentProdctUnitID = price.unitid.toString();
              MyConstant.currentProducPriceIsPackaging =
                  price.ispackageing.toString().toUpperCase().compareTo("Y") ==
                          0
                      ? true
                      : false;

              //         //-----------
              ClientProductPriceDetail clientPriceDetail =
                  new ClientProductPriceDetail(
                      // doSetState: this.doSetState,
                      );

              MaterialPageRoute payItemsRoute =
                  MaterialPageRoute(builder: (BuildContext context) {
                return clientPriceDetail;
              });

              //Navigator.pushNamed(context, MyLookup.lookupPayItems);
              await Navigator.of(context).push(payItemsRoute);

              this.setState(() {});
            },
            child: GestureDetector(
              onTap: () async {
                //--
                MyConstant.currentProductID = price.id.toString();
                //--
                MyConstant.currentProductPriceTypeID =
                    price.pricetypeid.toString();

                //-- unitid
                MyConstant.currentProdctUnitID = price.unitid.toString();
                MyConstant.currentProducPriceIsPackaging = price.ispackageing
                            .toString()
                            .toUpperCase()
                            .compareTo("Y") ==
                        0
                    ? true
                    : false;

                print("Product ID : " + MyConstant.currentProductID.toString());
                print("Unit ID : " + MyConstant.currentProdctUnitID.toString());
                print("packaging ID : " +
                    MyConstant.currentProducPriceIsPackaging.toString());
                //         //-----------
                ClientProductPriceDetail clientPriceDetail =
                    new ClientProductPriceDetail(
                        // doSetState: this.doSetState,
                        );

                MaterialPageRoute payItemsRoute =
                    MaterialPageRoute(builder: (BuildContext context) {
                  return clientPriceDetail;
                });

                //Navigator.pushNamed(context, MyLookup.lookupPayItems);
                await Navigator.of(context).push(payItemsRoute);

                this.setState(() {});
              },
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price.productname.toString(),
                    style: MyTextStyle.getTextStyleWhiteTitleText(
                        color: Colors.blue),
                  ),
                  Container(
                    height: 80,
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Card(
                              color: Colors.yellowAccent[50],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  price.unitname.toString(),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrangeAccent),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ชื่อราคา"),
                                Text(price.name.toString(),
                                    style: TextStyle(
                                        color: Colors.blueAccent[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ทุน"),
                                Text(price.cost.toString(),
                                    style: TextStyle(
                                        color: Colors.greenAccent[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ขาย"),
                                Text(price.price.toString(),
                                    style: TextStyle(
                                        color: Colors.redAccent[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
          );
        });
  }

  List<ClientProdctPrice2Model> clientProductPrice = [];
  Future<List<ClientProdctPrice2Model>> getClientProductPrice() async {
    String? url = MyConstant.apiDomainName.toString() +
        "/product_price_all.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=" +
        this.txtSearchKey.text.toString();

    print("price URL : " + url.toString());
    await Dio().get(url).then((value) {
      var items = json.decode(value.data);
      clientProductPrice.clear();
      for (var item in items) {
        this.clientProductPrice.add(ClientProdctPrice2Model.fromMap(item));
        // break;
      }
    });
    return this.clientProductPrice;
  }
}
