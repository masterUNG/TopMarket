import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/lookup/client_pay_items_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientPayItemsListView extends StatefulWidget {
//String itemID, String itemName
  ClientPayItemsListView(
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
  _ClientPayItemsListViewState createState() => _ClientPayItemsListViewState();
}

class _ClientPayItemsListViewState extends State<ClientPayItemsListView> {
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
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        shadowColor: Colors.brown[400],
        title: TextFormField(
          controller: this.txtSearch,
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
              hintText: "ค้นหารายการ",
              hintStyle: MyTextStyle.getTextStyleWhiteSubTitleText()),
          onChanged: (String text) {
            this.setState(() {});
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: builderListView(),
    );
  }

  FutureBuilder<List<ClientPayItemsModel>> builderListView() {
    return FutureBuilder(
        future: this.getClientPayItemModelList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (this.clientPayItemModelList.length > 0) {
            return ListView.builder(
                itemCount: this.clientPayItemModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  ClientPayItemsModel item = this.clientPayItemModelList[index];

                  this.timer!.cancel(); 
                  
                  return Container(
                    //alignment: AlignmentGeometry,
                    height: 70,
                    child: GestureDetector(
                      onTap: () {
                        // print("tab id " + item.id.toString());
                        // widget.selectedItemID =  item.id.toString();
                        // widget.selectedItemName = item.name.toString();
                        // widget.txtName!.text = item.name.toString();
                        if (widget.setModel != null) {
                          widget.setModel!(
                              item.id.toString(), item.name.toString());
                        }
                        Navigator.pop(context);
                      },
                      child: Card(
                        child: Text(
                          item.name.toString(),
                          style: MyTextStyle.getTextStyleWhiteTitleText(
                              color: Colors.red),
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
  List<ClientPayItemsModel> clientPayItemModelList = [];
  Future<List<ClientPayItemsModel>> getClientPayItemModelList() async {
    String url = MyConstant.apiDomainName.toString() +
        "/lookup/pay_items.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=" +
        this.txtSearch.text.trim();

    print(url);
    Dio().get(url).then((value) {
      var items = json.decode(value.data);

      if (items.toString().toLowerCase().compareTo("null") == 0) {
        this.loadNullCount++;
      }
      clientPayItemModelList.clear();
      for (var item in items) {
        this.clientPayItemModelList.add(ClientPayItemsModel.fromMap(item));
        //print("Model => " + item.toString());
      }
    });

    return this.clientPayItemModelList;
  }

  void refreshData() {
    this.setState(() {});
  }
}
