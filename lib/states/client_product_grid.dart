import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:topmaket/models/client_product_detail_general_model.dart';
import 'package:topmaket/models/client_product_mode.dart';
import 'package:topmaket/states/client_product_detail_general_modify.dart';
import 'package:topmaket/states/client_product_detail_general_new.dart';
import 'package:topmaket/utility/action_type.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductGrid extends StatefulWidget {
  const ClientProductGrid({Key? key}) : super(key: key);

  @override
  _ClientProductGridState createState() => _ClientProductGridState();
}

class _ClientProductGridState extends State<ClientProductGrid> {
  //Timer? timer;
  @override
  void initState() {
    super.initState();

    this.getClientProductModel();

    // this.timer =
    //     Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
    // //timer.cancel();
  }

  // void doSetState() {
  //   this.setState(() {});
  // }

  TextEditingController txtSearch = new TextEditingController();
  bool isSeachStatus = false;
  FocusNode _fucusSearch = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        title: this.isSeachStatus
            ? TextFormField(
                focusNode: _fucusSearch,
                onChanged: (String text) {
                  this.setState(() {});
                },
                controller: this.txtSearch,
                style: TextStyle(fontSize: 18, color: Colors.white),
                decoration: InputDecoration(focusColor: Colors.brown),
              )
            : Text("รายการสินค้า"),
        actions: [
          this.isSeachStatus
              ? IconButton(
                  onPressed: () {
                    this.txtSearch.text = "";
                    this.isSeachStatus = false;
                    print("isSearching = false");
                    this.setState(() {});
                  },
                  icon: Icon(Icons.cancel),
                )
              : IconButton(
                  onPressed: () {
                    _fucusSearch.requestFocus();
                    this.isSeachStatus = true;
                    print("isSearching = false");

                    this.setState(() {});
                  },
                  icon: Icon(Icons.search),
                )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          this.openNewProductPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
      body: FutureBuilder(
        future: this.getClientProductModel(),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          //-- สร้าง Grid
          if (snapShot.hasData) {
            //--
            return buildGridView();
          } else {
            //-- 
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
              //--  จำนวน item ที่จะให้แสดง Grid
              itemCount: this.clientProductModels.length,
              //-- การตั้งค่า Grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 6,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                // print("this.clientProductModels.length = [" +
                //     this.clientProductModels.length.toString() +
                //     "] == index [" +
                //     index.toString());
                // if (index > 1) {
                //   this.timer!.cancel();
                //   //print("cancel timer...");
                // }
                ClientProductModel product = this.clientProductModels[index];

                String url = MyConstant.apiDomainName.toString() +
                    "/getproduct_imageicon.php?client=" +
                    MyConstant.currentClientID.toString() +
                    "&id=" +
                    product.id.toString();

                String priceInfo = product.minprice.toString();
                if (product.minprice
                        .toString()
                        .toLowerCase()
                        .compareTo("null") !=
                    0) {
                  priceInfo += " - " + product.maxprice.toString();
                }

                return GestureDetector(
                  onTap: () {
                    MyConstant.currentProductID = product.id;
                    Navigator.pushNamed(
                        context, MyConstant.routeClientProductDetail);
                  },
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //-- รูปภาพด้านบน
                          Expanded(
                              child: Container(
                                  color: Colors.red,
                                  child:
                                      Image.network(url, fit: BoxFit.cover))),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //--
                              Text(
                                product.name.toString(),
                                style: MyTextStyle.getTextStyleWhiteTitleText(
                                  color: Colors.black87,
                                ),
                              ),
                              //--
                              Row(
                                children: [
                                  Text(
                                    priceInfo,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent[400],
                                    ),
                                  ),
                                ],
                              ),
                              //-- ขายแล้ว
                              Row(
                                children: [
                                  Image.asset("images/sale.png"),
                                  Text(
                                    "ขายแล้ว ",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    product.totalquantity.toString(),
                                    style: TextStyle(
                                        color: Colors.blue[300],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " " + product.unit.toString(),
                                  ),
                                ],
                              ),
                              //-- คงเลหือ
                              product.remain == null
                                  ? buildProductEmptyInfo()
                                  : buildRemainInfo(product),
                            ],
                          )
                        ],
                      )),
                );
              });
  }

  Future<void> openNewProductPage() async {
    //-- สร้าง object page
    ClientProductDetailGeneralNew pageProduct =
        new ClientProductDetailGeneralNew(actionType: ActionType.Insert);
    //--  สร้าตัว  reoute
    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext context) {
      return pageProduct;
    });
    //--
    MyConstant.currentProductID = ""; //product.id;

    //-- เปิด page พร้อมบอกให้รอ
    await Navigator.of(context).push(route);

    this.setState(() {});
  }

  Row buildProductEmptyInfo() => Row(
        children: [
          Image.asset("images/empty16.png"),
          Text(
            "สินค้าหมด",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );

  Row buildRemainInfo(ClientProductModel product) {
    return Row(
      children: [
        Image.asset("images/box6916.png"),
        Text("เหลือ "),
        Text(
          product.remain.toString(),
          style: TextStyle(
              color: Colors.deepOrange[300], fontWeight: FontWeight.bold),
        ),
        Text(" " + product.unit.toString()),
      ],
    );
  }

  GridTile buildGridTile(ClientProductModel product, String url) {
    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4))),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(
            product.name.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("คงเหลือ : " + product.remain.toString()),
        ),
      ),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }

  List<ClientProductModel> clientProductModels = [];
  Future<List<ClientProductModel>> getClientProductModel() async {
    String url = MyConstant.apiDomainName.toString() +
        "/product.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=" +
        this.txtSearch.text.trim();

    print(url);
    await Dio().get(url).then((value) {
      var data = json.decode(value.data);
      this.clientProductModels.clear();
      for (var item in data) {
        //--
        clientProductModels.add(ClientProductModel.fromMap(item));
      }

      //-- ถ้าได้ข้อมูลมา ก็ให้หยุด Trigger
      // if (this.clientProductModels.length > 0) {
      //   this.timer!.cancel();
      // }
      return clientProductModels;
    });
    return [];
  }
}
