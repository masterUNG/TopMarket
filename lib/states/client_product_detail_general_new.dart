import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:topmaket/lookup/client_product_brand_listview.dart';
import 'package:topmaket/lookup/client_product_group_listview.dart';
import 'package:topmaket/lookup/client_product_type_listview.dart';
import 'package:topmaket/lookup/client_product_unit_listview.dart';
import 'package:topmaket/models/client_product_detail_general_model.dart';
//mport 'package:topmaket/models/product_best_price_model.dart';
import 'package:topmaket/utility/action_type.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';
//-- image
//import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ClientProductDetailGeneralNew extends StatefulWidget {
  ActionType? actionType;
  ClientProductDetailGeneralNew({ActionType? actionType, Key? key})
      : super(key: key) {
    this.actionType = actionType;
  }

  @override
  _ClientProductDetailGeneralNewState createState() =>
      _ClientProductDetailGeneralNewState();
}

class _ClientProductDetailGeneralNewState
    extends State<ClientProductDetailGeneralNew> {
  int currentPageIndex = 0;

  //--
  ClientProductDetailGeneralModel?
      model; // = new ClientProductDetailGeneralModel();

  Timer? timer; //  = null;
  //-- contorller
  TextEditingController txtType = new TextEditingController();
  TextEditingController txtGroup = new TextEditingController();
  TextEditingController txtID = new TextEditingController();
  TextEditingController txtBarcode = new TextEditingController();
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtDesc = new TextEditingController();
  TextEditingController txtBrand = new TextEditingController();
  TextEditingController txtUnit = new TextEditingController();
  //- stock
  TextEditingController txtStockRemain = new TextEditingController();
  TextEditingController txtStockMin = new TextEditingController();
  TextEditingController txtStockMax = new TextEditingController();

  TextEditingController txtCost = new TextEditingController();
  TextEditingController txtPrice = new TextEditingController();

  //- auto fucus
  FocusNode _focusType = new FocusNode();
  FocusNode _focusBrand = new FocusNode();
  FocusNode _focusUnit = new FocusNode();
  FocusNode _focusCost = new FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    txtStockRemain.text = "0";
    this.model = new ClientProductDetailGeneralModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        title: Text("รายละเอียดสินค้า"),
        backgroundColor: Colors.brown[200],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, MyConstant.routeClientHome);
      //   },
      //   backgroundColor: Colors.orange,
      //   child: Icon(Icons.home),
      // ),
      body: createProductDetailFutureBuilder(),
      //bottomNavigationBar: createButtomNavigatorBar(context),
    );
  }

  SingleChildScrollView createProductDetailFutureBuilder() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //LinearProgressIndicator(),
          createClientProductDetailGeneral(),
        ],
      ),
    );
  }

  //ClientProductDetailGeneralModel model = new ClientProductDetailGeneralModel();
  SafeArea createClientProductDetailGeneral() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: this._formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Container(
                    color: Colors.red,
                    height: 250,
                    child: GestureDetector(
                        onTap: () {
                          this._showImageDialog();
                        },
                        child: this.getImageAndCrop()),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "ช้อมูลทั่วไป",
                          style: MyTextStyle.getTextStyleWhiteTitleText(
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextName(),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextBarcode(),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextGroup(),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextType(),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "หน่วยและยี่ห้อ",
                          style: MyTextStyle.getTextStyleWhiteTitleText(
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextBrand(),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextUnit(),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextCost(),
                        SizedBox(
                          height: 10,
                        ),
                        this.builtTextSale(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "สต็อกและอื่นๆ",
                        style: MyTextStyle.getTextStyleWhiteTitleText(
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      this.builtTextDescription(),
                      SizedBox(
                        height: 10,
                      ),
                      this.builtTextStockRemain(),
                      SizedBox(
                        height: 10,
                      ),
                      this.builtTextStockMin(),
                      SizedBox(
                        height: 10,
                      ),
                      this.builtTextStockMax(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
                Container(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: this.postProductForm, // this.insertProudctApi,

                    child: Text(
                      "บันทึกสินค้า",
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

  Image getImageAndCrop() {
    if (this.imageFile != null) {
      return Image.file(
        this.imageFile!,
        height: 200,
        fit: BoxFit.fill,
      );
    } else {
      return Image.asset(
        "images/noimage.png",
        height: 200,
        fit: BoxFit.cover,
      );

    }
  }

  void postProductForm() async {
    print("in postProductForm ");
    if (this._formKey.currentState!.validate()) {
      //--[1.] Bild post data
      FormData postData = FormData.fromMap({
        "client": MyConstant.currentClientID.toString(),
        "barcode": this.model!.barcode.toString(),
        "name": txtName.text.trim(),
        "cost": txtCost.text.toString(),
        "price": this.model!.price.toString(),
        "type": this.model!.typeid.toString(),
        "unit": this.model!.unitid.toString(),
        "brand": this.model!.brandid.toString(),
        "isenablepackaging": "Y",
        "min": txtStockMin.text,
        "max": txtStockMax.text,
        "istaxexemption": "N",
        "image": await MultipartFile.fromFile(this.imageFile!.path.toString(),
            filename: "imagename.jpg"),
      });

      print("Dio dio = new Dio(); ");
      //--[2.] create dio object
      Dio dio = new Dio();

      //--[3.] create url to poast
      String url = MyConstant.apiDomainName.toString() +
          "/submit/insert_product_post.php";
      print("POST TO " + url);
      //--[4.] post dat
      //try a

      try {
        await dio
            .post(
          url,
          data: postData,
          // optisssons: Options(contentType: 'multipart/form-data'),
        )
            .then((value) {
          //--[5] check respoinse ...
          print("Respoinse => " + value.data);

//-- show dialog result
          this.showDialogAlert();
        });
      } catch (e) {
        print("Error => " + e.toString());
      }
    }
  }


  void showDialogAlert() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('แจ้งเตือน'),
        content: const Text('บันทึกข้อมูลสินค้าเรียบร้อยแล้ว'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              Navigator.of(context).pop();

              //-- ปิดหน้าต่าง
              //Navigator.of(context).pop();

              // สั่งให้ refresh page แม่
              //this.setState(() {});
            },
            child: const Text('ฉันทราบแล้ว'),
          ),
        ],
      ),
    );
  }

  TextFormField builtTextID() {
    //if(initialText == "") initialText = "";

    return TextFormField(
      controller: txtID,
      //initialValue: initialText,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "รหัสสินค้า",
          //labelText: "ชื่อ - นามสกุล",
          //-- icon
          prefixIcon: Icon(Icons.ac_unit_sharp),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  TextFormField builtTextBarcode() {
    //if(initialText == "") initialText = "";

    return TextFormField(
      controller: txtBarcode,
      //initialValue: initialText,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),

      onChanged: (String barcode) {
        this.model!.barcode = barcode;
      },

      validator: (String? text) {
        if (text!.length == 0) {
          return "กรุณาระบุ Barcode";
        } else {
          return null;
        }
      },

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "ใส่ Barcode",
          labelText: "barcode",
          //-- icon
          prefixIcon: Icon(Icons.qr_code),
          suffixIcon: IconButton(
            onPressed: () {
              this.scanBarcodeNormal();
            },
            icon: Icon(Icons.camera_enhance_outlined),
          ),

          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      //     '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // print(barcodeScanRes);

      // this.txtBarcode.text = barcodeScanRes;
      // this.model!.barcode = barcodeScanRes;
    } catch (err) {
      barcodeScanRes = 'Failed to get platform version.';
    }

//-- ตรวจสอบอะไร บางอย่าง
    if (!mounted) return;

    // setState(() {
    //   //_scanBarcode = barcodeScanRes;
    // });
  }

  TextFormField builtTextName() {
    //if(initialText == "") initialText = "";

    return TextFormField(
      controller: txtName,

      // initialValue: initialText,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
//autofocus: true,
      onChanged: (String name) {
        this.model!.name = name;
      },

      validator: (String? text) {
        if (text!.length == 0) {
          return "กรุณาระบุชื่อสินค้า";
        } else {
          return null;
        }
      },

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "ชื่อสินค้า",
          labelText: "ชื่อสินค้า",
          //-- icon
          prefixIcon: Icon(Icons.message),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  TextFormField builtTextDescription() {
    //if(initialText == "") initialText = "";

    return TextFormField(
      controller: txtDesc,
      //initialValue: initialText,
      keyboardType: TextInputType.text,
      //minLines: 5,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),

      onChanged: (String desc) {
        this.model!.desc = desc;
      },

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "รายละเอียด",
          labelText: "รายละเอียด",
          //-- icon
          prefixIcon: Icon(Icons.backup_rounded),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  void setBrand(String? id, String? name) {
    this.model!.brandid = id;
    this.model!.brandname = name;

    this.txtBrand.text = name.toString();
    this._focusUnit.requestFocus();
  }

  TextFormField builtTextBrand() {
    return TextFormField(
      controller: txtBrand,
      //initialValue: initialText,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
      readOnly: true,

      focusNode: this._focusBrand,
      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "ยี่ห้อ",
          labelText: "ยี่ห้อ",
          //-- icon
          prefixIcon: Icon(Icons.branding_watermark),
          suffixIcon: IconButton(
            onPressed: () {
              //-- [1] สรา้ง page ที่จะเปิด
              ClientProductBrandListView pageBrand =
                  new ClientProductBrandListView(
                setModel: this.setBrand,
              );
              //--[2.] เอา object ของ page ที่จะเปิดมาทำเป็น materialPageRoute
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (BuildContext context) {
                return pageBrand;
              });
              //-- [3.] Route โดย Navigator
              Navigator.of(context).push(route);
            },
            icon: Icon(Icons.search),
          ),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),

      validator: (String? text) {
        if (text!.length == 0) {
          return "กรุณาระบุยี่ห้อสินค้า";
        } else {
          return null;
        }
      },
    );
  }

  void setUnit(String? id, String? name) {
    this.model!.unitid = id;
    this.model!.unitname = name;

    this.txtUnit.text = name.toString();

    this._focusCost.requestFocus();
  }

  TextFormField builtTextUnit() {
    //if(initialText == "") initialText = "";

    return TextFormField(
      controller: txtUnit,
      //initialValue: initialText,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
      readOnly: true,
      focusNode: this._focusUnit,
      textInputAction: TextInputAction.next,
      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
        hintText: "หน่วย",
        labelText: "หน่วย",
        //-- icon
        prefixIcon: Icon(Icons.ac_unit),
        suffixIcon: IconButton(
          onPressed: () {
            ClientProductUnitListView pageUnit = new ClientProductUnitListView(
              setModel: this.setUnit,
            );
            MaterialPageRoute route =
                MaterialPageRoute(builder: (BuildContext context) {
              return pageUnit;
            });
            Navigator.of(context).push(route);
          },
          icon: Icon(Icons.search),
        ),
        //-- เส้นขอบ
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (String? text) {
        if (text!.length == 0) {
          return "กรุณาระบุหน่วยสินค้า";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField builtTextCost() {
    //if(initialText == "") initialText = "";

    return TextFormField(
      controller: this.txtCost,
      //initialValue: initialText,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),

      onChanged: (String cost) {
        this.model!.cost = cost;
      },
      focusNode: this._focusCost,
      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
        hintText: "ราคาทุน",
        labelText: "ราคาทุน",
        //-- icon
        prefixIcon: Icon(Icons.price_check),

        //-- เส้นขอบ
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (String? text) {
        if (text!.length == 0) {
          return "กรุณาระบุราคาทุน";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField builtTextSale() {
    //if(initialText == "") initialText = "";

    return TextFormField(
        controller: this.txtPrice,
        //initialValue: initialText,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        //-- กำหนด  Styel ------
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
        onChanged: (String price) {
          this.model!.price = price;
        },
        //focusNode: this._focusCost,
        //-- ตกแต่งรูปแบบ -------
        decoration: InputDecoration(
          hintText: "ราคาขาย",
          labelText: "ราคาขาย",
          //-- icon
          prefixIcon: Icon(Icons.price_check_sharp),

          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (String? text) {
          if (text!.length == 0) {
            return "กรุณาระบุราคาขายf";
          } else if (text.length > 0) {
            try {
              int.parse(text);
            } catch (Err) {
              return "กรุณาระบุราคาขายเป็นตัวเลข";
            }
          } else {
            return null;
          }
        });
  }

  void setType(String? id, String? name) {
    this.model!.typeid = id;
    this.model!.typename = name;

    this.txtType.text = name.toString();

    this._focusBrand.requestFocus();
  }

  TextFormField builtTextType() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
      controller: txtType,
      //initialValue: "ทดสอบค่า",
      focusNode: this._focusType,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),
      readOnly: true,
      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "ประเภท",
          labelText: "ประเภท",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

          //-- icon
          prefixIcon: Icon(Icons.select_all),
          //--
          suffixIcon: IconButton(
            onPressed: () {
              //-- การสร้าง Page Route
              //print("current group ID : " + this.model.groupid.toString());
              //-- [1] สร้าง Object ของ Page Widget  ที่จะเปิด ขึ้นมาก่อน
              ClientProductTypeListView pageType =
                  new ClientProductTypeListView(
                setModel: this.setType,
                productGroupID: this.model!.groupid.toString(),
              );

              //-- [2] สร้าง Object MaterialPageROute ขึ้นมา เป็นตัว route โดยเอา page มา เป็น  paramenter
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (BuildContext context) {
                return pageType;
              });

//-- เปิด page ใหม่
              Navigator.of(context).push(route);
            },
            icon: Icon(Icons.search),
          ),

          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),

      validator: (String? text) {
        if (text!.length == 0) {
          return "กรุณาระบุประเภท";
        } else {
          return null;
        }
      },
    );
  }

  void setGroup(String? id, String? name) {
    this.model!.groupname = name;
    this.model!.groupid = id;
    txtGroup.text = name.toString();

    this._focusType.requestFocus();

    // this.setState(() {
    //   //print("");
    //   this.model.groupname = name;
    //   this.model.groupid = id;
    //   //this.txtGroup.text = name!;
    // });
  }

  TextFormField builtTextGroup() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
      controller: this.txtGroup,
      //initialValue: "ทดสอบค่า",

      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),

      readOnly: true,

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "กลุ่มสินค้า",
          labelText: "กลุ่มสินค้า",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

          //-- icon
          prefixIcon: Icon(Icons.select_all),
          //--
          suffixIcon: IconButton(
            onPressed: () {
//--[1] page ที่ต้องกรมาก่อน
              ClientProductGroupListView pageGroupListView =
                  new ClientProductGroupListView(
                setModel: this.setGroup,
              );

//--[2] สร้าง MaterialPageRoute เพื่อเป็ฯ Route
              MaterialPageRoute pageOpenMasterList =
                  MaterialPageRoute(builder: (BuildContext context) {
                return pageGroupListView;
              });

              //--[3] เปิดหน้า Popup
              Navigator.of(context).push(pageOpenMasterList);
            },
            icon: Icon(Icons.search),
          ),

          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
      validator: (String? text) {
        if (text!.length == 0) {
          return "กรุณาระบุราคาขายเป็นตัวเลข";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField builtTextStockRemain() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
      controller: txtStockRemain,
      //initialValue: "ทดสอบค่า",

      //initialValue: "0",

      keyboardType: TextInputType.text,
      readOnly: true,
      //-- กำหนด  Styel ------
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "สต็อกคงเหลือ",
          labelText: "สต็อกคงเหลือ",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

          //-- icon
          prefixIcon: Icon(Icons.add_box),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  TextFormField builtTextStockMin() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
        controller: txtStockMin,
        //initialValue: "ทดสอบค่า",

        keyboardType: TextInputType.number,
        //-- กำหนด  Styel ------
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red[700],
        ),
        onChanged: (String value) {
          this.model!.min = value;
        },

        //-- ตกแต่งรูปแบบ -------
        decoration: InputDecoration(
            hintText: "จุดสั่งซื้อ(สต็อกต่ำสุด)",
            labelText: "จุดสั่งซื้อ(สต็อกต่ำสุด)",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

            //-- icon
            prefixIcon: Icon(Icons.hourglass_empty),
            //-- เส้นขอบ
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(10),
            )),
        validator: (String? text) {
          try {
            return null;
          } catch (Error) {
            return "กรุณาระบุจำนวนสต็อกต่ำสุด";
          }
        });
  }

  TextFormField builtTextStockMax() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
        controller: txtStockMax,
        //initialValue: "ทดสอบค่า",

        keyboardType: TextInputType.number,
        //-- กำหนด  Styel ------
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red[700],
        ),
        onChanged: (String max) {
          this.model!.max = max;
        },

        //-- ตกแต่งรูปแบบ -------
        decoration: InputDecoration(
            hintText: "สต็อกมากสุด",
            labelText: "สต็อกมากสุด",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

            //-- icon
            prefixIcon: Icon(Icons.disc_full_outlined),
            //-- เส้นขอบ
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(10),
            )),
        validator: (String? text) {
          try {
            return null;
          } catch (Error) {
            return "กรุณาระบุจำนวนสต็อกต่ำสุด";
          }
        });
  }

  //-----------------------------
  //-- image and crop -----------
  File? imageFile;
  void _showImageDialog() {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("กรุณาเลือก"),
            content: Column(
              children: [
                InkWell(
                  onTap: () {
                    this._getFromCamera();
                  },
                  child: Row(
                    children: [
                      Padding(
                          //padding: EdgeInsets.all(4.0),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          child: Icon(
                            Icons.camera,
                            color: Colors.purple,
                          )),
                      Text(
                        "ถ่ายรูป",
                        style: TextStyle(color: Colors.purple, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    this._getFromGallery();
                  },
                  child: Row(
                    children: [
                      Padding(
                          //padding: EdgeInsets.all(4.0),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          child: Icon(
                            Icons.image,
                            color: Colors.purple,
                          )),
                      Text(
                        "เลือกจาก Gallery",
                        style: TextStyle(color: Colors.purple, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _getFromGallery() async {
    PickedFile? imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    //-- ส่งไป Crop
    this._cropImage(imageFile!.path);
    Navigator.pop(this.context);
  }

  void _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    //-- ส่งไป Crop
    this._cropImage(pickedFile!.path);
    Navigator.pop(this.context);
  }

  void _cropImage(String filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (croppedImage != null) {
      this.setState(() {
        this.imageFile = croppedImage;
      });
    }
  }
}
