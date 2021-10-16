import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/product_model.dart';
import 'package:topmaket/utility/my_constant.dart';

class ShowAllProduct extends StatefulWidget {
  const ShowAllProduct({Key? key}) : super(key: key);

  @override
  _ShowAllProductState createState() => _ShowAllProductState();
}

class _ShowAllProductState extends State<ShowAllProduct> {
  List<ProductModel> productModels = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //-- สั่งให้ Read Data ใน initstate คล้ายๆ กับ การ new object ใน C# 
    this.readAllData();
  }

  Future<Null> readAllData() async {
    //-- uRL 
    String urlAPI = "https://www.androidthai.in.th/bigc/getAllFood.php";
    //-- การสั่งโหลดข้อมูล 
    await Dio().get(urlAPI).then((value) {//-- หลักจากทำงานเสร็จแล้ว จะส่ง ผลลัพธ์​มาเป็น Value 
      //-- todo
      //-- ตัว Value จะเป็นผลลัพธ์ทั้งก้อน แล้ว เราต้องเอามา วนลูปสร้าง vlaue ให้เป็น Model 
      for (var item in json.decode(value.data)) {
        //-- for data
        //-- ตัว Item จะเป็น Map key:value เราต้องเอามาแตก เอง 
        ProductModel model = ProductModel.fromMap(item);
        setState(() {
          this.productModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("clict foatting button...");
            Navigator.pushNamed(context, MyConstant.routeCreateProduct); 
          },
        ),

        //-- body 
        body: this.productModels.length == 0
            ? Center(child: CircularProgressIndicator())
            : Text("loading finish"));
  }
}
