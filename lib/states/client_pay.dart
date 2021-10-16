import 'package:flutter/material.dart';
import 'package:topmaket/states/client_paybill_detail.dart';
import 'package:topmaket/states/client_payin_detail.dart';

class ClientPay extends StatefulWidget {
  const ClientPay({Key? key}) : super(key: key);

  @override
  _ClientPayState createState() => _ClientPayState();
}

class _ClientPayState extends State<ClientPay> {
  int currentSelectedPageIndex = 0;
  String title = "รายการค่าใช้จ่าย : เบิกเงินสด";

  ClientPayinDetail? clientPayinDetailPage;
  ClientPayBillDetail? clientPayBillDetailPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.brown[200],
        title: Text(this.title),
      ),
      bottomNavigationBar: buildBottomNavigateMenu(),
      body: buildPayDetailPage(),
    );
  }

  dynamic buildPayDetailPage() {
    switch (this.currentSelectedPageIndex) {
      case 0:
        if (this.clientPayinDetailPage == null) {
          this.clientPayinDetailPage = new ClientPayinDetail();
        }
        return this.clientPayinDetailPage;

      case 1:
        if (this.clientPayBillDetailPage == null) {
          this.clientPayBillDetailPage = new ClientPayBillDetail();
        }
        return this.clientPayBillDetailPage;
    }
    return new ClientPayinDetail();
  }

  BottomNavigationBar buildBottomNavigateMenu() {
    return new BottomNavigationBar(
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.black54,
      currentIndex: this.currentSelectedPageIndex,
      backgroundColor: Colors.brown[200],
      items: [
        new BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded), label: "เบิกเงินสด"),
        new BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded), label: "จ่ายบิล"),
      ],
      onTap: (int selectedPageIndex) {
        this.currentSelectedPageIndex = selectedPageIndex;

        switch (selectedPageIndex) {
          case 0:
            this.title = "รายการค่าใช้จ่าย: เบิกเงินสด";
            break;

          case 1:
            this.title = "รายการค่าใช้จ่าย: จ่ายบิล";
            break;
        }

        this.setState(() {});
      },
    );
  }
}
