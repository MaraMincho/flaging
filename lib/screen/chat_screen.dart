import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flaging/asset/ChatBubble.dart';
import 'package:flutter/material.dart';
import 'package:flaging/models/message_model.dart';
import 'package:flaging/models/user_model.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';


class ChatScreen extends StatefulWidget {
  var SendMessage = TextEditingController();
  final User? user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _sendMessageArea(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: widget.SendMessage,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () async{
              DatabaseReference ref = await FirebaseDatabase.instance.ref('chats/');
              ref.set(
                '$index'
              );
              print(widget.SendMessage.text);
            },
          ),
        ],
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    String? prevUserId;

    Future<Stream<DatabaseEvent>> getref() async {
      var ref = await FirebaseDatabase.instance.ref().child('/chats').onValue;
      return ref;
    }
    var ref = getref();
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        title: Text('${widget.user?.name}'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref().child('/chats').onValue,
        builder: (context, AsyncSnapshot snapshot) {
          var Chats = jsonDecode(jsonEncode(snapshot.data.snapshot.value));
          print(Chats);
          List<Chat> ChatList = [];
          for (Map<String, dynamic> i in Chats) {
            ChatList.add(Chat.fromJson(i));
          }
          int ChatIndex = ChatList.length;
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: ChatList.length,
                  itemBuilder: (context, int index) {
                    Chat CurrentChat = ChatList[index];
                    //final Message message = messages[index];
                    final bool isMe = CurrentChat.sender?.id == ChatList[0].sender?.id;
                    final bool isSameUser = prevUserId == CurrentChat.sender?.id;
                    prevUserId = CurrentChat.sender?.id;
                    print(ChatIndex);
                    return chatBubble(CurrentChat, isMe, isSameUser, context);
                  },
                ),
              ),
              _sendMessageArea(ChatIndex),
            ],
          );
        },
      )
    );
  }
}
//


Future<String> getJsonFromFirebaseRestAPI(String InputUrl) async {
  String url = InputUrl.toString();
  http.Response response = await http.get(Uri.parse(url));
  print(response.body.runtimeType);
  return response.body;
}