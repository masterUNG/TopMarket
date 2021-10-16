import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_product_detail_price_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductPriceDetail extends StatefulWidget {
  ClientProductPriceDetail(
      {String? productName, Function()? doSetState, Key? key})
      : super(key: key) {
    this.productName = productName;
    this.doSetState = doSetState;
  }

  String? productName;
  void Function()? doSetState;

  @override
  _ClientProductPriceDetailState createState() =>
      _ClientProductPriceDetailState();
}

class _ClientProductPriceDetailState extends State<ClientProductPriceDetail> {
  //-- contorller
  TextEditingController txtPackagingName = new TextEditingController();
  TextEditingController txtPackagingID = new TextEditingController();
  TextEditingController txtPriceTypeID = new TextEditingController();
  TextEditingController txtPriceTypeName = new TextEditingController();
  TextEditingController txtCost = new TextEditingController();
  TextEditingController txtPrice = new TextEditingController();
  TextEditingController txtProfit = new TextEditingController();
  TextEditingController txtProductName = new TextEditingController();
  Timer? timer;

  final _formKey = GlobalKey<FormState>();

  // void doSetState() {
  //   this.setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   this.getClientProductDetailPriceModel();

  //   timer = Timer.periodic(Duration(seconds: 4), (Timer t) => doSetState());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("รายละเอียดราคาสินค้า"),
        backgroundColor: Colors.brown[200],
      ),
      body: FutureBuilder(
          future: this.getClientProductDetailPriceModel(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //print("has data : " + snapshot.hasData.toString());
            if (snapshot.hasData) {

              
              //if(this.clientProductDetailPriceModel.unitid)
              print("Model: " + this.clientProductDetailPriceModel.toString());
              try {
                // print("UNIT ID :" +

                //     this.clientProductDetailPriceModel.unitid.toString();
                //     this.clientProductDetailPriceModel.unitid.toString());

                txtProductName.text =
                    this.clientProductDetailPriceModel.productname.toString();
                txtPackagingID.text =
                    this.clientProductDetailPriceModel.unitid.toString();
                txtPackagingName.text =
                    this.clientProductDetailPriceModel.unitname.toString();
                txtPriceTypeID.text =
                    this.clientProductDetailPriceModel.pricetypeid.toString();
                txtPriceTypeName.text =
                    this.clientProductDetailPriceModel.pricetypename.toString();
                txtCost.text =
                    this.clientProductDetailPriceModel.cost.toString();
                txtPrice.text =
                    this.clientProductDetailPriceModel.price.toString();
                //txtProfit.text = this.clientProductDetailPriceModel.pro
                double cost = double.parse(
                    this.clientProductDetailPriceModel.cost.toString());
                double sale = double.parse(
                    this.clientProductDetailPriceModel.price.toString());

                double profit = sale - cost;
                txtProfit.text = profit.toString();
                // try {
                //   this.timer!.cancel();
                // } catch (Exxx) {}
                return this.createWidgetsDetail();
              } catch (error) {
                return Center(child:Text("ไม่มีข้อมูล"));
              }
            } else {
              return LinearProgressIndicator();
            }
          }),
    );
  }

  SingleChildScrollView createWidgetsDetail() {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                this.buildTextProductName(),

                SizedBox(
                  height: 5,
                ),
                // Text(
                //   "รายละเอียดราคาสินค้า",
                //   style: MyTextStyle.getTextStyleWhiteTitleText(color: Colors.red),
                // ),
                this.buildTextPackagingName(),
                SizedBox(
                  height: 5,
                ),
                this.buildTextName(),
                SizedBox(
                  height: 5,
                ),
                this.buildTextCost(),
                SizedBox(
                  height: 5,
                ),
                this.buildTextSale(),
                SizedBox(
                  height: 5,
                ),
                this.buildTextProfit(),

                SizedBox(
                  height: 5,
                ),
                //But
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //-- todo
                      //print("click");
                      if (this._formKey.currentState!.validate()) {
                        String submitUrl = MyConstant.apiDomainName.toString() +
                            "/submit/update_product_price.php" +
                            "?client=" +
                            MyConstant.currentClientID.toString() +
                            "" +
                            "&id=" +
                            MyConstant.currentProductID.toString() +
                            "" +
                            "&unit=" +
                            this
                                .clientProductDetailPriceModel
                                .unitid
                                .toString() +
                            "" +
                            "&type=" +
                            this
                                .clientProductDetailPriceModel
                                .pricetypeid
                                .toString() +
                            "&cost=" +
                            this.txtCost.text.toString() +
                            "" +
                            "&sale=" +
                            this.txtPrice.text.toString() +
                            "" +
                            "&ispack=" +
                            this
                                .clientProductDetailPriceModel
                                .ispackaging
                                .toString();

                        Dio().get(submitUrl).then((value) {
                          String result = value.data.toString();
                          print(result);

                          this.showDialogAlert();

                          //--
                        });

                        print(submitUrl.toString());
                      } else {
                        print("validate NOt ok...");
                      }
                    },
                    child: Text(
                      "บันทึกราคา",
                      style: MyTextStyle.getTextStyleWhiteTitleText(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDialogAlert() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('แจ้งเตือน'),
        content: const Text('บันทึกราคาเรียบร้อยแล้ว'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();


              //-- ปิดหน้าต่าง
              this.popThisPage();

              // สั่งให้ refresh page แม่
              widget.doSetState!();
            },
            child: const Text('ฉันทราบแล้ว'),
          ),
        ],
      ),
    );
  }

  void popThisPage() {
    Navigator.of(context).pop();
  }

  void updatePrice() {}

  TextFormField buildTextProductName() {
    return TextFormField(
      //initialValue: widget.productName!.toString(),
      controller: txtProductName,
      keyboardType: TextInputType.text,
      readOnly: true,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "บรรจุภัณฑ์",
          hintStyle: MyTextStyle.getTextStyleHintText(),
          //hintStyle: ,
          labelText: "บรรจุภัณฑ์",
          //-- icon
          prefixIcon: Icon(Icons.message_outlined),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  TextFormField buildTextPackagingName() {
    return TextFormField(
      controller: txtPackagingName,
      keyboardType: TextInputType.text,
      readOnly: true,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "บรรจุภัณฑ์",
          hintStyle: MyTextStyle.getTextStyleHintText(),
          //hintStyle: ,
          labelText: "บรรจุภัณฑ์",
          //-- icon
          prefixIcon: Icon(Icons.add_box_outlined),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  TextFormField buildTextName() {
    return TextFormField(
      onChanged: (String tex) {
        this.setState(() {});
      },
      controller: txtPriceTypeName,
      readOnly: true,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "ชื่อราคา",
          hintStyle: MyTextStyle.getTextStyleHintText(),
          labelText: "ชื่อราคา",
          //-- icon
          prefixIcon: Icon(Icons.price_change_outlined),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  TextFormField buildTextCost() {
    return TextFormField(
      controller: txtCost,
      //textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.green[600],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: "0.00",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        labelText: "ราคาทุน",
        prefixIcon: Icon(Icons.format_list_numbered),
        suffixIcon: Icon(Icons.money),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 3,
              style: BorderStyle.solid,
              color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [],
      onChanged: (String text) {
        this.calculateProfit();
        // this.setState(() {
        //   //this.calculateProfit();
        // });
      },
      validator: (text) {
        try {
          double.parse(text.toString());
          return null;
        } catch (err) {
          return "กรุณาระบุข้อมูลเป็นตัวเลข";
        }
      },
    );
  }

  TextFormField buildTextSale() {
    return TextFormField(
      controller: txtPrice,
      //textAlign: TextAlign.right,
      style: TextStyle(
        color: Colors.red[600],
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: "0.00",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        labelText: "ราคาขาย",
        prefixIcon: Icon(Icons.format_list_numbered),
        suffixIcon: Icon(Icons.money),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 3,
              style: BorderStyle.solid,
              color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [],
      onChanged: (String text) {
        this.calculateProfit();
        // this.setState(() {

        // });
      },
      validator: (text) {
        try {
          double.parse(text.toString());

          return null;
        } catch (err) {
          return "กรุณาระบุข้อมูลเป็นตัวเลข";
        }
      },
    );
  }

  void calculateProfit() {
    try {
      double cost = double.parse(this.txtCost.text);
      double sale = double.parse(this.txtPrice.text);

      double profit = sale - cost;
      this.txtProfit.text = profit.toString();
    } catch (err) {}
  }

  TextFormField buildTextProfit() {
    return TextFormField(
      controller: txtProfit,
      //textAlign: TextAlign.right,
      readOnly: true,
      style: TextStyle(
        color: Colors.deepPurpleAccent,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: "0.00",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        labelText: "กำไร",
        prefixIcon: Icon(Icons.format_list_numbered),
        suffixIcon: Icon(Icons.money),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 3,
              style: BorderStyle.solid,
              color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [],
    );
  }

  ClientProductDetailPriceModel clientProductDetailPriceModel =
      new ClientProductDetailPriceModel();

  Future<ClientProductDetailPriceModel>
      getClientProductDetailPriceModel() async {
    String url = MyConstant.apiDomainName.toString() +
        "/product_price_packaging.php?client=" +
        MyConstant.currentClientID.toString() +
        "&id=" +
        MyConstant.currentProductID.toString() +
        "&unit=" +
        MyConstant.currentProdctUnitID.toString() +
        "&pricetypeid=" +
        MyConstant.currentProductPriceTypeID.toString() +
        "";

    print("URL : " + url.toString());
    await Dio().get(url).then((value) {
      var items = json.decode(value.data);
      for (var item in items) {
        this.clientProductDetailPriceModel =
            ClientProductDetailPriceModel.fromMap(item);
      }

      print("model : " + this.clientProductDetailPriceModel.toString());
    });
    return this.clientProductDetailPriceModel;
  }
}
