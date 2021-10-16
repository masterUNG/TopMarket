import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:topmaket/lookup/client_employee_listview.dart';
import 'package:topmaket/lookup/client_pay_items_listview.dart';
// import 'package:topmaket/lookup/client_supplier_listview.dart';
// import 'package:topmaket/models/lookup/client_employee_model.dart';
// import 'package:topmaket/models/lookup/client_pay_items_model.dart';
// import 'package:topmaket/utility/my_lookup.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientAddNewPayIn extends StatefulWidget {

  ClientAddNewPayIn({void Function( )? refreshListView, Key? key}) : super(key: key) {

    //-- ตัวแปร function 
    this.refreshListView = refreshListView;
  }

  @override
  _ClientAddNewPayInState createState() => _ClientAddNewPayInState();

  void Function( )? refreshListView;
}



class _ClientAddNewPayInState extends State<ClientAddNewPayIn> {
  final _formKey = GlobalKey<FormState>();
  //--

  TextEditingController txtEmployeeName = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  TextEditingController txtPrice = new TextEditingController();
  TextEditingController txtQuantity = new TextEditingController();
  TextEditingController txtSumPrice = new TextEditingController();
  TextEditingController txtDocumentNo = new TextEditingController();
  TextEditingController txtRemark = new TextEditingController();

  String? itemID;
  String? itemNameCheck;
  void setPayItemData(String itemID, String itemName) {
    txtDescription.text = itemName;
    itemNameCheck = itemName;
    itemID = itemID;
  }

  String? employeeID;
  String? employeeNameCheck;
  void setEmployeeData(String employeeID, String employeeName) {
    this.txtEmployeeName.text = employeeName;
    this.employeeNameCheck = employeeName;
    this.employeeID = employeeID;
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
                        onPressed: () {
                          print("pressed...");

//print("Validate = "+this._formKey.currentState!.validate().toString());

                          if (this._formKey.currentState!.validate()) {
//--
                            // print("Validate = " +
                            //     this
                            //         ._formKey
                            //         .currentState!
                            //         .validate()
                            //         .toString());
                          } else {
//--
                            print("Validate OK");
                          }

                          //--
                        },
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
      controller: txtEmployeeName,

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
              ClientEmployeeListView popupEmplyeePage =
                  new ClientEmployeeListView(setModel: this.setEmployeeData);

              MaterialPageRoute payItemsRoute =
                  MaterialPageRoute(builder: (BuildContext context) {
                return popupEmplyeePage;
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
        if (text.compareTo(this.employeeNameCheck!) != 0) {
          this.employeeID = "";
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
                  new ClientPayItemsListView(setModel: this.setPayItemData  );

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
        if (text.compareTo(this.itemNameCheck!) != 0) {
          this.itemID = "";
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

      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
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
}
