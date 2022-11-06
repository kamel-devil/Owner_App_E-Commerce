import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;

  late int totalPages=4;

  List passengers = [];

  final RefreshController refreshController =
  RefreshController(initialRefresh: true);

  Future<bool> getPassengerData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse(
        "https://ibtikarsoft.net/finder/api/user/shops.php?lang=ar&token=v4mdo2s8769e&lat=30.0374562&long=31.2095052&cat=0&page=$currentPage");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (isRefresh) {
        passengers = result;
      }else{
        passengers.addAll(result);
      }

      currentPage++;

      // totalPages = result[4];

      print(response.body);
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite List Pagination"),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getPassengerData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getPassengerData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(passengers[index]['name']),
              subtitle: Text(passengers[index]['address']),
              trailing: Text(passengers[index]['phone'],  style: TextStyle(color: Colors.green),),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: passengers.length,
        ),
      ),
    );
  }
}