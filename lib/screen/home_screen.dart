import 'dart:collection';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flaging/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flaging/models/message_model.dart';
import 'package:get/get.dart';
import '../asset/Profile.dart';

class Chat {
  Sender? sender;
  String? text;
  String? time;
  String? unread;

  Chat({this.sender, this.text, this.time, this.unread});

  Chat.fromJson(Map<String, dynamic> json) {
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    text = json['text'];
    time = json['time'];
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['text'] = this.text;
    data['time'] = this.time;
    data['unread'] = this.unread;
    return data;
  }
}

class Sender {
  String? id;
  String? imageUrl;
  String? isOnline;
  String? name;

  Sender({this.id, this.imageUrl, this.isOnline, this.name});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isOnline = json['isOnline'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['isOnline'] = this.isOnline;
    data['name'] = this.name;
    return data;
  }
}


Future<dynamic> linking() async{
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('chats').get();
  var data = jsonEncode(snapshot.value);
  return data;
}

class ChatHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: linking(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError) {
          return Text('에러');
        }
        else {

          List<Chat> list= [];
          print("스냅샷1");
          var temp = jsonDecode(snapshot.data);
          print(temp[0].runtimeType);
          for (Map<String, dynamic> i in temp) {
            list.add(Chat.fromJson(i));
          }

          return Column(
            children: [
              ProfileViewer(),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Chat chat = list[index]; //chat
                    return GestureDetector(
                      onTap: (){
                        Get.to(ChatScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container( //읽었는지 안 읽었는지 확인해주는
                              padding: EdgeInsets.all(2),
                              decoration: chat.unread.toString() == 'true'! // 읽었는지 안 읽었는지 확인해 줌
                                  ? BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                                // shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              )
                                  : BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage('${chat.sender?.imageUrl}'),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            '${chat.sender?.name}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          chat.unread.toString() == 'true'! // 읽었는지 안 읽었는지 확인해주는...
                                              ? Container(
                                            margin: const EdgeInsets.only(left: 5),
                                            width: 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          )
                                              : Container(
                                            child: null,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${chat.time}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),


                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text( // 텍스트 표시
                                      '${chat.text}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ),
            ],
          );
        }

      },
    );
  }
}
