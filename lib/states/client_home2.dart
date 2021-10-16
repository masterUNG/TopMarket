import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaket/bodys/client_work_point_day.dart';
import 'package:topmaket/bodys/client_work_point_month.dart';
import 'package:topmaket/bodys/client_work_point_year.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_textstyle.dart';

class ClientHome2 extends StatefulWidget {
  const ClientHome2({Key? key}) : super(key: key);

  @override
  _ClientHome2State createState() => _ClientHome2State();
}

class _ClientHome2State extends State<ClientHome2> {
  //--
  //int currentPageIndex = 0;
  //--
  String appbarTitle = "สรุปผลประกอบการวันนี้";

  //--
  ClientWorkPointDay? clientWorkPointDayPage;
  ClientWorkPointMonth? clientWorkPointMonthPage;
  ClientWorkPointYear? clientWorkPointYearPage;

  @override
  Widget build(BuildContext context) {
    this.setAppbarTitleText();

    return Scaffold(
      //--
      appBar: new AppBar(
        title: Text(this.appbarTitle),
        backgroundColor: Colors.brown[100],
        actions: [
          IconButton(
            onPressed: this.logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      //--
      drawer: createAppDrawer(context),

      //--
      body: buildWorkPointPageBySelectedPage(),

      //--
      floatingActionButton: !MyConstant.isAvailableHeaderClient!
          ? Visibility(
              child: Text(""),
              visible: false,
            )
          : new FloatingActionButton(
              backgroundColor: Colors.brown[300],
              child: Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: MyConstant.currentSelectedPageIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "ประจำวัน"),
          new BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_month), label: "ประจำเดือน"),
          new BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_week), label: "ประจำปี"),
        ],
        onTap: (int currentTabIndex) {
          //print("current tab index : "+MyConstant.currentSelectedPageIndex .toString());
          //--
          MyConstant.currentSelectedPageIndex = currentTabIndex;
          this.setAppbarTitleText();
          this.setState(() {
            //print("set state currentPageIndex =" +
            MyConstant.currentSelectedPageIndex.toString();
          });
        },
      ),
    );
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //--
    pref.remove("token");
    Navigator.pushReplacementNamed(context, MyConstant.routeCheckAuthen);
  }

  void setAppbarTitleText() {
    switch (MyConstant.currentSelectedPageIndex) {
      case 0:
        this.appbarTitle = "สรุปผลประกอบการวันนี้";
        break;
      case 1:
        this.appbarTitle = "สรุปผลประกอบการเดือนนี้";
        break;
      case 2:
        this.appbarTitle = "สรุปผลประกอบการปีนี้";
        break;
    }
  }

  dynamic buildWorkPointPageBySelectedPage() {
    switch (MyConstant.currentSelectedPageIndex) {
      case 0:
        //this.currentPageIndex = 0;
        if (this.clientWorkPointDayPage == null) {
          //print("create new ClientWorkPointDay()");
          this.clientWorkPointDayPage = new ClientWorkPointDay();
        }

        return this.clientWorkPointDayPage;

      case 1:
        //this.currentPageIndex = 1;
        if (this.clientWorkPointMonthPage == null) {
          //print("create new ClientWorkPointMonth()");
          this.clientWorkPointMonthPage = new ClientWorkPointMonth();
        }

        return this.clientWorkPointMonthPage;

      case 2:
        //this.currentPageIndex = 2;
        if (this.clientWorkPointYearPage == null) {
          //print("create new ClientWorkPointYear()");
          this.clientWorkPointYearPage = new ClientWorkPointYear();
        }

        return this.clientWorkPointYearPage;
    }
  }

  Drawer createAppDrawer(BuildContext context) {
    return new Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: (Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  MyConstant.currentClientName.toString(),
                  style: MyTextStyle.getTextStyleWhiteTitleText(),
                ),
                accountEmail: Text(
                    "รหัสร้านค้า " + MyConstant.currentClientID.toString()),
                currentAccountPicture: Image.network(
                  MyConstant.apiDomainName.toString() +
                      "/get_company_logo.php?client=" +
                      MyConstant.currentClientID.toString(),
                ),

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/supermarket.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),

                // currentAccountPicture: Image,
              ),
              createDrawMenuSale(),
              createDrawMenuProduct(),
              createDrawMenuCustomer(),
              createDrawMenuCheckStock(),
              createDrawMenuCheckPrice(),
              createDrawMenuLowStock(),
              createDrawMenuEmployee(),
              createDrawProductBestSale(),
              createDrawLogout(),
            ],
          )),
        ),
      ),
    );
  }

  ListTile createDrawMenuSale() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routerClientSale);
      },
      leading: Icon(Icons.add_business),
      title: Text(
        "รายการขาย",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายการขายทั้งหมดของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuCustomer() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeClientCustomer);
      },
      leading: Icon(Icons.person),
      title: Text(
        "รายชื่อลูกค้า",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายชื่อลูกค้าทั้งหมดของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuEmployee() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeClientEmployee);
      },
      leading: Icon(Icons.add_business),
      title: Text(
        "รายชื่อพนักงาน",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายชื่อพนักงานทั้งหมดของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuCheckStock() {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, MyConstant.routeClientCheckStock);
        //-- todo
      },
      leading: Icon(Icons.check_box),
      title: Text(
        "ตรวจสอบ Stock สินค้า",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "ตรวจสอบจำนวนคงเหลือของจำนวนสินค้าในร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuCheckPrice() {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
            context, MyConstant.routeClientProductCheckPriceAll);
        //-- todo
      },
      leading: Icon(Icons.access_alarm),
      title: Text(
        "ตรวจสอบราคาสินค้า",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "ตรวจสอบราคาสินค้าทั้งหมดในร้านทุก Packaging",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuLowStock() {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, MyConstant.routeProductReorder);
        //-- todo
      },
      leading: Icon(Icons.access_alarm),
      title: Text(
        "สินค้าใกล้หมด",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "แสดงรายการสินค้าใกล้หมดของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawMenuProduct() {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, MyConstant.routeClientProduct);
        //-- todo
      },
      leading: Icon(Icons.ac_unit),
      title: Text(
        "รายการสินค้า",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "แสดงรายการสินค้าของร้าน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawProductBestSale() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeClientProductBestSale);
      },
      leading: Icon(Icons.auto_graph),
      title: Text(
        "สินค้าขายดี",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายการสินค้าขายดีประจำเดือน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawProductLot() {
    return ListTile(
      onTap: () {
        //-- todo
        Navigator.pushNamed(context, MyConstant.routeClientProductDetailLOT);
      },
      leading: Icon(Icons.point_of_sale),
      title: Text(
        "สต็อกสินค้า",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "แสดงรายการสต็อกและ Lot สินค้าที่ยังมีคงเหลือ",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ListTile createDrawLogout() {
    return ListTile(
      onTap: () {
        this.logout();
      },
      leading: Icon(Icons.logout),
      title: Text(
        "ออกจากระบบ",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "ลงชื่ออก/Logout/เลิกใช้งาน",
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
