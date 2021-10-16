import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/client_employee_model.dart';
import 'package:topmaket/utility/my_constant.dart';

class ClientEmployee extends StatefulWidget {
  const ClientEmployee({Key? key}) : super(key: key);

  @override
  _ClientEmployeeState createState() => _ClientEmployeeState();
}

class _ClientEmployeeState extends State<ClientEmployee> {
  Timer? timer;

  void doSetState() {
    this.setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.getClientEmployeeModelJson();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => doSetState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: new AppBar(
          title: Text("รายชื่อพนักงานในร้าน"),
        ),
        body: FutureBuilder(
            future: this.getClientEmployeeModelJson(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (this.employeeModelsList.length == 0) {
                  return LinearProgressIndicator();
                } else {
                  return createListViewBuilerEmployeeList();
                }
              } else {
                return Center(
                  child: LinearProgressIndicator(),
                );
              }
            }));
  }

  ListView createListViewBuilerEmployeeList() {
    return ListView.builder(
        itemCount: this.employeeModelsList.length,
        itemBuilder: (context, index) {
          EmployeeModel emp = this.employeeModelsList[index];
          return Card(
            child: Container(
              alignment: Alignment.topLeft,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: createEmployeeRowData(emp),
              ),
            ),
          );
        });
  }

  Row createEmployeeRowData(EmployeeModel emp) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(MyConstant.apiDomainName.toString() +
            "/getproduct_empicon.php?client=" +
            MyConstant.currentClientID.toString() +
            "&id=" +
            emp.id.toString()),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emp.firstname.toString() + " " + emp.lastname.toString(),
              style: TextStyle(fontSize: 22, color: Colors.red[700], fontWeight: FontWeight.bold),
            ),
            Container(
              //alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      color: Colors.grey,
                    ),
                    Card(
                      child: Row(
                        children: [
                          Image.asset("images/phone16.png"),
                          Text(" " + emp.phonenumber.toString()),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: [
                          Image.asset("images/line16.png"),
                          Text(" " + emp.line.toString()),
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        children: [
                          Image.asset("images/mail16.png"),
                          Text(" " + emp.email.toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  List<EmployeeModel> employeeModelsList = [];
  Future<List<EmployeeModel>> getClientEmployeeModelJson() async {
    String url = "http://119.59.116.70/flutter/employee.php?id=" +
        MyConstant.currentClientID.toString();
    Dio().get(url).then((value) {
      var items = json.decode(value.data);
      this.employeeModelsList.clear();
      for (var map in items) {
        this.employeeModelsList.add(EmployeeModel.fromMap(map));
      }

      return this.employeeModelsList;
    });
    return [];
  }
}
