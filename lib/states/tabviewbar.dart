import 'package:flutter/material.dart';

class MyTabViewBar extends StatefulWidget {
  const MyTabViewBar({Key? key}) : super(key: key);

  @override
  _MyTabViewBarState createState() => _MyTabViewBarState();
}

class _MyTabViewBarState extends State<MyTabViewBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: new AppBar(
            title: Text("Test TabViewbar"),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.ac_unit_rounded),
                ),
                Tab(
                  icon: Icon(Icons.access_alarm),
                ),
                Tab(
                  icon: Icon(Icons.call_merge),
                ),
                Tab(
                  icon: Icon(Icons.call_split),
                ),
                Tab(
                  icon: Icon(Icons.call_split),
                ),
              ],
            ),
          ),
          body: new TabBarView(
            children: [
              Text("tab #1"),
              Text("tab #2"),
              Text("tab #3"),
              Text("tab #4"),
              Text("tab #5"),
            ],
          ),
        ),
      ),
    );
  }
}
