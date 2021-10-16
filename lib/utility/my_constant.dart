import 'package:flutter/material.dart';

class MyConstant {
  static String routeAuthen = '/authen';
  static String routeCreqateAccount = '/createAccount';
  static String routeMyService = '/myServices';
  static String routeCreateProduct = '/createProduct';
  static String routeTest = '/test';
  static String routeDatePicker = "/datePicker";
  static String routeDropDownList = "/dropdownlist";
  static String routeListView = "/listViewBuilder";
  static String routeGridView = "/gridView";
  static String routeAnyDesk = "/anydesk";
  static String routeFutureBuilder = "/futurebuilder";

  //-- firstPage
  static String routeFirstPage = "/routeFirstPage";
  static String routerRamdomFuterBuilder = "/ramdomFuterBuilder";
  static String routerClientSale = "/clientSale";
  static String routerClientSaleDetial = "/clientSaleDetail";

  static String routeClientStock = "/clientStock";
  static String routeClientProduct = "/clientProduct";

  static String routeProductReorder = "/productReorder";
  static String routeClientEmployee = "/clientEmployee";

  static String routeClientHome = "/sumWorkPoint";
  static String routeClientProductBestSale = "/clientProuctBestSale";
  static String routeClientProductDetail = "/clientProductDetail";
  static String routeClientProductDetailPrice = "/clientProductDetailPrice";

  static String routeClientProductDetailLOT = "/clientProductLOT";
  static String routeClientProductDetailPriceEdit =
      "/clientProductDetailPriceEdit";
  static String routeClientProductCheckPriceAll =
      "/clientProductPriceAll";
      //
  static String routeClientPayinDetail = "/clientPayInDetail";
  static String routeClientPayBillDetail = "/clientPayBillDetail";
  static String routeClientCustomer = "/clientCustomer";

  static String routeClientAddNewPayBill = "/clientAddNewPayBill";

  //--
  static String routeSearchOnAppBar = "/routeSearchOnAppBar";

  //-- checkstock 
   static String routeClientCheckStock = "/routeClientCheckStock";
   //-- check authen 
   static String routeCheckAuthen = "/reouteCheckAuthen";

//-------------------------
  static String? currentHeadClientID = "147"; //32=bebysmile 147=smoke
  static bool? isAvailableHeaderClient = false; 
//-- ตัวแปรก --------------
  static String? currentSaleID;
  static String? currentClientID;
  static String? currentClientName;

  static String? currentProductID;
  static String? currentProductPriceTypeID;
  static String? currentProdctUnitID;
  static bool? currentProducPriceIsPackaging;

  static int currentSelectedPageIndex = 0;
  static String? currentShopName;

//-- 
  static String? apiDomainName = "http://119.59.116.70/flutter";
  //--

  //-- color prifix = 0xff + ค่าสี
  static Color primary = Color(0xfffffde7);
  static Color light = Color(0xffffffff);
  //static Color dark = Color(0xffcccab5);
  static Color dark = Color(0xffc76517);
}
