import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:topmaket/models/client_employee_model.dart';
import 'package:topmaket/models/client_product_mode.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientEmployeeGrid extends StatefulWidget {
  const ClientEmployeeGrid({Key? key}) : super(key: key);

  @override
  _ClientEmployeeGridState createState() => _ClientEmployeeGridState();
}

class _ClientEmployeeGridState extends State<ClientEmployeeGrid> {
  Timer? timer;
  @override
  void initState() {
    super.initState();

    this.getClientEmployeeModelJson();

    this.timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
    //timer.cancel();
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        title: Text("รายชื่อพนักงาน"),
      ),
      body: FutureBuilder(
        future: this.getClientEmployeeModelJson(),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          //-- สร้าง Grid
          return GridView.builder(
              //--  จำนวน item ที่จะให้แสดง Grid
              itemCount: this.clientEmployeeModelsList.length,
              //-- การตั้งค่า Grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 6,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                EmployeeModel emp = this.clientEmployeeModelsList[index];

                String url = MyConstant.apiDomainName.toString() +
                    "/getproduct_empicon.php?client=" +
                    MyConstant.currentClientID.toString() +
                    "&id=" +
                    emp.id.toString();
                //print(url);

                return GestureDetector(
                  onTap: () {
                    // MyConstant.currentProductID = product.id;
                    // Navigator.pushNamed(
                    //     context, MyConstant.routeClientProductDetail);
                  },
                  child: buildEmployeeGridItem(url, emp),
                );
              });
        },
      ),
    );
  }

  Container buildEmployeeGridItem(String url, EmployeeModel emp) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //-- รูปภาพด้านบน
            Expanded(
              child: Container(
                color: Colors.red,
                child: Image.network(url, fit: BoxFit.cover),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //--
                Text(
                  emp.firstname.toString() + " " + emp.lastname.toString(),
                  style: MyTextStyle.getTextStyleWhiteTitleText(
                    color: Colors.black87,
                  ),
                ),
                //--
                Row(
                  children: [
                    Image.asset("images/phone16.png"),
                    Text(
                      emp.phonenumber.toString(),
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
                    Image.asset("images/mail16.png"),
                    Text(
                      emp.email.toString(),
                      style: TextStyle(
                          color: Colors.blue[300], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset("images/line16.png"),
                    Text(
                      emp.line.toString(),
                      style: TextStyle(
                          color: Colors.blue[300], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  List<EmployeeModel> clientEmployeeModelsList = [];
  Future<List<EmployeeModel>> getClientEmployeeModelJson() async {
    String url = MyConstant.apiDomainName.toString() +
        "/employee.php?id=" +
        MyConstant.currentClientID.toString();

    print(url);
    Dio().get(url).then((value) {
      var items = json.decode(value.data);
      this.clientEmployeeModelsList.clear();
      for (var map in items) {
        this.clientEmployeeModelsList.add(EmployeeModel.fromMap(map));
        //print(map.toString());
      }
      // if(this.clientEmployeeModelsList.length > 0) {
      //   this.timer!.cancel();
      // }
      return this.clientEmployeeModelsList;
    });
    return [];
  }
}
