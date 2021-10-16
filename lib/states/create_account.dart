import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          //image: Image.asset('wallpaper.jpg'),
          image: DecorationImage(
            image: AssetImage("images/wallpaper.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //--
                Text("ลงทะเบียนผู้ใช้ใหม่"),
                //--
                Image.asset("images/image.png"),
                //-- username 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "ชื่อผู้ใช้งาน",
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red.withOpacity(0.7)),
                      borderRadius: BorderRadius.circular(
                          10), //-- ปรับความโค้งของ textbox
                    ),
                  ),
                ),

                 SizedBox(height: 5),
                //-- password
                TextFormField(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: InputDecoration(
                    hintText: "รหัสผ่าน",
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red.withOpacity(0.7)),
                      borderRadius: BorderRadius.circular(
                          10), //-- ปรับความโค้งของ textbox
                    ),
                  ),
                ),

                SizedBox(height: 5),
                //-- password 
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "เบอร์โทรศัพท์",
                    prefixIcon: Icon(Icons.phone_android),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.red.withOpacity(0.7)),
                      borderRadius: BorderRadius.circular(
                          10), //-- ปรับความโค้งของ textbox
                    ),
                  ),
                ),

                  SizedBox(height: 5),
                  Container(
                    width: 250,
                    child: ElevatedButton(onPressed: (){

                      //-- todo
                      
                    }, child: Text("ยืนยันลงทะเบียน"),),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
