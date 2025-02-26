import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/payin_detail_model.dart';
import 'package:topmaket/states/profi/client_addnew_payIn.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientPayinDetail extends StatefulWidget {
  const ClientPayinDetail({Key? key}) : super(key: key);

  @override
  _ClientPayinDetailState createState() => _ClientPayinDetailState();

  //--

}

class _ClientPayinDetailState extends State<ClientPayinDetail> {
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

  void refreshListView() {

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
      body: SafeArea(
        //child: Container(),

        child: FutureBuilder(
            future: this.getClientPayInDetailModel(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              int length = this.clientPayIndetailModel.length;
              print("load count = " +
                  this.loadCount.toString() +
                  " Item.length =" +
                  length.toString());
              if (this.loadCount > 3 && length == 0) {
                print("สิ้นสุดการ Load ...");
                this.timer!.cancel();
                return Center(
                    child: Text("ไม่มีรายการเบิกเงิน",
                        style: TextStyle(color: Colors.red, fontSize: 16)));
              }
              if (snap.hasData) {
                if (this.clientPayIndetailModel.length == 0) {
                  return LinearProgressIndicator();
                } else {
                  //this.timer!.cancel();
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
        backgroundColor: Colors.redAccent[400],
        child: Icon(Icons.add),
        onPressed: () {
          ClientAddNewPayIn addNewPayInPage =
              new ClientAddNewPayIn(refreshListView: this.refreshListView,);

          MaterialPageRoute materialRoute =
              MaterialPageRoute(builder: (BuildContext context) {
            return addNewPayInPage;
          });

          //Navigator.pushNamed(context, MyLookup.lookupPayItems);
          Navigator.of(context).push(materialRoute);
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

  int loadCount = 0;

  List<ClientPayinDetailModel> clientPayIndetailModel = [];
  Future<List<ClientPayinDetailModel>> getClientPayInDetailModel() async {
    String url = MyConstant.apiDomainName.toString() +
        "/payin_detail.php?client=" +
        MyConstant.currentClientID.toString();

    print(url);
    Dio().get(url).then((value) {
      //-- decode
      var items = json.decode(value.data);
      //print("decoded items => "+items.toString());
      //-- for loop items
      if (items.toString().toLowerCase().compareTo("null") == 0) {
        loadCount++;
      } else {
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
    print("load count = " + this.loadCount.toString());
    return this.clientPayIndetailModel;
  }
}
