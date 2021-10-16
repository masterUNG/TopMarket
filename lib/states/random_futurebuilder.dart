import 'package:flutter/material.dart';

class RandomButerBuilder extends StatefulWidget {
  const RandomButerBuilder({ Key? key }) : super(key: key);

  @override
  _RandomButerBuilderState createState() => _RandomButerBuilderState();
}

class _RandomButerBuilderState extends State<RandomButerBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Ramdom by FuterBuilder"),),
      
    );
  }
}