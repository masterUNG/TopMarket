import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaket/lookup/client_pay_items.dart';
import 'package:topmaket/lookup/client_pay_items_listview.dart';
import 'package:topmaket/models/client_product_detail_general_model.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaket/states/anydesk.dart';
import 'package:topmaket/states/authen.dart';
import 'package:topmaket/states/check_authen.dart';
import 'package:topmaket/states/client_check_stock.dart';
import 'package:topmaket/states/client_product_price_all.dart';
import 'package:topmaket/states/profi/client_addnew_paybill.dart';
import 'package:topmaket/states/client_customer.dart';
import 'package:topmaket/states/client_employee.dart';
import 'package:topmaket/states/client_employee_grid.dart';
import 'package:topmaket/states/client_home2.dart';
import 'package:topmaket/states/client_pay.dart';
import 'package:topmaket/states/client_paybill_detail.dart';
import 'package:topmaket/states/client_payin_detail.dart';
import 'package:topmaket/states/client_product.dart';
import 'package:topmaket/states/client_product_best_sale.dart';
import 'package:topmaket/states/client_product_detail_general_modify.dart';
import 'package:topmaket/states/client_product_detail_lot.dart';
import 'package:topmaket/states/client_product_grid.dart';
import 'package:topmaket/states/client_product_price.dart';
import 'package:topmaket/states/client_product_price_detail.dart';
import 'package:topmaket/states/client_stock.dart';
import 'package:topmaket/states/create_account.dart';
import 'package:topmaket/states/create_product.dart';
import 'package:topmaket/states/date.dart';
import 'package:topmaket/states/dropdownlist.dart';
import 'package:topmaket/states/home.dart';
import 'package:topmaket/states/gridview.dart';
import 'package:topmaket/states/home2.dart';
import 'package:topmaket/states/listview.dart';
import 'package:topmaket/states/my_services.dart';
import 'package:topmaket/states/product_reorder.dart';
import 'package:topmaket/states/sale.dart';
import 'package:topmaket/states/sale_detail.dart';
import 'package:topmaket/states/client_home.dart';
import 'package:topmaket/states/tabviewbar.dart';
import 'package:topmaket/states/test.dart';
import 'package:topmaket/test/SearchAppBar.dart';
import 'package:topmaket/test/post.dart';
import 'package:topmaket/utility/my_application.dart';
import 'package:topmaket/utility/my_constant.dart';
import 'package:topmaket/utility/my_lookup.dart';

//-- การทำ route หน้ต่างๆ
final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) =>
      Authen(), //-- Autehen จะ return type เป็น Widget
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myServices': (BuildContext context) => Myservices(),
  '/createProduct': (BuildContext context) => CreateProduct(),
  '/test': (BuildContext context) => Test(),
  '/datePicker': (BuildContext context) => MyDatePicker(),
  '/dropdownlist': (BuildContext context) => MyDropDownList(),
  '/listViewBuilder': (BuildContext context) => MyListView(),
  '/gridView': (BuildContext context) => MyGridView(),
  '/anydesk': (BuildContext context) => MyAnyDesk(),
  '/futurebuilder': (BuildContext context) => MyHomePage(),
  // '/ramdomFuterBuilder' : (BuildContext context) => RandomButerBuilder(),
  '/clientSale': (BuildContext context) => ClientSale(),
  '/clientSaleDetail': (BuildContext context) => MySaleDetail(),
  '/clientStock': (BuildContext context) => ClientStock(),
  '/clientProduct': (BuildContext context) => ClientProductGrid(),
  '/productReorder': (BuildContext context) => ProductReorder(),
  '/clientEmployee': (BuildContext context) => ClientEmployeeGrid(),
  '/sumWorkPoint': (BuildContext context) => ClientHome2(),
  '/clientProuctBestSale': (BuildContext context) => ClientProductBestSale(),
  '/clientProductDetail': (BuildContext context) =>
      ClientProductDetailGeneralModify(),
  '/clientProductDetailPrice': (BuildContext context) =>
      new ClientProductPrice(),
  '/clientProductLOT': (BuildContext context) => new ClientProductDetailLOT(),
  '/clientProductDetailPriceEdit': (BuildContext context) =>
      new ClientProductPriceDetail(),

  '/clientProductPriceAll': (BuildContext context) =>
      new ClientProductPriceAll(),
  //ClientProductPriceAll

  '/clientPayInDetail': (BuildContext context) => new ClientPay(),
  '/clientPayBillDetail': (BuildContext context) => new ClientPayBillDetail(),
  '/clientCustomer': (BuildContext context) => new ClientCustomer(),
  '/clientAddNewPayBill': (BuildContext context) => new ClientAddNewPayBill(),

  //-- Lookup
  '/myLookupPayItems': (BuildContext context) => new ClientPayItems(),
  '/myLookupPayItemsSearch': (BuildContext context) =>
      new ClientPayItemsListView(),

  //-- test
  '/routeSearchOnAppBar': (BuildContext context) => new SearchOnAppBar(),
  //-- test
  '/reouteCheckAuthen': (BuildContext context) => new CheckAuthen(),

  //routeClientCheckStock
  '/routeClientCheckStock': (BuildContext context) => new ClientCheckStock(),

//-----------------------------------
  //-- หน้าแรก ห้ามเปลี่ยน ------
  '/routeFirstPage': (BuildContext context) => new Home2(),
  //'/routeFirstPage': (BuildContext context) => new SearchOnAppBar(),
};

//clientAddNewPayBill
//     static String routeClientCustomer = "/clientCustomer";
String? firstState;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //-- create appication objrct
  //MyApplication myApplication = new MyApplication();

//--
  //firstState = MyConstant.routeFirstPage;
  //firstState = MyConstant.routeClientHome;
  //runApp(MyApp());


//-- ตัวอ่ยาการ POST MultipartForm 
  //runApp(PostImage()); 


  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? token = preferences.getString("token");

  if (token == null) {
    print("token == null");
    firstState = MyConstant.routeCheckAuthen;
    runApp(MyApp());
  } else if (token.compareTo("null") == 0) {
    print("token == null");
    firstState = MyConstant.routeCheckAuthen;
    runApp(MyApp());
  } else {
    print("token OK...");

    String? clientID = preferences.getString("client_id");
    String? clientName = preferences.getString("clinet_name");
    int? clientCount = int.parse(preferences.getString("client_count")!);

    print("client count = " + clientCount.toString());

    MyConstant.currentHeadClientID = clientID;
    if (clientCount == 0) {
      
//-- เป็นร้นเดียว ไม่มี สาขาแม่
      MyConstant.isAvailableHeaderClient = false;
      //--
      MyConstant.currentClientID = clientID;
      MyConstant.currentClientName = clientName;

//-- ให้เปิดหน้า หลักขอบร้าน เลย
      firstState = MyConstant.routeClientHome;
    } else {
//-- เป็นร้าน ที่มีสาขา
      //-- มีสาขาแม่
      MyConstant.isAvailableHeaderClient = true;

      //-- เปิดหน้าสาขา
      firstState = MyConstant.routeFirstPage;
    }

    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  MyApplication? myApplication;
  MyApp({Key? key}) : super(key: key) {
    //this.myApplication = myApplication;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: map, //-  ตัวแปร เก็บ route
      initialRoute: firstState, //--
    );
  }
}
