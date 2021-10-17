import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:topmaket/models/jsonplaceholder_model.dart';

class ShowLoadMore extends StatefulWidget {
  const ShowLoadMore({Key? key}) : super(key: key);

  @override
  _ShowLoadMoreState createState() => _ShowLoadMoreState();
}

class _ShowLoadMoreState extends State<ShowLoadMore> {
  List<JsonPlaceHolderModel> models = [];
  int amount = 10;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    readData();

    scrollController.addListener(() {
      print('position ==> ${scrollController.position.pixels}');

      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        print('On Top');
      }

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('นี่คือ ล่างสุดแล้ว');
        setState(() {
          amount += 5;
        });
      }
    });
  }

  Future<void> readData() async {
    String path = 'https://jsonplaceholder.typicode.com/photos';
    await Dio().get(path).then((value) {
      for (var item in value.data) {
        JsonPlaceHolderModel model = JsonPlaceHolderModel.fromMap(item);
        setState(() {
          models.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Load More'),
      ),
      body: models.isEmpty
          ? Center(child: CircularProgressIndicator())
          : buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      controller: scrollController,
      itemCount: amount,
      itemBuilder: (context, index) => Row(
        children: [
          Container(
            width: 200,
            child: Text(
              models[index].title,
            ),
          ),
          Container(
            width: 150,
            child: Image.network(models[index].url),
          ),
        ],
      ),
    );
  }
}
