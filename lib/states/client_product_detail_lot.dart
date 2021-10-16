import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_product_lot.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductDetailLOT extends StatefulWidget {
  const ClientProductDetailLOT({Key? key}) : super(key: key);

  @override
  _ClientProductDetailLOTState createState() => _ClientProductDetailLOTState();
}

class _ClientProductDetailLOTState extends State<ClientProductDetailLOT> {
  Timer? timer;

  void doSetState() {
    this.setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //his.getCleintProductDetailGeneralModel();
    this.getClientProductLOTModel();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => doSetState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("สต็อกสินค้า"),
        backgroundColor: Colors.brown[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyConstant.routeClientHome);
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.home),
      ),
      body: FutureBuilder(
          future: this.getClientProductLOTModel(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("insert futuer builder...");
            print("**** has data " + snapshot.hasData.toString());
            if (snapshot.hasData) {
              if (this.clientProductLOTModelList.length == 0) {
                return LinearProgressIndicator();
              }

              //--
              try {
                print("cancel timer");
                this.timer!.cancel();
              } catch (Exception) {}

              return ListView.builder(
                  itemCount: this.clientProductLOTModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("จำนวนแถว ที่พบ : " +
                        this.clientProductLOTModelList.length.toString());

                    ClientProductDetailLOTModel item =
                        this.clientProductLOTModelList[index];
                    print("in listview : " + index.toString());
                    return Card(
                        child: Row(
                      children: [
                        Container(
                            width: 70,
                            child: Image.asset("images/noimage.png")),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name.toString(),
                              style: MyTextStyle.getTextStyleWhiteTitleText(
                                  color: Colors.red[400]),
                            ),
                            Container(
                              //color: Colors.yellowAccent[100],
                              child: Row(
                                children: [
                                  Card(
                                    //color: Colors.tealAccent[100],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        children: [
                                          Text("ล็อต"),
                                          Text(
                                            item.lot.toString(),
                                            style: MyTextStyle
                                                .getTextStyleWhiteNormalText(
                                                    isBold: true,
                                                    color:
                                                        Colors.blueGrey[800]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Card(
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 10),
                                  //     child: Column(
                                  //       children: [
                                  //         Text("วันที่"),
                                  //         Text(item.datetime.toString()),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        children: [
                                          Text("จำนวนรับ"),
                                          Text(
                                            item.quantity.toString(),
                                            style: MyTextStyle
                                                .getTextStyleWhiteNormalText(
                                                    isBold: true,
                                                    color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    //color:Colors.amber
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        children: [
                                          Text("คงเหลือ"),
                                          Text(
                                            item.remain.toString(),
                                            style: MyTextStyle
                                                .getTextStyleWhiteNormalText(
                                                    isBold: true,
                                                    color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
                  });
            } else {
              return LinearProgressIndicator();
            }
          }),
      bottomNavigationBar: this.createButtomNavigatorBar(context),
    );
  }

  int currentPageIndex = 2;
  BottomNavigationBar createButtomNavigatorBar(BuildContext context) {
    return new BottomNavigationBar(
      backgroundColor: Colors.brown[100],
      currentIndex: this.currentPageIndex,
      //fixedColor: Colors.redAccent[100],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,

      onTap: (tabIndex) {
        // print("tab index = "+tabIndex.toString());
        switch (tabIndex) {
          case 0:
            Navigator.pushNamed(context, MyConstant.routeClientProductDetail);
            break;
          case 1:
            Navigator.pushNamed(
                context, MyConstant.routeClientProductDetailPrice);
            break;
          // case 2:
          //   Navigator.pushNamed(
          //       context, MyConstant.routeClientProductDetailLOT);
          //   break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.comment),
          title: Text(
            'ทั่วไป',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.price_change),
          title: Text('ราคาสินค้า'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          title: Text('สต็อกสินค้า'),
        ),
      ],
    );
  }

  List<ClientProductDetailLOTModel> clientProductLOTModelList = [];
  Future<List<ClientProductDetailLOTModel>> getClientProductLOTModel() async {
    String url = MyConstant.apiDomainName.toString() +
        "/product_lot.php?client=" +
        MyConstant.currentClientID.toString() +
        "&id=" +
        MyConstant.currentProductID.toString();

    print("URL ->" + url.toString());

    Dio().get(url).then((value) {
      var items = json.decode(value.data);
      clientProductLOTModelList.clear();
      for (var item in items) {
//--
        //print("before convert model : "+item.toString());
        ClientProductDetailLOTModel model =
            ClientProductDetailLOTModel.fromMap(item);
        //print("after convert model : " + model.toString());
        clientProductLOTModelList.add(model);
      }
    });

    print("all object : " + this.clientProductLOTModelList.length.toString());
    return clientProductLOTModelList;
  }
}
