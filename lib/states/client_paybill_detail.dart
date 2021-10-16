import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/payin_detail_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientPayBillDetail extends StatefulWidget {
  const ClientPayBillDetail({Key? key}) : super(key: key);

  @override
  _ClientPayBillDetailState createState() => _ClientPayBillDetailState();
}

class _ClientPayBillDetailState extends State<ClientPayBillDetail> {
  Timer? timer; //  = null;
  // //-- contorller
  // TextEditingController txtType = new TextEditingController();
  // TextEditingController txtID = new TextEditingController();
  // TextEditingController txtBarcode = new TextEditingController();
  // TextEditingController txtName = new TextEditingController();
  // TextEditingController txtDesc = new TextEditingController();
  // TextEditingController txtBrand = new TextEditingController();
  // TextEditingController txtUnit = new TextEditingController();
  // TextEditingController txtStockRemain = new TextEditingController();

  void doSetState() {
    this.setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //this.getCleintProductDetailGeneralModel();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: Text("รายการจ่ายบิล"),
      // ),
      body: SafeArea(
        //child: Container(),

        child: FutureBuilder(
            future: this.getClientPayInDetailModel(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (this.loadCountNull > 3 &&
                  this.clientPayIndetailModel.length == 0) {
                      print("สิ้นสุดการ Load ...");
                this.timer!.cancel();
                return Center(
                    child: Text(
                  "ไม่พบข้อมูลการจ่ายบิล",
                  style: MyTextStyle.getTextStyleWhiteNormalText(
                    color: Colors.red,
                  ),
                ));
              }
              if (snap.hasData) {
                if (this.clientPayIndetailModel.length == 0) {
                  return LinearProgressIndicator();
                } else {
                  this.timer!.cancel();
                  print("has data");
                  return ListView.builder(
                      itemCount: this.clientPayIndetailModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        ClientPayinDetailModel pay =
                            this.clientPayIndetailModel[index];
                        return createListViewPayinItems(pay);
                      });
                }
              } else {
                return LinearProgressIndicator();
              }
            }),
      ),

      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent[400],
        onPressed: () {
          Navigator.pushNamed(context, MyConstant.routeClientAddNewPayBill);
        },
      ),
    );
  }

  Container createListViewPayinItems(ClientPayinDetailModel pay) {
    return Container(
        height: 100,
        child: Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(width: 32, child: Icon(Icons.done)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          //width: 250,
                          child: Text(
                            pay.description.toString(),
                            style: MyTextStyle.getTextStyleWhiteTitleText(
                                color: Colors.blue[800]),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Card(
                          color: Colors.orangeAccent[100],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text("ผู้เบิก"),
                                Text(
                                  pay.employee.toString(),
                                  style:
                                      MyTextStyle.getTextStyleWhiteNormalText(
                                          isBold: true,
                                          color: Colors.deepOrange[800]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.brown[100],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text("วันที่"),
                                Text(pay.datetime.toString(),
                                    style:
                                        MyTextStyle.getTextStyleWhiteNormalText(
                                            isBold: true, color: Colors.brown)),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.yellowAccent[100],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text("ยอดเบิกเงิน"),
                                Text(pay.total.toString(),
                                    style:
                                        MyTextStyle.getTextStyleWhiteNormalText(
                                            isBold: true,
                                            color: Colors.yellow[900])),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  int loadCountNull = 0;
  List<ClientPayinDetailModel> clientPayIndetailModel = [];
  Future<List<ClientPayinDetailModel>> getClientPayInDetailModel() async {
    String url = MyConstant.apiDomainName.toString() +
        "/paybill_detail.php?client=" +
        MyConstant.currentClientID.toString();

    print(url);
    Dio().get(url).then((value) {
      //-- decode
      var items = json.decode(value.data);

      if (items.toString().toLowerCase().compareTo("null") == 0) {
        this.loadCountNull++;
      } else {
        //-- for loop items
        clientPayIndetailModel.clear();
        for (var item in items) {
          print("model : " + item.toString());
          //--
          try {
            this
                .clientPayIndetailModel
                .add(ClientPayinDetailModel.fromMap(item));
          } catch (err) {}
        }
      }
    });

    print("load count = " + this.loadCountNull.toString());
    return this.clientPayIndetailModel;
  }
}
