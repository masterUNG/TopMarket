import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

//-- image
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
//--
import 'package:topmaket/lookup/client_product_brand_listview.dart';
import 'package:topmaket/lookup/client_product_group_listview.dart';
import 'package:topmaket/lookup/client_product_type_listview.dart';
import 'package:topmaket/lookup/client_product_unit_listview.dart';
import 'package:topmaket/models/client_product_detail_general_model.dart';
// import 'package:topmaket/models/product_best_price_model.dart';
// import 'package:topmaket/states/client_product_detail_general_new.dart';
import 'package:topmaket/utility/action_type.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientProductDetailGeneralModify extends StatefulWidget {
  ActionType? actionType;
  ClientProductDetailGeneralModify({ActionType? actionType, Key? key})
      : super(key: key) {
    this.actionType = actionType;
  }

  @override
  _ClientProductDetailGeneralModifyState createState() =>
      _ClientProductDetailGeneralModifyState();
}

class _ClientProductDetailGeneralModifyState
    extends State<ClientProductDetailGeneralModify> {
  int currentPageIndex = 0;

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

  // void doSetState() {
  //   this.setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   this.getCleintProductDetailGeneralModel();

  //   timer = Timer.periodic(Duration(seconds: 1), (Timer t) => doSetState());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        title: Text("รายละเอียดสินค้า"),
        backgroundColor: Colors.brown[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyConstant.routeClientHome);
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.home),
      ),
      body: createProductDetailFutureBuilder(),
      bottomNavigationBar: createButtomNavigatorBar(context),
    );
  }

  FutureBuilder<ClientProductDetailGeneralModel>
      createProductDetailFutureBuilder() {
    return FutureBuilder(
        future: this.getCleintProductDetailGeneralModel(),
        builder: (context, snap) {
          //print("********* createPageByIndex **********");
          //print("HAS DATA = "+snap.hasData.toString());
          if (snap.hasData) {
            this.txtGroup.text = this.model.groupname.toString();
            this.txtType.text = this.model.typename.toString();
            this.txtID.text = this.model.id.toString();

            this.txtBarcode.text = this.model.barcode.toString();

            this.txtName.text = this.model.name.toString();
            this.txtDesc.text = this.model.desc.toString();
            //--
            this.txtUnit.text = this.model.unitname.toString();
            //     this.txtuni.text =
            // this.clientProductDetailGeneralModel.unitname.toString();

            this.txtBrand.text = this.model.brandname.toString();

            this.txtCost.text = this.model.cost.toString();

            this.txtStockRemain.text = this.model.remain.toString();
            this.txtStockMin.text = this.model.min.toString();
            this.txtStockMax.text = this.model.max.toString();

            //print("------- HAS DATA -------");
            // if (this.model == null) {
            //   return LinearProgressIndicator();
            // } else {
            print(this.model.toString());

            try {
              // if (this.model.name!.length > 0) {
              //   try {
              //     //print("cancel timer");
              //     timer!.cancel();
              //   } catch (ex) {}
              // }

// print("****************************");
//               print("Model =>"+this.model.toString());
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //LinearProgressIndicator(),
                    createClientProductDetailGeneral(),
                  ],
                ),
              );
            } catch (err) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      color: Colors.brown[400],
                      backgroundColor: Colors.brown[200],
                    ),
                    createClientProductDetailGeneral(),
                  ],
                ),
              );
            }
            //}
          } else {
            return LinearProgressIndicator(
              color: Colors.brown[400],
              backgroundColor: Colors.brown[200],
            );
          }
        });
  }

  SafeArea createClientProductDetailGeneral() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
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
                    child: buildProductImage(),
                    //child: getImageAndCrop(),
                  ),
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
                  onPressed: this.updateProudctModelPOST,
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
    );
  }

  Image buildProductImage() {
    try {
      
      return this.imageFile != null
          ? getImageAndCrop()
          : getImageNetwork();
    } catch (err) {
      return Image.asset("images/noimage.png",
          scale: 2.0, height: 200, fit: BoxFit.fill);
    }
  }



  void updateProudctModelPOST() async {
    print("data model =>" + this.model.toString());

    String submitURL =
        MyConstant.apiDomainName.toString() + "/submit/update_product_post.php";



FormData? data ;
if(this.imageFile != null) {
  print("this.imageFile != null"); 
    data = FormData.fromMap({
      "client": MyConstant.currentClientID.toString(),
      "id": this.model.id.toString(),
      "barcode": this.model.barcode.toString(),
      "name": this.model.name.toString(),
      "cost": this.model.cost.toString(),
      "&ypeid": this.model.typeid.toString(),
      "unitid": this.model.unitid.toString(),
      "isenablepackaging=": this.model.isenablepackaging.toString(),
      "min=": this.model.min.toString(),
      "max=": this.model.max.toString(),
      "brand=": this.model.brandid.toString(),
      "model=": this.model.model.toString(),
      "desc=": this.model.desc.toString(),
      "image": await MultipartFile.fromFile(this.imageFile!.path.toString(),
          filename: "imagename.jpg"),
    });

} else {

    print("this.imageFile == null"); 
    data = FormData.fromMap({
      "client": MyConstant.currentClientID.toString(),
      "id": this.model.id.toString(),
      "barcode": this.model.barcode.toString(),
      "name": this.model.name.toString(),
      "cost": this.model.cost.toString(),
      "&ypeid": this.model.typeid.toString(),
      "unitid": this.model.unitid.toString(),
      "isenablepackaging=": this.model.isenablepackaging.toString(),
      "min=": this.model.min.toString(),
      "max=": this.model.max.toString(),
      "brand=": this.model.brandid.toString(),
      "model=": this.model.model.toString(),
      "desc=": this.model.desc.toString(),

    });
}

    print("submit utl => " + submitURL.toString());

    Dio()
        .post(
      submitURL, //-- url
      data: data, //-- formdata
    )
        .then((value) {
      print("result => " + value.data.toString());

      this.showDialogAlert();

      //-- TODO
    });

    //--TODO บันทึกข้อมุลสินค้า
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
        this.model.barcode = barcode;
      },

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "ใส่ Barcode",
          labelText: "barcode",
          //-- icon
          prefixIcon: Icon(Icons.qr_code),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(10),
          )),
    );
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

      onChanged: (String name) {
        this.model.name = name;
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
        this.model.desc = desc;
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
    this.model.brandid = id;
    this.model.brandname = name;

    this.txtBrand.text = name.toString();
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
    );
  }

  void setUnit(String? id, String? name) {
    this.model.unitid = id;
    this.model.unitname = name;

    this.txtUnit.text = name.toString();
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
    );
  }

  TextFormField builtTextCost() {
    //if(initialText == "") initialText = "";

    return TextFormField(
      controller: this.txtCost,
      //initialValue: initialText,
      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),

      onChanged: (String cost) {
        this.model.cost = cost;
      },

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
    );
  }

  void setType(String? id, String? name) {
    this.model.typeid = id;
    this.model.typename = name;

    this.txtType.text = name.toString();
  }

  TextFormField builtTextType() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
      controller: txtType,
      //initialValue: "ทดสอบค่า",

      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),

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
              print("current group ID : " + this.model.groupid.toString());
              //-- [1] สร้าง Object ของ Page Widget  ที่จะเปิด ขึ้นมาก่อน
              ClientProductTypeListView pageType =
                  new ClientProductTypeListView(
                setModel: this.setType,
                productGroupID: this.model.groupid.toString(),
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
    );
  }

  void setGroup(String? id, String? name) {
    this.model.groupname = name;
    this.model.groupid = id;
    txtGroup.text = name.toString();

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
                  new ClientProductGroupListView(setModel: this.setGroup);

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
    );
  }

  TextFormField builtTextStockRemain() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
      controller: txtStockRemain,
      //initialValue: "ทดสอบค่า",

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

      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red[700],
      ),

      onChanged: (String value) {
        this.model.min = value;
      },

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "จุดสั่งซื้อ",
          labelText: "จุดสั่งซื้อ",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

          //-- icon
          prefixIcon: Icon(Icons.hourglass_empty),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  TextFormField builtTextStockMax() {
    // print("in build text type "+initialText.toString());
    // if(initialText == "") initialText = "test";

    return TextFormField(
      controller: txtStockMax,
      //initialValue: "ทดสอบค่า",

      keyboardType: TextInputType.text,
      //-- กำหนด  Styel ------
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red[700],
      ),

      onChanged: (String max) {
        this.model.max = max;
      },

      //-- ตกแต่งรูปแบบ -------
      decoration: InputDecoration(
          hintText: "จำนวนมากสุด",
          labelText: "จำนวนมากสุด",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

          //-- icon
          prefixIcon: Icon(Icons.disc_full_outlined),
          //-- เส้นขอบ
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

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
          // case 0:
          //   Navigator.pushNamed(context, MyConstant.routeClientProductDetail);
          //   break;
          case 1:
            Navigator.pushNamed(
                context, MyConstant.routeClientProductDetailPrice);
            break;
          case 2:
            Navigator.pushNamed(
                context, MyConstant.routeClientProductDetailLOT);
            break;
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

  //--
  ClientProductDetailGeneralModel model = new ClientProductDetailGeneralModel();
  Future<ClientProductDetailGeneralModel>
      getCleintProductDetailGeneralModel() async {
    //--

    if (widget.actionType == ActionType.Insert) {
      print("idget.actionType == ActionType.Insert");
      //-- ถ้า
      return new ClientProductDetailGeneralModel();
    } else {
      print("idget.actionType == ActionType.Modify");
      //--
      String url = MyConstant.apiDomainName.toString() +
          "/product_detail.php?client=" +
          MyConstant.currentClientID.toString() +
          "&id=" +
          MyConstant.currentProductID.toString();

      //print("int getCleintProductDetailGeneralModel");
      //print("URL : " + url);

      //-------------------
      await Dio().get(url).then((value) {
        var items = json.decode(value.data);

        for (var item in items) {
          this.model = ClientProductDetailGeneralModel.fromMap(item);
          //print("model : " + clientProductDetailGeneralModel.toString());
          return model;
        }

        return new ClientProductDetailGeneralModel();
      });
    }
//-- ถ้าไม่เจอ อะไร ก็ให้ return ออกไปเป็น object ว่าง ๆ
    return new ClientProductDetailGeneralModel();
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

  Future<void> openNewProductPage() async {
    //-- สร้าง object page
    ClientProductDetailGeneralModify pageProduct =
        new ClientProductDetailGeneralModify(actionType: ActionType.Modify);
    //--  สร้าตัว  reoute
    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext context) {
      return pageProduct;
    });
    //--
    MyConstant.currentProductID = ""; //product.id;

    //-- เปิด page พร้อมบอกให้รอ
    await Navigator.of(context).push(route);

    this.setState(() {});
  }

  //------------------
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
        print("set state crop image");
        this.imageFile = croppedImage;
        //this.getImageAndCrop();
      });
    }
  }

  Image getImageNetwork() {
print("------ get image network -------");
    String url = MyConstant.apiDomainName.toString() +
                  "/getproduct_imagefull.php?client=" +
                  MyConstant.currentClientID.toString() +
                  "&id=" +
                  MyConstant.currentProductID.toString();

                  print("image URL =>"+url); 

    return Image.network(url,
            scale: 2.0,
            height: 200,
            fit: BoxFit.fill,
          );
  }

  Image getImageAndCrop() {

    print("------- get image and crop -------"); 
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
}
