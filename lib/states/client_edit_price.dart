import 'package:flutter/material.dart';
class ClientEditPrice extends StatefulWidget {
  const ClientEditPrice({ Key? key }) : super(key: key);

  @override
  _ClientEditPriceState createState() => _ClientEditPriceState();
}

class _ClientEditPriceState extends State<ClientEditPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("รายละเอียดราคา"),),
    );
  }
}