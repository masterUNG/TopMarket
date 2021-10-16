import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_customer_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientCustomer extends StatefulWidget {
  const ClientCustomer({Key? key}) : super(key: key);

  @override
  _ClientCustomerState createState() => _ClientCustomerState();
}

class _ClientCustomerState extends State<ClientCustomer> {
  Timer? timer;
  @override
  void initState() {
    super.initState();

    this.getClientCustomerList();

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
        appBar: new AppBar(title: Text("ลูกค้า")),
        body: SafeArea(child: buildCustomerFutureGrid()));
  }

  FutureBuilder<List<ClientCustomerModel>> buildCustomerFutureGrid() {
    return FutureBuilder(
        future: this.getClientCustomerList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (this.clientCustomerModelList.length == 0) {
            print("has data ==0  : " + snapshot.hasData.toString());
            return LinearProgressIndicator();
          } else {
            print("has data OK : " + snapshot.hasData.toString());
            return GridView.builder(
                itemCount: this.clientCustomerModelList.length,
                //-- ตั้งค่า Grid
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 4 / 6,
                ),

                //--  ตัวสร้าง Grid
                itemBuilder: (BuildContext context, int index) {
//-- ดึงตัวแปร
                  ClientCustomerModel customer =
                      this.clientCustomerModelList[index];

                  String url = MyConstant.apiDomainName.toString() +
                      "/getcustomer_icon.php?client=" +
                      MyConstant.currentClientID.toString() +
                      "&id=" +
                      customer.id.toString();

                  return GestureDetector(
                    onTap: () {
                      // MyConstant.currentProductID = product.id;
                      // Navigator.pushNamed(
                      //     context, MyConstant.routeClientProductDetail);
                    },
                    child: buildEmployeeGridItem(url, customer),
                  );
                });

            //this.timer!.cancel();
          }

          //return LinearProgressIndicator();
        });
  }

  Container buildEmployeeGridItem(String url, ClientCustomerModel customer) {
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
                  customer.fullname.toString(),
                  style: MyTextStyle.getTextStyleWhiteTitleText(
                    color: Colors.black87,
                  ),
                ),
                //--
                Row(
                  children: [
                    Image.asset("images/phone16.png"),
                    Text(
                      customer.phone.toString(),
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
                      customer.line.toString(),
                      style: TextStyle(
                          color: Colors.blue[300], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset("images/star16.png"),
                        Text(
                          customer.points.toString(),
                          style: TextStyle(
                              color: Colors.yellow[600],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset("images/home16.png"),
                        Text(
                          customer.province.toString(),
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  List<ClientCustomerModel> clientCustomerModelList = [];
  Future<List<ClientCustomerModel>> getClientCustomerList() async {
    String url = MyConstant.apiDomainName.toString() +
        "/client_customer.php?client=" +
        MyConstant.currentClientID.toString();

    //print(url);

    Dio().get(url).then((value) {
      var items = json.decode(value.data);

      clientCustomerModelList.clear();
      for (var item in items) {
        //print(items.toString());
        clientCustomerModelList.add(ClientCustomerModel.fromMap(item));
        //print("data length ->> "+clientCustomerModelList.length.toString());
      }
    });

    return this.clientCustomerModelList;
  }
}
