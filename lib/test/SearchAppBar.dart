import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topmaket/models/lookup/client_pay_items_model.dart';
import 'package:topmaket/utility/my_constant.dart';

class SearchOnAppBar extends StatefulWidget {
  const SearchOnAppBar({Key? key}) : super(key: key);

  @override
  _SearchOnAppBarState createState() => _SearchOnAppBarState();
}

class _SearchOnAppBarState extends State<SearchOnAppBar> {
  bool isSearchStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: this.isSearchStatus
            ? TextFormField(
                onChanged: (String text) {
                  setState(() {
                    this.key = text;
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "ค้นหา",
                    hintStyle: TextStyle(color: Colors.grey)),
              )
            : Text("รายการสินค้า"),
        actions: [
          this.isSearchStatus
              ? new IconButton(
                  onPressed: () {
                    print("cancen button pressed...");
                      this.key = "";
                    this.setState(
                      () {
                      
                        this.isSearchStatus = false;
                      },
                    );
                  },
                  icon: Icon(Icons.cancel),
                )
              : new IconButton(
                  onPressed: () {
                    this.setState(
                      () {
                        this.isSearchStatus = true;
                      },
                    );
                  },
                  icon: Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder(
        future: this.getClientPayItemsModel(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: this.clientPayItemsModelsList.length,
              itemBuilder: (BuildContext context, int index) {
                print("in listview builder");
                ClientPayItemsModel item = this.clientPayItemsModelsList[index];
                return Container(
                  height: 50,
                  child: Card(
                    child: Text(
                      item.name.toString(),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  List<ClientPayItemsModel> clientPayItemsModelsList = [];
  Future<List<ClientPayItemsModel>> getClientPayItemsModel() async {
    // String url = MyConstant.apiDomainName.toString() +
    //     "/lookup/pay_items.php?client=" +
    //     MyConstant.currentClientID.toString() +
    //     "&key=";
    String url = this.buildURL();
    print("url =>" + url.toString());

    Dio().get(url).then((value) {
      var items = json.decode(value.data);

      this.clientPayItemsModelsList.clear();
      for (var item in items) {
        this.clientPayItemsModelsList.add(ClientPayItemsModel.fromMap(item));
      }
    });

    return this.clientPayItemsModelsList;
  }

  String? key;
  String buildURL() {
    if (this.key != null) {
      return MyConstant.apiDomainName.toString() +
          "/lookup/pay_items.php?client=183" +
          "&key=" +
          key.toString();
    } else {
      return MyConstant.apiDomainName.toString() +
          "/lookup/pay_items.php?client=183" +
          "&key=";
    }

    //print("url => "+);
  }
}
