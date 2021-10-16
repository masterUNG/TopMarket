import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:topmaket/models/lookup/client_employee_model.dart';
import 'package:topmaket/models/lookup/master_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductGroupListView extends StatefulWidget {
//String itemID, String itemName
  ClientProductGroupListView(
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
  _ClientProductGroupListViewState createState() => _ClientProductGroupListViewState();
}

class _ClientProductGroupListViewState extends State<ClientProductGroupListView> {
  Timer? timer;
  TextEditingController txtSearch = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.getMasterModelList();

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
                style: TextStyle(color:Colors.white),
                onChanged: (String text) {

                  this.setState(() {
                    
                  });
                },
              )
            : Text("เลือกกลุ่มสินค้า"),
        actions: [
          this.isSearchStatus
              ? IconButton(onPressed: () {
                this.isSearchStatus = false; 
              }, icon: Icon(Icons.cancel))
              : IconButton(onPressed: () {

                this.isSearchStatus = true; 
              }, icon: Icon(Icons.search)),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: builderListView(),
    );
  }

  FutureBuilder<List<MasterModel>>builderListView() {
    return FutureBuilder(
        future: this.getMasterModelList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (this.masterModelList.length > 0) {
                this.timer!.cancel();
            return ListView.builder(
                itemCount: this.masterModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  MasterModel item =
                      this.masterModelList[index];
                  return buildModelDataList(item, context);
                });
          } else {
            return LinearProgressIndicator();
          }
        });
  }

  Container buildModelDataList(
      MasterModel model, BuildContext context) {
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
              // Image.network(
              //   MyConstant.apiDomainName.toString() +
              //       "/asset/get_image_product_group.php?client=" +
              //       MyConstant.currentClientID.toString() +
              //       "&id=" +
              //       model.id.toString(),
              //   width: 60,
              // ),
              // SizedBox(
              //   width: 5,
              // ),
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
  List<MasterModel> masterModelList = [];
  Future<List<MasterModel>> getMasterModelList() async {
    String url = MyConstant.apiDomainName.toString() +
        "/lookup/product_group.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=" +
        this.txtSearch.text.toString();

    //print(url);
    Dio().get(url).then((value) {
      var items = json.decode(value.data);

      if (items.toString().toLowerCase().compareTo("null") == 0) {
        this.loadNullCount++;
      }
      masterModelList.clear();
      for (var item in items) {
        this
            .masterModelList
            .add(MasterModel.fromMap(item));
        //print("Model => " + item.toString());
      }
    });

    return this.masterModelList;
  }

  void refreshData() {
    this.setState(() {});
  }
}
