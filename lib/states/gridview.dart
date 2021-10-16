import 'package:flutter/material.dart';

class MyGridView extends StatefulWidget {
  const MyGridView({ Key? key }) : super(key: key);

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("การใช้งาน GridView"),),
    );
  }
}