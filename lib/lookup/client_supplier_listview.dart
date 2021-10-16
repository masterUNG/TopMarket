import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/lookup/client_pay_items_model.dart';
import 'package:topmaket/models/lookup/client_supplier_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientSupplierListView extends StatefulWidget {
//String itemID, String itemName
  ClientSupplierListView(
      {void Function(String, String)? setModel,
      //TextEditingController? txtName,
      Key? key})
      : super(key: key) {
    //this.txtName = txtName;
    this.setModel = setModel;
  }

  String? selectedItemID;
  String? selectedItemName;
  //TextEditingController? txtName;
  void Function(String, String)? setModel;
//-- ตัวแปรลูก
  //_ClientPayItemsListViewState _childState = _ClientPayItemsListViewState();
  @override
  _ClientSupplierListViewState createState() => _ClientSupplierListViewState();
}

class _ClientSupplierListViewState extends State<ClientSupplierListView> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.getClientPayItemModelList();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
  }

  void doSetState() {
    this.setState(() {});
  }

  TextEditingController txtSearch = new TextEditingController();
  bool isSearchStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        title: this.isSearchStatus
            ? TextFormField(
                controller: this.txtSearch,
                style: TextStyle(color: Colors.white),
              )
            : Text("เลือกร้านค้า"),
        actions: [
          this.isSearchStatus
              ? IconButton(
                  onPressed: () {
                    this.setState(() {
                      this.txtSearch.text = "";
                      this.isSearchStatus = false;
                    });
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    this.setState(() {
                      this.isSearchStatus = true;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      body: builderListView(),
    );
  }

  FutureBuilder<List<ClientSupplierModel>> builderListView() {
    return FutureBuilder(
        future: this.getClientPayItemModelList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (this.clientPayItemModelList.length > 0) {
            this.timer!.cancel();
            return ListView.builder(
                itemCount: this.clientPayItemModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  ClientSupplierModel item = this.clientPayItemModelList[index];
                  return Container(
                    //alignment: AlignmentGeometry,
                    height: 70,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.setModel != null) {
                          widget.setModel!(
                              item.id.toString(), item.name.toString());
                        }
                        Navigator.pop(context);
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name.toString(),
                              style: MyTextStyle.getTextStyleWhiteTitleText(
                                  color: Colors.blue),
                            ),
                            Row(
                              children: [
                                Icon(Icons.home_outlined),
                                Text(
                                  item.address.toString() +
                                      " " +
                                      item.province.toString(),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Text("item == 0");
          }
        });
  }

  int loadNullCount = 0;
  List<ClientSupplierModel> clientPayItemModelList = [];
  Future<List<ClientSupplierModel>> getClientPayItemModelList() async {
    String url = MyConstant.apiDomainName.toString() +
        "/lookup/supplier.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=" +
        this.txtSearch.text.toString();

    print(url);
    Dio().get(url).then((value) {
      var items = json.decode(value.data);

      if (items.toString().toLowerCase().compareTo("null") == 0) {
        this.loadNullCount++;
      }
      clientPayItemModelList.clear();
      for (var item in items) {
        this.clientPayItemModelList.add(ClientSupplierModel.fromMap(item));
        //print("Model => " + item.toString());
      }
    });

    return this.clientPayItemModelList;
  }

  void refreshData() {
    this.setState(() {});
  }
}
