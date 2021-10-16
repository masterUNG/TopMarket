import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_product_mode.dart';
import 'package:topmaket/models/product_best_price_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_decimal_formatter.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductBestSale extends StatefulWidget {
  const ClientProductBestSale({Key? key}) : super(key: key);

  @override
  _ClientProductBestSaleState createState() => _ClientProductBestSaleState();
}

class _ClientProductBestSaleState extends State<ClientProductBestSale> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => doSetState());
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("สินค้าขายดี"),
         backgroundColor: Colors.brown[200],
      ),
      body: new FutureBuilder(
          future: this.loadClientProductBestSaleModel(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              if(this.clientProductBestSale.length > 0) {
              return ListView.builder(
                  itemCount: this.clientProductBestSale.length,
                  itemBuilder: (context, index) {
                    ClientProductBestSaleModel best =
                        this.clientProductBestSale[index];
                    //print(best);
                    return Container(
                      height: 80,
                      child: Card(
                        child: Row(
                          children: [
                            Image.network(
                              MyConstant.apiDomainName.toString() +
                                  "/getproduct_imageicon.php?client=" +
                                  MyConstant.currentClientID.toString() +
                                  "&id=" +
                                  best.id.toString(),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  best.name.toString(),
                                  style: new TextStyle(
                                      color: Colors.red[700], fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                        color: Colors.red[50],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text("ยอดขาย : ",
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                              Text(
                                                MyNumberFormatter.formatDecimal(
                                                    best.sumprice.toString()),
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Card(
                                        color: Colors.yellow[50],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "จำนวนชิ้น : ",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                best.sumtotalprimaryquantity
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.brown[400],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
              } else {
                return LinearProgressIndicator();
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

//-- ----------
  List<ClientProductBestSaleModel> clientProductBestSale = [];
  Future<List<ClientProductBestSaleModel>>
      loadClientProductBestSaleModel() async {
    String url = MyConstant.apiDomainName.toString() +
        "/client_product_best_sale.php?id=" +
        MyConstant.currentClientID.toString();

    Dio().get(url).then((value) {
      //--
      var saleItems = json.decode(value.data);

      this.clientProductBestSale.clear();
      for (var item in saleItems) {
        ClientProductBestSaleModel sale =
            ClientProductBestSaleModel.fromMap(item);
        this.clientProductBestSale.add(sale);
      }

      return this.clientProductBestSale;
    });

    return [];
  }
}
