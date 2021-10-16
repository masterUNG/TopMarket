import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaket/bodys/aboutme.dart';
import 'package:topmaket/bodys/show_all_product.dart';
import 'package:topmaket/states/home.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/widgets/show_image.dart';

class Myservices extends StatefulWidget {
  const Myservices({Key? key}) : super(key: key);

  @override
  _MyservicesState createState() => _MyservicesState();
}

class _MyservicesState extends State<Myservices> {
  //-- ประกาศตัวแปร สำหรับ เก็บ body
  List<Widget> widgets = [
    //-- สร้าง page ShowAllProduct index = 0
    ShowAllProduct(),

    //-- สร้าง page ShowAllProduct index = 1
    AboutMe(),

    //-- สร้าง page ShowAllProduct index = 2
    MyHomePage(),

  ];
  //--
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Servcies"),
      ),

      bottomNavigationBar: BottomNavigationBar(
        // onTap: (){
        //   //-- todo
        // },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Menu 1"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Menu 2"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Menu 3"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Menu 4"),
        ],
      ),

      //--
      drawer: Drawer(
        //-- stack
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text("Programmerhero"),
                    accountEmail: Text("top@gmail.com"),
                    currentAccountPicture: ShowImage(),
                  ),

                  menuProduct(context),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  menuAbount(context),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  menuTextFormField(context),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  menuDatePicker(context),
                  Divider(color: Colors.green),
                  menuDropDownList(context),
                  //--
                  Divider(color: Colors.grey.shade500),
                  buildMenuListView(),

                  //--
                  Divider(color: Colors.grey.shade500),
                  buildMenuGridView(),

                  //--
                  Divider(color: Colors.grey.shade500),
                  ListTile(
                    title: Text("Future Builder"),
                    leading: Icon(Icons.add_alarm_rounded),
                    onTap: () {
                      Navigator.pushNamed(context, MyConstant.routeFutureBuilder);
                      // //-- todo
                      // this.index = 2;
                      // this.setState(() {
                      //     this.widgets[this.index]; 

                      // });
                    },
                  ),

                  Divider(color: Colors.grey.shade500),
                  ListTile(
                    onTap: () {
                      //-- todo
                      Navigator.pushNamed(context, MyConstant.routeAnyDesk);
                    },
                    leading: Icon(Icons.drag_handle_rounded),
                    title: Text(
                      "Anydesk ID",
                      style: TextStyle(),
                    ),
                    subtitle: Text(
                      "ชื่อผู้ใช้งาน และรหัสผ่าน",
                      style: TextStyle(),
                    ),
                  ),

                  Divider(),
                  ListTile(
                    leading: Icon(Icons.wifi),
                    title: Text("Ramdom number"),
                    subtitle :Text("ทดสอบการ ใช้งาน Future builder Random NUmber"),
                    onTap: () {
                      Navigator.pushNamed(context, "routeName");
                    },
                  ),

                  buildSignOut(),
                ],
              ),
            ),
          ],
        ),
      ),
      body: widgets[this.index],
    );
  }

  ListTile buildMenuGridView() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeGridView);
      },
      minVerticalPadding: 0.5,
      leading: Icon(Icons.download_done_sharp),
      title: Text("GridView"),
      subtitle: Text("ทดสอบการใช้งาน GridView.Builder"),
    );
  }

  ListTile buildMenuListView() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeListView);
      },
      minVerticalPadding: 0.5,
      leading: Icon(Icons.download_done_sharp),
      title: Text("ListView Builder"),
      subtitle: Text("ทดสอบการใช้งาน ListView.Builder"),
    );
  }

  ListTile menuDropDownList(BuildContext context) {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeDropDownList);
      },
      leading: Icon(Icons.perm_identity),
      title: Text("DropdownList"),
      subtitle: Text("ทดสอบการใช้งาน DropdownList"),
    );
  }

  ListTile menuDatePicker(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, MyConstant.routeDatePicker);
      },
      leading: Icon(
        Icons.ac_unit_rounded,
      ),
      title: Text("Date Picker"),
      subtitle: Text(
        "ทดสอบการใช้งาน Date Picker",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  ListTile menuTextFormField(BuildContext context) {
    return ListTile(
      onTap: () {
        //-- การเปลี่ยนหน้าโดยใช้ Navigator
        Navigator.pushNamed(context, MyConstant.routeTest);
      },
      leading: Icon(
        Icons.ac_unit_rounded,
      ),
      title: Text("ทดสอบ Widgets"),
      subtitle: Text(
        "ทดสอบการใช้งาน Widgets ต่างๆ",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  ListTile menuAbount(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);

        //-- การเปลี่ยนหน้าโดยใช้วิธีการ เปลร่ยนเฉพาะ พี้นที่ Model
        this.index = 1; //--  เปลี่ยน index
        this.setState(
            () {}); //-- สั่ง SetState ใหม่ โดย เอา Widgets ใน List มาแสดง
      },
      leading: Icon(
        Icons.ac_unit_rounded,
      ),
      title: Text("เกียวกับตัวฉัน"),
      subtitle: Text(
        "",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  ListTile menuProduct(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);

        this.index = 0;
        this.setState(() {});
      },
      //contentPadding: ,
      leading: Icon(
        Icons.ac_unit_rounded,
      ),
      title: Text(
        "รายการสินค้า",
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        "แสดงรายการสินค้า",
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }

  Column buildSignOut() {
    return Column(
      //-- บอกว่าให้อยู่ด้านบน
      // mainAxisAlignment: MainAxisAlignment.start,
      //-- บอกว่าให้อยู่ตรงกลาง
      // mainAxisAlignment: MainAxisAlignment.center,
      //-- บอกว่าให้อยู่ด้านล่าง
      mainAxisAlignment: MainAxisAlignment.end,

      children: [
        ListTile(
          onTap: () async {
            print("click signout");
            //-- เครีย์ preferece ออกจากระบบ
            SharedPreferences shared = await SharedPreferences.getInstance();
            shared.clear().then((value) =>
                //-- ให้กลับไ
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeAuthen, (route) => false));

            //  });
          },
          tileColor: Colors.red[300],
          leading: ShowImage(),
          title: Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "Lotout and remove session",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
