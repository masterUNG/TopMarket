import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_product_mode.dart';
import 'package:topmaket/states/client_product_detail_general_modify.dart';
import 'package:topmaket/utility/action_type.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProduct extends StatefulWidget {
  const ClientProduct({Key? key}) : super(key: key);

  @override
  _ClientProductState createState() => _ClientProductState();
}

class _ClientProductState extends State<ClientProduct> {
  Timer? timer;
  // Timer? timer;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   // this.timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
  //   //   Timer(Duration(seconds: 3), () {
  //   //     setState(() {});

  //   //   });
  //   // });
  // }
  @override
  void initState() {
    super.initState();

    this.getClientProductModel();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
    //timer.cancel();
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("รายการสินค้า"),
          backgroundColor: Colors.brown[200],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ClientProductDetailGeneralModify pageProduct =
                new ClientProductDetailGeneralModify(actionType: ActionType.Insert);
            MaterialPageRoute route =
                MaterialPageRoute(builder: (BuildContext context) {
              return pageProduct;
            });
            MyConstant.currentProductID = ""; //product.id;
            Navigator.of(context).push(route);
          },
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
        ),
      
        body: SafeArea(
          child: Container(
      
            child: FutureBuilder(
                future: this.getClientProductModel(),
                builder: (context, snapshort) {
                  if (snapshort.hasData) {
                    //this.timer.cancel();
                    if (this.clientProductModels.length > 0) {
                      this.timer!.cancel();
                      //- มี Data มีข้อมูล
                      return createListviewProduct();
                    } else {
                      //--มี data แต่ ไมม่ข้อมูล
                      //return Center(child: Text("ไม่พบรายการสินค้า"));
                      return LinearProgressIndicator();
                    }
                  } else {
                    return LinearProgressIndicator();
                  }
                }),
          ),
        ));
  }

  ListView createListviewProduct() {
    return ListView.builder(
        itemCount: this.clientProductModels.length,
        itemBuilder: (context, index) {
          ClientProductModel product = this.clientProductModels[index];

          Image? productImage;

          try {
            productImage = Image.network(
              MyConstant.apiDomainName.toString() +
                  "/getproduct_imageicon.php?client=" +
                  MyConstant.currentClientID.toString() +
                  "&id=" +
                  product.id.toString(),
            );

            //print("image ok");
          } catch (err) {
            //print("image error");
            productImage = Image.asset("images/noimage.png");
          }

          //-- containner นอกสุด
          return GestureDetector(
            onTap: () {
              //-- todo
              ClientProductDetailGeneralModify pageProduct =
                  new ClientProductDetailGeneralModify(actionType: ActionType.Modify);
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (BuildContext context) {
                return pageProduct;
              });
              MyConstant.currentProductID = product.id;
              Navigator.of(context).push(route);
              //Navigator.pushNamed(context, MyConstant.routeClientProductDetail);
            },
            child: Container(
              //color: Colors.blueAccent,
              height: 120,
              //width: double.infinity,

              child: Card(
                //color: Colors.white.withOpacity(0.9),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //Image.asset("images/noimage.png"),
                    Container(
                      width: 120,
                      child: productImage,
                    ),

                    //-- expanded เป็น containner แบบยึดเต็มพื้นที่
                    Expanded(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //-- ชื่อสินค้า
                          createProductName(product),
                          //-- รายละเอียดสินค้า
                          SingleChildScrollView(
                            child: createProductDetail(product),
                          ),
                          //-- ปุ่มด้านล่าง
                          createProductActionButton(product)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Container createProductActionButton(ClientProductModel product) {
    return Container(
      //width: 500,
      //color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text("ขายแล้ว"),
                      Text(
                        product.totalquantity.toString(),
                        style: MyTextStyle.getTextStyleWhiteNormalText(
                            color: Colors.redAccent, isBold: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text("ยอดขายทั้งหมด"),
                      Text(
                        product.totalsumprice.toString(),
                        style: MyTextStyle.getTextStyleWhiteNormalText(
                            color: Colors.indigo, isBold: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text createProductName(ClientProductModel product) {
    return Text(
      product.name.toString(),
      style: TextStyle(
          fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Container createProductDetail(ClientProductModel product) {
    return Container(
      child: Row(
        children: [
          Row(
            children: [
              Text(product.type.toString()),
            ],
          ),
          Row(
            children: [
              Text(product.brand.toString()),
            ],
          ),
          Row(
            children: [
              createProductRemainInformation(product),
            ],
          ),
        ],
      ),
    );
  }

  Row createProductRemainInformation(ClientProductModel product) {
    //print("remain : " + product.remain.toString());
    if (product.remain.toString().compareTo("null") == 0) {
      return Row(
        children: [
          Image.asset("images/Error.png"),
          Text(
            "สินค้าหมด",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Image.asset("images/success.png"),
          Text("คงเหลือ :"),
          Text(
            product.remain.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          Text(" " + product.unit.toString()),
        ],
      );
    }

    return Row();
  }

  List<ClientProductModel> clientProductModels = [];
  Future<List<ClientProductModel>> getClientProductModel() async {
    String url = "http://119.59.116.70/flutter/product.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=";
    //print(url);
    Dio().get(url).then((value) {
      var data = json.decode(value.data);
      this.clientProductModels.clear();
      for (var item in data) {
        //--
        clientProductModels.add(ClientProductModel.fromMap(item));
      }

      return clientProductModels;
    });
    return [];
  }
}
