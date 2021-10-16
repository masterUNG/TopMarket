import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/lookup/client_employee_model.dart';
import 'package:topmaket/models/lookup/master_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductBrandListView extends StatefulWidget {
//String itemID, String itemName
  ClientProductBrandListView(
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
  _ClientProductBrandListViewState createState() =>
      _ClientProductBrandListViewState();
}

class _ClientProductBrandListViewState
    extends State<ClientProductBrandListView> {
  Timer? timer;
  TextEditingController txtSearch = new TextEditingController();
  @override
  void initState() {

    super.initState();

    this.getMasterData();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
  }

  void doSetState() {
    this.setState(() {});
  }

  bool isSearchStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        title: this.isSearchStatus
            ? TextFormField(
                controller: this.txtSearch,
                style: TextStyle(color: Colors.white),
                onChanged: (String text) {
                  this.setState(() {});
                },
              )
            : Text("เลือกยี่ห้อ"),
        actions: [
          this.isSearchStatus
              ? IconButton(
                  onPressed: () {
                    this.isSearchStatus = false;
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    this.isSearchStatus = true;
                  },
                  icon: Icon(Icons.search)),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: builderListView(),
    );
  }

  FutureBuilder<List<MasterModel>> builderListView() {
    return FutureBuilder(
        future: this.getMasterData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (this.masterDataModelList.length > 0) {
            this.timer!.cancel(); 
            return ListView.builder(
                itemCount: this.masterDataModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  MasterModel model = this.masterDataModelList[index];
                  return buildItemDataCard(model, context);
                });
          } else {
            //return Text("item == 0");
            return LinearProgressIndicator();
          }
        });
  }

  Container buildItemDataCard(MasterModel model, BuildContext context) {
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
            widget.setModel!(model.id.toString(), model.name.toString());
          }
          Navigator.pop(context);
        },
        child: Card(
          child: Row(
            children: [

              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    style: MyTextStyle.getTextStyleWhiteTitleText(
                        color: Colors.blue),
                  ),
       
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int loadNullCount = 0;
  List<MasterModel> masterDataModelList = [];
  Future<List<MasterModel>> getMasterData() async {
    String url = MyConstant.apiDomainName.toString() +
        "/lookup/product_brand.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=" +
        this.txtSearch.text.toString();

    print("brand URL : "+url);
    Dio().get(url).then((value) {
      
      var items = json.decode(value.data);

      if (items.toString().toLowerCase().compareTo("null") == 0) {
        this.loadNullCount++;
      }
      masterDataModelList.clear();
      for (var item in items) {
        this.masterDataModelList.add(MasterModel.fromMap(item));
        //print("Model => " + item.toString());
      }
    });

    return this.masterDataModelList;
  }

  void refreshData() {
    this.setState(() {});
  }
}
