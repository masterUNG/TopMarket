import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key}) : super(key: key);

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("ทดสอบ Date Picker"),
      ),
      body: Container(
        color: Colors.brown.withOpacity(0.6),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("เลือกวันที่"),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    locale: const Locale("th"),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                },
                child: Text("แสดง Popup วันที่"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
