import 'package:flutter/material.dart';

class MyDropDownList extends StatefulWidget {
  const MyDropDownList({Key? key}) : super(key: key);

  @override
  _MyDropDownListState createState() => _MyDropDownListState();
}

class _MyDropDownListState extends State<MyDropDownList> {
  String? dropdownValue;
  String? dropdownValue2;

  List<String> items = [
    "ตัวเลือก-A",
    "ตัวเลือก-B",
    "ตัวเลือก-C",
    "ตัวเลือก-D",
    "ตัวเลือก-E",
  ];
  List<Map<int, String>> itemsMap = [
    {1: "One"},
    {2: "Two"},
    {3: "Three"},
    {4: "Fore"},
    {5: "Five"}
  ];

  String? valueNameString;
  List<String> itemsValueAndNameString = [
    "1:One",
    "2:Two",
    "3:Three",
    "4:Four",
    "5:Five",
    "6:Six"
  ];

  //Map<int, String> map = {1:"one", 2:"two", 3:"three", 4:"four"};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.green[400],
          foregroundColor: Colors.white,
          title: Text("ทดสอบ DropdownList"),
        ),
        body: Container(
          color: Colors.green[50],
          child: Center(
            child: Column(
              children: [
                //-- ตัวอย่าง Dropdown
                Text("Dropdown ตัวอย่างจาก Youtube"),
                builtDropdownExample(),

                //-- ลองทำเอง
                Text("ลองทำเอง"),
                builtDrowdownString(),

                Text("ลองทำแบบใช่วิธี Maping value และ display"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ),
                    child: builtDropdownButtomIDAndValue(),
                  ),
                ),

                Text("ลองทำแบบใช่วิธี FromField"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton<String> builtDropdownButtomIDAndValue() {
    return DropdownButton(
      isExpanded: true,
      underline: SizedBox(),
      style: TextStyle(
        color: Colors.red[600],
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      dropdownColor: Colors.red[100],
      hint: Text("กรุณาเลือก"),
      icon: Icon(Icons.download_done),
      value: valueNameString,
      items: this.itemsValueAndNameString.map(
        (String data) {
          List<String> val = data.split(":");
          return DropdownMenuItem(
            value: val[0],
            child: Text(val[1]),
          );
        },
      ).toList(),
      onChanged: (String? value) {
        this.setState(() {
          this.valueNameString = value;
          print("value => $value");
        });
      },
    );
  }

  DropdownButton<String> builtDrowdownString() {
    return DropdownButton(
      //-- value ที่จะให้เลือก โดยจะเอาค่าที่กำหนด ใน onChange มาเปลี่ยน
      value: this.dropdownValue2,

      //-- event หลังจากที่ทำการเลือก
      onChanged: (String? newValue) {
        this.setState(() {
          //-- ค่าที่จะทำการวาดใหม่
          this.dropdownValue2 = newValue;
        });
      },
      //-- การ Bind Data ให้กับ Dropdown
      items: this.items.map((String e) {
        //-- ต้องสร้างเป็น Object DropDownMenuItem
        return DropdownMenuItem<String>(
          //-- value เวลาเลือก
          value: e,
          //-- ส่วนที่แสดง
          child: Text(e),
        );
      }).toList(),
    );
  }

  DropdownButton<String> builtDropdownExample() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
