import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/product_reorder_model.dart';
import 'package:topmaket/utility/my_constant.dart';

class ProductReorder extends StatefulWidget {
  const ProductReorder({Key? key}) : super(key: key);

  @override
  _ProductReorderState createState() => _ProductReorderState();
}

class _ProductReorderState extends State<ProductReorder> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    this.timer =
        Timer.periodic(Duration(seconds: 3), (Timer t) => doSetState());
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("สินค้าใกล้หมด"),
      ),
      body: FutureBuilder(
          future: this.getProducReorder(),
          builder: (context, snapshot) {
            print("in future builder");
            print("snap short :" + snapshot.hasData.toString());
            return ListView.builder(
                itemCount: this.productReorderList.length,
                itemBuilder: (context, index) {
                  //print("in listview builder...");

                  //-- ดึง Object reoder 
                  ProductReorderModel reorder = this.productReorderList[index];
                  //print(reorder.toString());
                  return Card(
                    child: Container(
                      height: 70,
                      child: Row(
                        children: [
                          Image.asset("images/noimage.png"),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reorder.name.toString(),
                                style: TextStyle(
                                    fontSize: 24, color: Colors.red[600]),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //  Card(child: ,)
                                  Row(
                                    children: [
                                      Card(
                                        color: Colors.yellow[50],
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 16,
                                                  child: Image.asset(
                                                      "images/Error.png")),
                                                      Text("คงเหลือ :"),
                                              Text(
                                                reorder.remain.toString(),
                                                style: TextStyle(
                                                    color: Colors.red[600],
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(" "+reorder.unit.toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  List<ProductReorderModel> productReorderList = [];
  Future<List<ProductReorderModel>> getProducReorder() async {
    String url = "http://119.59.116.70/flutter/reorder.php?client=" +
        MyConstant.currentClientID.toString();

    print("url : " + url);
    Dio().get(url).then((value) {
      this.productReorderList.clear();
      var items = json.decode(value.data);

      for (var item in items) {
        print(item.toString());
        this.productReorderList.add(ProductReorderModel.fromMap(item));
      }
      print("Reorder count = " + this.productReorderList.length.toString());
      return this.productReorderList;
    });

    return [];
  }
}
