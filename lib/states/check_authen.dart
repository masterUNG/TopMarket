import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaket/models/authen_model.dart';
import 'package:topmaket/states/authen.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class CheckAuthen extends StatefulWidget {
  const CheckAuthen({Key? key}) : super(key: key);

  @override
  _CheckAuthenState createState() => _CheckAuthenState();
}

class _CheckAuthenState extends State<CheckAuthen> {
  //--contorller
  TextEditingController txtKey = new TextEditingController();
  TextEditingController txtMessage = new TextEditingController();

  //--focus node
  FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: this.getWallPaperImageName(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
            return buildAuthen(context, snapshot);
            } else {
              return Center(child: CircularProgressIndicator(),) ;
            }
          },
        ),
      ),
    );
  }

  Container buildAuthen(BuildContext context, AsyncSnapshot snapshot) {

    String imageFileName = snapshot.data.toString(); 
    String imageURL = "http://119.59.116.70/flutter/wall/" +
              imageFileName;

              print("image URL => "+imageURL);
    return Container(
      //--
      //color: Colors.red,
      //--
      decoration: BoxDecoration(
        image: DecorationImage(
          //image: AssetImage('images/authenbg2.jpg'),
          image: NetworkImage(imageURL),
          fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              color: Colors.grey[100]!.withOpacity(0.7),
              border: Border.all(
                color: Colors.brown,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "SalamPOS Licence Key",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: txtKey,
                  focusNode: this._focusNode,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    //labelText: "Enter Email",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    // suffixIcon: IconButton(
                    //   icon: Icon(Icons.login),
                    //   onPressed: () {
                    //     //this.txtKey.text;

                    //     this.checkAuthen();
                    //   },
                    // ),
                  ),
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.teal,
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  height: 45,
                  width: double.infinity * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      this.checkAuthen();
                    },
                    child: Text(
                      "เข้าสู่ระบบ",
                      style: MyTextStyle.getTextStyleWhiteTitleText(),
                    ),
                  ),
                  // decoration: BoxDecoration(
                  //   borderRadius: new BorderRadius.circular(25.0),
                  // ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool authenIsOK = false;
  AuthenModel? authenModel;
  void checkAuthen() async {
    String url = MyConstant.apiDomainName.toString() +
        "/client_check_authen.php?token=" +
        txtKey.text;
    print(url);
    try {
      await Dio().get(url).then(
        (value) {
          var authenData = json.decode(value.data);

          for (var item in authenData) {
            this.authenModel = AuthenModel.fromMap(item);
            print("Model : " + this.authenModel.toString());
          }
        },
      );

      SharedPreferences pref = await SharedPreferences.getInstance();
      if (this.authenModel != null) {
        //--

        //-- login ผ่านแล้ว
        pref.setString("token", this.authenModel!.token.toString());
        print("set token " + this.authenModel!.token.toString());

//--
//-- set รหัสสาขาใหญ่
        MyConstant.currentHeadClientID = this.authenModel!.id.toString();

        //-
        MyConstant.currentClientID = this.authenModel!.id.toString();
        pref.setString("client_id", this.authenModel!.id.toString());

//--
        MyConstant.currentClientName = this.authenModel!.name.toString();
        pref.setString("clinet_name", this.authenModel!.name.toString());

//--
        int? clientCount = int.parse(this.authenModel!.clientcount!.toString());
        pref.setString("client_count", this.authenModel!.clientcount!);

        if (clientCount == 0) {
          MyConstant.isAvailableHeaderClient = false;
          Navigator.pushReplacementNamed(context, MyConstant.routeClientHome);
        } else {
          MyConstant.isAvailableHeaderClient = true;
          Navigator.pushReplacementNamed(context, MyConstant.routeFirstPage);
        }
      } else {
        //--
        pref.remove("token");
        pref.remove("client_id");
        pref.remove("clinet_name");
        pref.remove("client_count");
        pref.clear();
      }
    } catch (Ex) {
      //this.authenIsOK = false;
      MyConstant.isAvailableHeaderClient = false;
      //pref.clear();
      print("Login fall");
      this.showDialogAlert();
    }
  }

  void showDialogAlert() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('แจ้งเตือน'),
        content: const Text('Licence ไม่ถูกต้อง'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              //--ยังคับ ให้เลือก Text
              txtKey.selection = TextSelection(
                baseOffset: 0,
                extentOffset: txtKey.text.length,
              );
            },
            child: const Text('ฉันทราบแล้ว'),
          ),
        ],
      ),
    );
  }

  Future<String> getWallPaperImageName() async {
    String imageName = "786811.jpg";
    String url = MyConstant.apiDomainName.toString() + "/random_wall.php";

    await Dio().get(url).then((value) {
    
      imageName =  value.data.toString();
        print("loaded data => "+imageName);
    });

    return imageName;
  }
}
