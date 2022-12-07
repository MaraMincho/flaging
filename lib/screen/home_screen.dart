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
  final snapshot = await ref.child('ChatList').get();
  var data = jsonEncode(snapshot.value);
  print(data);
  //SetData();

  return data;
}

Future<void> SetData() async{
  DatabaseReference ref2 = await FirebaseDatabase.instance.ref('/ChatList/0');
  for(int i =0; i< messages.length; i++) {
    ref2.update({
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
          List<List<Chat>> ChatRoom = [];
          List<Chat> list= [];
          var temp = jsonDecode(snapshot.data);
          for (dynamic i in temp) {
            for (var j in i) {
              list.add(Chat.fromJson(j));
            }
            ChatRoom.add(list);
          }
          return Column(
            children: [
              ProfileViewer(),
              Expanded(
                child: ListView.builder(
                  itemCount: ChatRoom.length,
                  itemBuilder: (BuildContext context, int index) {
                    //final Chat chat = list[index]; //chat
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>ChatScreen(
                          index: index, user: Sender(
                          imageUrl: "images/icnos/steelo.png",
                          name: "누구?",
                          id: "1",
                          isOnline: "true"
                        ),
                        ));
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
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage('${ChatRoom[index].last.sender?.imageUrl}'),
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
                                            '${ChatRoom[index].last.sender?.name}', //채팅방 이름
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${ChatRoom[index].last.time}', // 시간대
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
                                      '${ChatRoom[index].last.text}',
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
