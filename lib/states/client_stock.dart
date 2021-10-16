import 'package:flutter/material.dart';

class ClientStock extends StatefulWidget {
  const ClientStock({ Key? key }) : super(key: key);

  @override
  _ClientStockState createState() => _ClientStockState();
}

class _ClientStockState extends State<ClientStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prodct"),),
      body: Container(),
    );
  }
}