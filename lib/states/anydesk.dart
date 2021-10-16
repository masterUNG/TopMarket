import 'package:flutter/material.dart';

class MyAnyDesk extends StatefulWidget {
  const MyAnyDesk({ Key? key }) : super(key: key);

  @override
  _MyAnyDeskState createState() => _MyAnyDeskState();
}

class _MyAnyDeskState extends State<MyAnyDesk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("AnyDesk List"),),
      
    );
  }
}