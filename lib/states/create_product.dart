import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  TextEditingController txtProductName = new TextEditingController();
  TextEditingController txtProductDesc = new TextEditingController();
  TextEditingController txtProductPrice = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Add new product"),
      ),
      body: SafeArea(
        //- ตัวครอบใหญ่สุด
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(
              FocusNode(),
            );
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/wallpaper.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            //--  ทำให้อยู๋ตางกลาง
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      Text("เพิ่มสินค้าใหม่"),
                      Image.asset("images/image.png"),
                      buildTextName(),
                      buildTextDecs(),
                      buildTextPrice(),
                      TextFormField(
                        onTap: () {
                          print("datetime on tab ");

                          SfDateRangePicker(
                            //onSelectionChanged: _onSelectionChanged,
                            selectionMode: DateRangePickerSelectionMode.single,
                            initialSelectedRange: PickerDateRange(
                                DateTime.now()
                                    .subtract(const Duration(days: 4)),
                                DateTime.now().add(const Duration(days: 3))),
                          );
                        },
                        style: TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          //-- ความสูงของตัวอักษร
                          height: 0.8,
                          //-- ระยะห่างต้วอักษร
                          letterSpacing: 1,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          prefixIcon: Icon(Icons.event_available),
                          hintText: "ระบุวันที่",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            // height: 0.7,
                          ),
                        ),
                      ),

                      /*-- วิธีนี้ ไม่โอเค ต้องใช้ วิธี สร้า text form field แล้วก็​
                      InputDatePickerFormField(
                        
                        initialDate: DateTime.now(),
                        firstDate: DateTime.parse("2021-01-01"),
                        lastDate: DateTime.now(),
                      ),
                      */
                      ElevatedButton(
                        onPressed: this.addProductOnPress,
                        child: Text("บันทึกสินค้าใหม่"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> addProductOnPress() async {
    String? _productName = this.txtProductName.text;
    String? _productDesc = this.txtProductDesc.text;
    String? _productrice = this.txtProductPrice.text;

    print(
      "name =>$_productName, desc=> $_productDesc, price => $_productrice ",
    );

    //-- sent from data --------

    //-- เตรียมตัวแปร เป็นแบบ map เพิ่มจะเอาไป post
    var _formData = FormData.fromMap({
      "name": _productName,
      "desc": _productDesc,
      "price": _productrice,
    });

    //-- post Data ไปยัง server
    var response = await Dio().post(
      "http://119.59.116.70/flutter/post.php",
      data: _formData,
    );
    print("reponse=> " + response.toString());
  }

  Padding buildTextName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        //-- ผู้ชื่อตัวแปร
        controller: txtProductName,

        style: TextStyle(
          textBaseline: TextBaseline.alphabetic,
          //-- ความสูงของตัวอักษร
          height: 0.8,
          //-- ระยะห่างต้วอักษร
          letterSpacing: 1,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.speaker_notes),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.8),
              ),
              borderRadius: BorderRadius.circular(5)),
          hintText: "ชื่อสินค้า",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
      ),
    );
  }

  Padding buildTextDecs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: this.txtProductDesc,
        style: TextStyle(
          textBaseline: TextBaseline.alphabetic,
          //-- ความสูงของตัวอักษร
          height: 0.8,
          //-- ระยะห่างต้วอักษร
          letterSpacing: 1,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.description),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.8),
              ),
              borderRadius: BorderRadius.circular(5)),
          hintText: "รายละเอียดสินค้า",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
      ),
    );
  }

  Padding buildTextPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        //-- จัดตำแหน่ง 
        textAlign: TextAlign.right,
        //-- บังคับ keyboard ให้เป็นตัวเลข
        //keyboardType: TextInputType.number,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        /*
        //-- รูปแบบการกรองเอา เฉพาะตัวเลขเท่านั้น ไม่สามารถพิมพ์ตัวอักษรได้
        inputFormatters: <TextInputFormatter>[
          //-- กรองเป็นแบบ ตัวเลขเท่าน้น
          FilteringTextInputFormatter.digitsOnly,
        ],*/
        controller: txtProductPrice,
        style: TextStyle(
          textBaseline: TextBaseline.alphabetic,
          //-- ความสูงของตัวอักษร
          height: 0.8,
          //-- ระยะห่างต้วอักษร
          letterSpacing: 1,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.paid),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.8),
              ),
              borderRadius: BorderRadius.circular(5)),
          hintText: "ราคาสินค้า",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
      ),
    );
  }
}
