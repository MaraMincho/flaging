import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
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
                DatabaseReference ref = await FirebaseDatabase.instance.ref('/chats');

                for(int i =0; i< messages.length; i++) {
                  ref.update({
                    "${i}" : {
                      "sender" : {
                        "id" : "${messages[i].sender?.id}",
                        "imageUrl" : "${messages[i].sender?.imageUrl}",
                        "isOnline" : "${messages[i].sender?.isOnline}",
                        "name" : "${messages[i].sender?.name}"
                      },
                      "text" :"${messages[i].text}",
                      "time": "${messages[i].time}",
                      "unread": "${messages[i]}"
                    }
                  });
                }

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