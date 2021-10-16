import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_product_price2_mode.dart';
import 'package:topmaket/models/client_produt_price_model.dart';
import 'package:topmaket/states/client_product_price_detail.dart';
import 'package:topmaket/utility/my_constant.dart';

class ClientProductPrice extends StatefulWidget {
  const ClientProductPrice({Key? key}) : super(key: key);

  @override
  _ClientProductPriceState createState() => _ClientProductPriceState();
}

class _ClientProductPriceState extends State<ClientProductPrice> {
  // Timer? timer;

  // void doSetState() {
  //   print("in do state...");
  //   this.setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   //WidgetsBinding.instance!.addObserver(this);
  //   this.getClientProductPrice();

  //   timer = Timer.periodic(Duration(seconds: 2), (Timer t) => doSetState());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        title: Text("ราคาสินค้า"),
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
          future: this.getClientProductPrice(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(
                  "data length : " + this.clientProductPrice.length.toString());
              if (this.clientProductPrice.length == 0) {
                //return new LinearProgressIndicator();
                return Center(
                  child: Text(
                    "ไม่พบข้อมูล",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                // try {
                //   print("cancel time...");
                //   this.timer!.cancel();
                // } catch (Exception) {

                //   print("cancel time error....");
                // }
                return createPriceListView();
              }
            } else {
              return new LinearProgressIndicator(
                color: Colors.brown[400],
                backgroundColor: Colors.brown[200],
              );
            }
          }),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.brown[100],
        currentIndex: 1,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (int tabPageIndex) {
          switch (tabPageIndex) {
            case 0:
              Navigator.pushNamed(context, MyConstant.routeClientProductDetail);
              break;
            // case 1:
            //   Navigator.pushNamed(
            //       context, MyConstant.routeClientProductDetailPrice);
            //   break;
            case 2:
              Navigator.pushNamed(
                  context, MyConstant.routeClientProductDetailLOT);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            title: Text("ทั่วไป"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.price_change),
            title: Text("ราคาสินค้า"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: Text("สต็อกสินค้า"),
          ),
        ],
      ),
    );
  }

  ListView createPriceListView() {
    return new ListView.builder(
        itemCount: this.clientProductPrice.length,
        itemBuilder: (BuildContext context, int index) {
          ClientProdctPrice2Model price = this.clientProductPrice[index];
          return GestureDetector(
            onTap: () async {
              //-- price type id
              MyConstant.currentProductPriceTypeID =
                  price.pricetypeid.toString();

              //-- unitid
              MyConstant.currentProdctUnitID = price.unitid.toString();
              MyConstant.currentProducPriceIsPackaging =
                  price.ispackageing.toString().toUpperCase().compareTo("Y") ==
                          0
                      ? true
                      : false;

              //         //-----------
              ClientProductPriceDetail clientPriceDetail =
                  new ClientProductPriceDetail(
                      // doSetState: this.doSetState,
                      );

              MaterialPageRoute payItemsRoute =
                  MaterialPageRoute(builder: (BuildContext context) {
                return clientPriceDetail;
              });

              //Navigator.pushNamed(context, MyLookup.lookupPayItems);
              await Navigator.of(context).push(payItemsRoute);

              this.setState(() {});

            },
            child: Card(
                child: Container(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      color: Colors.yellowAccent[50],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          price.unitname.toString(),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrangeAccent),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ชื่อราคา"),
                        Text(price.name.toString(),
                            style: TextStyle(
                                color: Colors.blueAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ทุน"),
                        Text(price.cost.toString(),
                            style: TextStyle(
                                color: Colors.greenAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ขาย"),
                        Text(price.price.toString(),
                            style: TextStyle(
                                color: Colors.redAccent[400],
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          );
        });
  }

  List<ClientProdctPrice2Model> clientProductPrice = [];
  Future<List<ClientProdctPrice2Model>> getClientProductPrice() async {
    String url = MyConstant.apiDomainName.toString() +
        "/product_price.php?client=" +
        MyConstant.currentClientID.toString() +
        "&id=" +
        MyConstant.currentProductID.toString();

    print("price URL : " + url.toString());
    await Dio().get(url).then((value) {
      var items = json.decode(value.data);
      clientProductPrice.clear();
      for (var item in items) {
        this.clientProductPrice.add(ClientProdctPrice2Model.fromMap(item));
        // break;
      }
    });
    return this.clientProductPrice;
  }
}
