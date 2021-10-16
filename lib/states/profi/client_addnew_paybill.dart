import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:topmaket/lookup/client_pay_items_listview.dart';
import 'package:topmaket/lookup/client_supplier_listview.dart';
import 'package:topmaket/models/lookup/client_pay_items_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_lookup.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientAddNewPayBill extends StatefulWidget {
  ClientAddNewPayBill({Key? key}) : super(key: key);

  @override
  _ClientAddNewPayBillState createState() => _ClientAddNewPayBillState();
}

class _ClientAddNewPayBillState extends State<ClientAddNewPayBill> {
  final _formKey = GlobalKey<FormState>();
  //--

  TextEditingController txtSuppierName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  TextEditingController txtPrice = new TextEditingController();
  TextEditingController txtQuantity = new TextEditingController();
  TextEditingController txtSumPrice = new TextEditingController();
  TextEditingController txtDocumentNo = new TextEditingController();
  TextEditingController txtRemark = new TextEditingController();

  String? selectedItemID;
  String? selectedIitemNameCheck;
  void setPayItemData(String itemID, String itemName) {
    txtDescription.text = itemName;
    selectedIitemNameCheck = itemName;
    selectedItemID = itemID;
  }

  String? supplierID;
  String? supplierNameCheck;
  void setPaySupplierData(String itemID, String itemName) {
    this.txtSuppierName.text = itemName;
    this.supplierNameCheck = itemName;
    this.supplierID = itemID;
  }
  //--

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        //title: Text("รายละเอียดการจ่ายบิล"),
      ),
      body: SingleChildScrollView(child: buildNewPayBillDetail()),
    );
  }

  Container buildNewPayBillDetail() {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: new Padding(
          padding: EdgeInsets.all(20),
          child: new Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                //-- global key ยังไม่เข้าใจวา concetp คืออะไร
                key: _formKey,

                child: Column(
                  children: [
                    Text(
                      "รายละเอียดค่าใช้จ่าย",
                      style: MyTextStyle.getTextStyleWhiteTitleText(
                          color: Colors.black54),
                    ),
                    SizedBox(height: 5),
                    this.buildTextFormFieldPayTo(),
                    SizedBox(height: 5),
                    this.buildTextFormFieldDesc(),
                    SizedBox(height: 5),
                    this.buildTextFormFieldUnitPrice(),
                    SizedBox(height: 5),
                    this.buildTextFormFieldUnitQuantity(),
                    SizedBox(height: 5),
                    this.buildTextFormFieldUnitSumPrice(),
                    SizedBox(height: 5),
                    this.buildTextFormFieldDocumentNo(),
                    SizedBox(height: 5),
                    this.buildTextFormFieldRemark(),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: this.saveNewPayBill,
                        child: Text(
                          "บันทึกค่าใช้จ่าย",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void calculteSumPrice() {
    try {
      this.setState(() {
        double price = double.parse(this.txtPrice.text.toString());
        int quantity = int.parse(this.txtQuantity.text.toString());
        double sumPrice = price * quantity;
        txtSumPrice.text = sumPrice.toString();
      });
    } catch (ex) {
      txtSumPrice.text = "0.00";
    }
  }

  TextFormField buildTextFormFieldPayTo() {
    return TextFormField(
      //-- ตัวแปร
      controller: txtSuppierName,

      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "กรุณาระบุช่องจ่ายให้";
        }

        return null;
      },
      //restorationId: 'name_field',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        //icon: const Icon(Icons.home_outlined),
        suffixIcon: IconButton(
            onPressed: () {
              ClientSupplierListView pagePayItems =
                  new ClientSupplierListView(setModel: this.setPaySupplierData);

              MaterialPageRoute payItemsRoute =
                  MaterialPageRoute(builder: (BuildContext context) {
                return pagePayItems;
              });

              //Navigator.pushNamed(context, MyLookup.lookupPayItems);
              Navigator.of(context).push(payItemsRoute);
            },
            icon: Icon(Icons.search)),
        hintText: "จ่ายให้",
        hintStyle: MyTextStyle.getTextStyleHintText(),
        labelText: "จ่ายให้",
      ),
      onSaved: (value) {},
      onChanged: (String text) {
        if (text.compareTo(this.supplierNameCheck!) != 0) {
          this.selectedItemID = "";
        }
      },
      //obscureText: true,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      //alidator: _validateName,
    );
  }

  TextFormField buildTextFormFieldDesc() {
    return TextFormField(
      controller: txtDescription,

      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "กรุณาระบุช่องรายการ";
        }

        return null;
      },
      //restorationId: 'name_field',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        //icon: const Icon(Icons.message),
        hintText: "รายการ",
        labelText: "รายการ",

        suffixIcon: IconButton(
            onPressed: () {
//-- เปิดหน้าต่างค้นหา ค่าใช้จ่าย
              print("Click ค้นหา ค่าใช้จ่าย");

              ClientPayItemsListView pagePayItems =
                  new ClientPayItemsListView(setModel: this.setPayItemData);

              MaterialPageRoute payItemsRoute =
                  MaterialPageRoute(builder: (BuildContext context) {
                return pagePayItems;
              });

              //Navigator.pushNamed(context, MyLookup.lookupPayItems);
              Navigator.of(context).push(payItemsRoute);
            },
            icon: Icon(Icons.search)),
      ),
      onSaved: (value) {
        print("onsave value = " + value.toString());
        //Navigator.pushNamed(context, MyLookup.lookupPayItems);
      },

      onChanged: (String text) {
        if (text.compareTo(this.selectedItemID!) != 0) {
          this.selectedItemID = "";
        }
      },

      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      //maxLines: 3,
      //alidator: _validateName,
    );
  }

  TextFormField buildTextFormFieldDocumentNo() {
    return TextFormField(
      controller: this.txtDocumentNo,

      //restorationId: 'name_field',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        //icon: const Icon(Icons.document_scanner),
        hintText: "เลขที่เอกสาร",
        labelText: "เลขที่เอกสาร",
      ),
      onSaved: (value) {},
      //alidator: _validateName,
    );
  }

  TextFormField buildTextFormFieldUnitPrice() {
    return TextFormField(
      controller: this.txtPrice,

      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "กรุณาระบุช่องราคา";
        }

        return null;
      },
      //restorationId: 'name_field',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        // icon: const Icon(Icons.price_change),
        hintText: "0.00",
        labelText: "ราคา",
      ),

      onChanged: (String text) {
        print("price : " + text.toString());
        this.calculteSumPrice();
      },
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      //alidator: _validateName,
    );
  }

  TextFormField buildTextFormFieldUnitQuantity() {
    return TextFormField(
      controller: this.txtQuantity,

      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "กรุณาระบุช่องจำนวน";
        }

        return null;
      },
      //restorationId: 'name_field',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        //icon: const Icon(Icons.document_scanner),
        hintText: "1",
        labelText: "จำนวน",
      ),
      onSaved: (value) {
        print("quantity value = " + value.toString());
      },
      onChanged: (String text) {
        print("price : " + text.toString());
        this.calculteSumPrice();
      },
      keyboardType: TextInputType.number,
      //alidator: _validateName,
    );
  }

  TextFormField buildTextFormFieldUnitSumPrice() {
    return TextFormField(
      controller: this.txtSumPrice,
      //restorationId: 'name_field',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        //icon: const Icon(Icons.price_check),
        hintText: "0.00",
        labelText: "รวมราคา",
      ),
      onSaved: (value) {},

      keyboardType: TextInputType.number,
      readOnly: true,

      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
      //inputFormatters: [FilteringTextInputFormatter.allow(".")],
      //alidator: _validateName,
    );
  }

  TextFormField buildTextFormFieldRemark() {
    return TextFormField(
      controller: this.txtRemark,
      //restorationId: 'name_field',
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        //icon: const Icon(Icons.description),
        hintText: "หมายเหตุ",
        labelText: "หมายเหตุ",
      ),
      onSaved: (value) {},
      maxLines: 4,
      //alidator: _validateName,
    );
  }

  void saveNewPayBill() {
    if (this._formKey.currentState!.validate()) {
      print("************* Validate OK ****************");

      String itemID = this.selectedItemID.toString();
      String itemName = this.txtDescription.text;
      String supplierID = this.supplierID.toString();
      String supplierName = this.txtSuppierName.text.toString();
      String price = this.txtPrice.text;
      String quantity = this.txtQuantity.text;
      String sumPrice = this.txtSumPrice.text;
      String docNo = this.txtDocumentNo.text;
      String remark = this.txtRemark.text;
      String employeeID = "1";

      String submitURL = MyConstant.apiDomainName.toString() +
          "/submit/insert_new_paybill.php" +
          "?client=183" +
          "&itemid="+itemID+"" +
          "&name="+itemName+"" +
          "&price="+price+"" +
          "&quantity="+quantity+"" +
          "&sumprice="+sumPrice+"" +
          "&remark="+remark+"" +
          "&supid="+supplierID+"" +
          "&subname="+supplierName+""+
          "&doc="+docNo+
          "&emp="+employeeID+"&bank=1";

          

          print("submit URL : "+submitURL); 


          Dio().get(submitURL).then((value) {
            var excutedMessage = value.data; 
            print("Excute Message = "+excutedMessage); 

            //widget.ref
          });
    } else {
      print("Validate NOT OK.....");
    }
  }
}
