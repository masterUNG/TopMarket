import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("การใช้งาน ListView"),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Image(
                image: AssetImage("images/image.png"),
                height: 72,
              ),
              SizedBox(width: 10,),
              Column(
                
                children: [
                  Text(
                    "data $index",
                    style: TextStyle(
                        color: Colors.red.shade500,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("detail for $index"),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
