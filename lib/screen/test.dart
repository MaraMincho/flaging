import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/message_model.dart';
import '../models/user_model.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async{
                Future<String> getjson() async {
                  String url = "https://jsonplaceholder.typicode.com/comments";
                  http.Response response = await http.get(Uri.parse(url));
                  return response.body;
                };
                var temp = await getjson();
                List<model> list = [];
                var jsonvalue = jsonDecode(temp);
                for (var i in jsonvalue) {
                  list.add(model.fromjson(i));
                }
                // for (var i in temp) {
                //   print(i['id']);
                //   list.add(model.fromjson(i));
                // }
                print(list.length);
              },
              child: Text('불러와라'),
            ),

          ],
        ),
      ),
    );
  }

  Future<String> getJsonFromFirebaseRestAPI() async {
    String url = "https://flutterdemo-f6d47.firebaseio.com/chartSalesData.json";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
}

class model {
  int? PostId;
  int? id;
  String? name;
  String? email;
  String? body;

  model({this.PostId, this.body, this.name, this.id, this.email});

  factory model.fromjson(Map<dynamic, dynamic> json) {
    return model(
      name: json['name'],
      body: json['id'],
      email: json['email'],
      id: json['id'],
      PostId: json['PostId']
    );
  }
}