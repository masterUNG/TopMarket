import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/lookup/client_pay_items_listview.dart';
import 'package:topmaket/models/lookup/client_pay_items_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_lookup.dart';

class ClientPayItems extends StatefulWidget {
  const ClientPayItems({Key? key}) : super(key: key);

  @override
  _ClientPayItemsState createState() => _ClientPayItemsState();
}

class _ClientPayItemsState extends State<ClientPayItems> {
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

  //-- controller
  TextEditingController txtKey = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Column(
          children: [
            buildTextSearch(),
            new ClientPayItemsListView(),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextSearch() {
    return TextFormField(
      controller: this.txtKey,
      //restorationId: 'name_field',
      // textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        //icon: const Icon(Icons.document_scanner),
        hintText: "ค้นหา",
        suffixIcon: IconButton(
            onPressed: () {
              //--
              // if (_clientPayItemsSearch == null) {
              //   _clientPayItemsSearch = new ClientPayItemsSearch();
              // }

              /*
                    //-- สร้างตัว route
                    MaterialPageRoute? routePayItemsSearchPage =
                        MaterialPageRoute(builder: (BuildContext context) {
                      return new ClientPayItemsSearch();
                    });

                    Navigator.push(context, routePayItemsSearchPage);
                    */
              //-- เปิดหน้าต่างค้นหา ค่าใช้จ่าย
              //print("ค้นหา");
              Navigator.pushNamed(context, MyLookup.lookupPayItemsSearch);
            },
            icon: Icon(Icons.search)),
        //labelText: "ค้นหา",
      ),
      //onSaved: (value) {},
      onChanged: (String text) {},
      //alidator: _validateName,
    );
  }

  int loadNullCount = 0;
  List<ClientPayItemsModel> clientPayItemModelList = [];
  Future<List<ClientPayItemsModel>> getClientPayItemModelList() async {
    String url = MyConstant.apiDomainName.toString() +
        "/lookup/pay_items.php?client=" +
        MyConstant.currentClientID.toString() +
        "&key=";

    //print(url);
    Dio().get(url).then((value) {
      var items = json.decode(value.data);

      if (items.toString().toLowerCase().compareTo("null") == 0) {
        this.loadNullCount++;
      }
      clientPayItemModelList.clear();
      for (var item in items) {
        this.clientPayItemModelList.add(ClientPayItemsModel.fromMap(item));
        print("Model => " + item.toString());
      }
    });

    return this.clientPayItemModelList;
  }
}
