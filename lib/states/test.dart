import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Test extends StatefulWidget {
  const Test({Key? key, String? parameter}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: Text("Test Page"),
        ),
        body: SafeArea(
          child: Container(
              //-- ตกแต่ง Background
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("images/wallpaper.jpg"),
                fit: BoxFit.fill,
              )),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: buildPageWidgets(),
              )),
        ),
      ),
    );
  }

  Container buildPageWidgets() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            offset: Offset(0, 5),
            blurRadius: 7,
            spreadRadius: 5,
          )
        ],
      ),
      child: Container(
        child: Center(
          //heightFactor: 0,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Text(
                    "ทอสอบการใช้งาน Widgets ต่างๆของ flutter",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "การใช้งาน TextFormField ตัวอักษรทัวไป",
                    style: TextStyle(color: Colors.grey),
                  ),
                  buildText1(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "การใช้งาน TextFormField แบบหลายบรรทัด",
                    style: TextStyle(
                      color: Colors.green.withOpacity(0.9),
                    ),
                  ),
                  buildTextbox2(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "ตัวอย่าง TextFormField 3",
                    style: TextStyle(
                      color: Colors.blue[800],
                    ),
                  ),
                  buildTextbox3(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ตัวอย่างการใช้งาน TextFormField 4",
                    style: TextStyle(
                      color: Colors.yellow[900],
                    ),
                  ),
                  buildTextbox4(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ตัวอย่างการใช้งาน TextFormFields แบบตัวเลขจำนวเต็ม",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  buildTextbox5(),

                       SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ตัวอย่างการใช้งาน TextFormFields แบบหลายบรรทัด",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  buildTextbox6(),

                  //----- ตัว้
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  TextFormField buildTextbox6() {
    return TextFormField(
      maxLines: 10,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    
                    hintText: "ระบุรายละเอีดเพิ่มเติม",
                    prefixIcon: Icon(Icons.perm_device_information),
                    //-- ความชิดของแนวตัวอักษร กับขอบของ Textbox
                    //prefixIconConstraints: BoxConstraints.expand(width: 2.0, height: 1.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3,
                          style: BorderStyle.solid,
                          color: Colors.deepPurpleAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType:
                      TextInputType.multiline,
                  //inputFormatters: [],
                );
  }

  TextFormField buildTextbox5() {
    return TextFormField(
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    
                    hintText: "0.00",
                    prefixIcon: Icon(Icons.format_list_numbered),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3,
                          style: BorderStyle.solid,
                          color: Colors.deepPurpleAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [],
                );
  }

  TextFormField buildTextbox4() {
    return TextFormField(
                  //-- style
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),

                  //--
                  decoration: InputDecoration(
                      hintText: "กรุณากรอกข้อมูลส่วนนี้",
                      prefixIcon: Icon(Icons.add_circle),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.tealAccent,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )),
                );
  }

  TextFormField buildTextbox3() {
    return TextFormField(
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "กรุณาระบุข้อมูลส่วนนี้",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    prefixIcon: Icon(Icons.add_alert_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
  }

  TextFormField buildTextbox2() {
    return TextFormField(
                  //-- 1 ตกแต่งตัวอักษร
                  style: TextStyle(
                    fontSize: 20,
                  ),

                  //- ตกแต่างรปแบบ
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.add_a_photo),
                      //-- คำแนะนำ
                      hintText: "กรุณาระบุข้อมูล 2",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      )),
                );
  }

  TextFormField buildText1() {
    return TextFormField(
      keyboardType: TextInputType.text,
                  //-- กำหนด  Styel ------
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),

                  //-- ตกแต่งรูปแบบ -------
                  decoration: InputDecoration(
                      hintText: "กรุณาใส่ข้อมูล",
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
}
