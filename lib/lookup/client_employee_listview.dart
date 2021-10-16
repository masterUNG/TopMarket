import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/lookup/client_employee_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientEmployeeListView extends StatefulWidget {
//String itemID, String itemName
  ClientEmployeeListView(
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
  _ClientEmployeeListViewState createState() => _ClientEmployeeListViewState();
}

class _ClientEmployeeListViewState extends State<ClientEmployeeListView> {
  Timer? timer;
  TextEditingController txtSearch = new TextEditingController();
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
            : Text("เลือกพนักงาน"),
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

  FutureBuilder<List<ClientLookupEmployeeModel>> builderListView() {
    return FutureBuilder(
        future: this.getClientPayItemModelList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (this.clientPayItemModelList.length > 0) {
            this.timer!.cancel(); 
            return ListView.builder(
                itemCount: this.clientPayItemModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  ClientLookupEmployeeModel item =
                      this.clientPayItemModelList[index];
                  return buildEmployeeCard(item, context);
                });
          } else {
            //return Text("item == 0");
            return LinearProgressIndicator();
          }
        });
  }

  Container buildEmployeeCard(
      ClientLookupEmployeeModel item, BuildContext context) {
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
            widget.setModel!(item.id.toString(), item.name.toString());
          }
          Navigator.pop(context);
        },
        child: Card(
          child: Row(
            children: [
              Image.network(
                MyConstant.apiDomainName.toString() +
                    "/getproduct_empicon.php?client=" +
                    MyConstant.currentClientID.toString() +
                    "&id=" +
                    item.id.toString(),
                width: 60,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name.toString(),
                    style: MyTextStyle.getTextStyleWhiteTitleText(
                        color: Colors.blue),
                  ),
                  Row(
                    children: [
                      Icon(Icons.assignment_ind_outlined),
                      Text(
                        item.dep.toString(),
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.home_outlined),
                      Text(
                        item.province.toString(),
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
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
  List<ClientLookupEmployeeModel> clientPayItemModelList = [];
  Future<List<ClientLookupEmployeeModel>> getClientPayItemModelList() async {
    String url = MyConstant.apiDomainName.toString() +
        "/lookup/employee.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=" +
        this.txtSearch.text.toString();

    //print(url);
    Dio().get(url).then((value) {
      var items = json.decode(value.data);

      if (items.toString().toLowerCase().compareTo("null") == 0) {
        this.loadNullCount++;
      }
      clientPayItemModelList.clear();
      for (var item in items) {
        this
            .clientPayItemModelList
            .add(ClientLookupEmployeeModel.fromMap(item));
        //print("Model => " + item.toString());
      }
    });

    return this.clientPayItemModelList;
  }

  void refreshData() {
    this.setState(() {});
  }
}
