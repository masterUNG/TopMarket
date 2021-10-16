import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaket/models/user_model.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_dialog.dart';
import 'package:topmaket/widgets/show_image.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  //-- ตัวแปร ที่สามารถ สื่อกับ Widget ได้ตรง ๆ โดยไม่ต้องส่งเป็น ต้วแปร
  final formKey = GlobalKey<FormState>();

  //-- ตัวแรป สำหรบการรับค่า -----
  //-- สำหรับ user
  TextEditingController userController = new TextEditingController();
  //-- สำหรับ password
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-- SafeArea ทำใหทุกยอ่าง อยุ่ในกรอบ ที่ควรอยุ่
      body: SafeArea(
        //-- สำหรับเพิ่ม Event Click
        child: GestureDetector(
          //-- การคลิก ภายนอก widget
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),

          //-- ตัวครอบใหญ่สุด
          child: Container(
            //decoration: BoxDecoration(color: MyConstant.light),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/wallpaper.jpg'),
              ),
            ),

            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    //-- global key ที่ประกาศ​ด้าน บน
                    //-- สำหรับ ทำ Validate
                    key: this.formKey,
                    //-
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //--
                        buildImage(),

                        //--
                        buildUser(),

                        //--
                        buildPassword(),

                        //--
                        buildLogin(),

                        buildAccount()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildAccount() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Non account?"),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeCreqateAccount),
          child: Text("Create account"),
        ),
      ],
    );
  }

  Container buildLogin() {
    return Container(
        width: 250,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
//-- ดึงค่าจาก Textbox
              String user = this.userController.text;
              String pass = this.passController.text;

              //--
              print("user = $user, pass = $pass");

              //-- connect for login
              this.checkAuthen(username: user, password: pass);
            }
          },
          child: Text('Login'),
        ));
  }

  Future<Null> checkAuthen(
      {required String username, required String password}) async {
    String userAPI =
        "https://www.androidthai.in.th/bigc/getUserWhereUserTop.php?isAdd=true&user=$username";

    //-- using DIO
    //[1.] ดึงข้อมูล
    await Dio().get(userAPI).then((value) async { //-- thread ซ้อน thread
      print("value from API => $value");

      //--[2.] ตรวจผลพลัพธ์
      if (value.toString() == "null") {
        print("Wrong user");

        //-- แสดง popup
        MyDialog()
            .normalDialog(context, "Wrong user", "No $username in database");
      } else {
        print("Correct user");

        //-- [3.] Decode ผลลัพธ์
        var result = json.decode(value.data);
        //-- result จะเป็น Array ของผลลัพธ์​ที่ได้มา ทั้งหมด
        print("decode => $result");

        //-- [1.] วนลูปใน ผลลัพธ์ จะได้ มาเป็น Data 1 Row
        print("show all data");

        //-- item จะมีโครงสร้างเป็ฯ Map
        for (var item in result) {
          print("\nrow " + item.toString());
          UserModel userModel = UserModel.fromMap(item);

          print("model => $userModel");

          if (password == userModel.password) {
            print("Login success");

            List<String> datas = [];
              datas.add(userModel.id);
            datas.add(userModel.name);


            //-- ฝั่ง preference
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setStringList("datas", datas);

//-- การเรียกหน้ใหม่ โดยทำลาย หน้าปัจจุบันทิ้ง ไม่สามารถ Back กลับมาได้ ไม่มีลูกศร Back กลับบน AppBar


            Navigator.pushNamedAndRemoveUntil(
                context, MyConstant.routeMyService, (route) => false);
                
          } else {
            MyDialog().normalDialog(context, "Login false", "Please try again");
          }
        }
      }
    });
  }

  void checkAuthen2({required String username, String? password}) {}

  Container buildUser() {
    return Container(
      width: 250,
      child: TextFormField(
        //-- link กับ TextEditController
        controller: this.userController,
        //-- เมือทำการ กรอกข้อมุล ระบบจะส่งตัวแปร Value มาใน validate
        validator: (value) {
          if (value!.isEmpty) {
            //-- ใส่ตกใจ ยื่นยันว่ ไม่มีทาง เป็น null

            return "Please fill user";
          } else {
            //-- ถ้า validate ผ่านให้ส่งเป็ฯ null
            return null;
          }
        },
        //--
        style: TextStyle(color: MyConstant.dark),

        decoration: InputDecoration(
            //labelText: "ชื่อผู้ใช้งาน", //-- แสดงที่กรอบ
            hintText: "ชื่อผู้ใช้งาน", //-- แสดงใน textbox จะหายไป เมือใส่ข้อมูล
            hintStyle: TextStyle(color: MyConstant.dark),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.dark),
              borderRadius:
                  BorderRadius.circular(10), //-- ปรับความโค้งของ textbox
            ),
            prefixIcon: Icon(Icons.account_circle)),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 250,
      child: TextFormField(
        controller: this.passController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please fill password";
          } else {
            return null;
          }
        },
        //--
        style: TextStyle(color: MyConstant.dark),

        //-- ทำให้เป็น รหัสผ่าน
        obscureText: this.redEye,

        //-- red eye

        //-- ตกแต่าง Textbox
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                this.redEye = !redEye;
              });
              //print('redeye = $redEye');
            },
            icon: Icon(Icons.remove_red_eye),
          ),
          //labelText: "ชื่อผู้ใช้งาน", //-- แสดงที่กรอบ
          hintText: "รหัสผ่าน", //-- แสดงใน textbox จะหายไป เมือใส่ข้อมูล
          hintStyle: TextStyle(color: MyConstant.dark),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
            borderRadius:
                BorderRadius.circular(10), //-- ปรับความโค้งของ textbox
          ),
          prefixIcon: Icon(Icons.lock_outline),
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      child: ShowImage(),
      width: 250,
    );
  }
}
