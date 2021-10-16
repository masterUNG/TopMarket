import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_sale_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:intl/intl.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientSale extends StatefulWidget {
  const ClientSale({Key? key}) : super(key: key);

  @override
  _ClientSaleState createState() => _ClientSaleState();
}

class _ClientSaleState extends State<ClientSale> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('en');

  Timer? timer;

  String? _clientID;
  String? _clientName;

  bool _isSearch = false;
  TextEditingController txtSearch = new TextEditingController();
  FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
  }

  void doSetState() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    this._clientID = MyConstant.currentClientID.toString();
    this._clientName = MyConstant.currentClientName.toString();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        title: this._isSearch
            ? TextFormField(
                style: MyTextStyle.getTextStyleWhiteNormalText(),
                decoration: InputDecoration(),
                controller: this.txtSearch,
                focusNode: this.focusNode,
                onChanged: (String text) {
                  print("on chagne Text = " + text.toString());
                  this.setState(() {});
                },
              )
            : Text(this._clientName.toString() + ""),
        backgroundColor: Colors.brown[200],
        actions: [
          this._isSearch
              ? IconButton(
                  onPressed: () {
                    //--
                    this.setState(() {
                      this.txtSearch.text = "";
                      this._isSearch = !this._isSearch;
                    });
                  },
                  icon: Icon(Icons.cancel),
                )
              : IconButton(
                  onPressed: () {
                    //--
                    this.setState(() {
                      this._isSearch = !this._isSearch;
                      this.focusNode.requestFocus();
                    });
                  },
                  icon: Icon(Icons.search),
                ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          //-- function จะทำการ Load data จาก Server
          future: this.loadSaleDataCleintFromServer(),
          //-- หลังจากโหลดเสร็จแล้ว ก็ให้ทำการ Builder
          builder: (context, snapShotData) {
            //print("snap.hasData : " + snapShotData.hasData.toString());
            //print("snap.hasData.length : " +
            this.clientSaleList.length.toString();
            if (snapShotData.hasData) {
              if (this.clientSaleList.length == 0) {
                return LinearProgressIndicator(backgroundColor: Colors.brown[200], color: Colors.brown[400]);
              } else {
                try {
                  this.timer!.cancel();
                } catch (error) {}
                return Container(
                  //color: Colors.grey[100],
                  child: createSaleListViewBuilder(),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  ListView createSaleListViewBuilder() {
    return ListView.builder(
      itemCount: this.clientSaleList.length,
      itemBuilder: (context, index) {
        ClientSaleModel sale = this.clientSaleList[index];

        return GestureDetector(
          onTap: () {
            //print("TAB@SaleID : " + sale.id.toString());
            MyConstant.currentSaleID = sale.id.toString();
            Navigator.pushNamed(context, MyConstant.routerClientSaleDetial);
          },
          child: Card(
            //color: Colors.limeAccent[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    //color: Colors.blueGrey,
                    //alignment: Alignment.bottomRight,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 16,
                            child: Image.asset("images/success.png")),
                        // Image.asset(""),
                        Text(
                          sale.id.toString() + "  ",
                          style: TextStyle(color: Colors.green),
                        ),
                        Container(
                            width: 16,
                            child: Image.asset("images/time8416.png")),
                        Text(
                          sale.datetime.toString(),
                          style: TextStyle(color: Colors.lightGreen),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    //color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "" + sale.getFinalPriceFormatted().toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.yellowAccent,
                    // alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: createSummaryButtomDetail(sale))),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row createSummaryButtomDetail(ClientSaleModel sale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          color: Colors.limeAccent[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("พนง.ขาย", style: TextStyle(color: Colors.grey)),
                    Text(
                      sale.employee.toString(),
                      style: TextStyle(
                          color: Colors.lime[600], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.orange[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("รวม", style: TextStyle(color: Colors.grey)),
                    Text(
                      sale.price.toString(),
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.yellow[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("ส่วนลด", style: TextStyle(color: Colors.grey)),
                    Text(
                      sale.discount.toString(),
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.yellow[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("ทุน", style: TextStyle(color: Colors.grey)),
                    Text(
                      sale.cost.toString(),
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.green[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("กำไร", style: TextStyle(color: Colors.grey)),
                    Text(
                      sale.profit.toString(),
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Card createHeaderSummary() {
    return Card(
      child: Column(children: [
        Text(
          "ยอดขายปัจจุบัน " + this._clientName.toString(),
          style: TextStyle(color: Colors.blue[200]),
        ),
        Text(
          "0.00",
          style: TextStyle(
              color: Colors.blue[900],
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }

//-- หมายเลข Client
  String? clientID;
  //-- object sale
  List<ClientSaleModel> clientSaleList = [];

  Future<List<ClientSaleModel>> loadSaleDataCleintFromServer() async {
    String url = MyConstant.apiDomainName.toString() +
        "/sale.php?id=" +
        this._clientID.toString() +
        "&key=" +
        this.txtSearch.text.toString();
    print("Url : " + url);
    //print(url);
    Dio().get(url).then((value) {
      //--
      var saleItems = json.decode(value.data);

      this.clientSaleList.clear();
      for (var item in saleItems) {
        ClientSaleModel sale = ClientSaleModel.fromMap(item);
        this.clientSaleList.add(sale);
      }

      return this.clientSaleList;
    });

    return [];
  }
}
