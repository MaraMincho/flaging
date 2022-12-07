import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flaging/asset/ChatBubble.dart';
import 'package:flaging/controller/Me.dart';
import 'package:flutter/material.dart';
import 'package:flaging/models/message_model.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';
class ChatScreen extends StatefulWidget {
  var SendMessage = TextEditingController();
  final Sender? user;
  final int index;
  ChatScreen({required this.index, this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var controller = Get.put(UserController());
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
              final DateTime now = DateTime.now();
              final DateFormat formatter = DateFormat('jm');
              final String formatted = formatter.format(now);
              print(formatted); // something like 2013-04-20

              DatabaseReference ref = await FirebaseDatabase.instance.ref('/ChatList/${widget.index}');
              ref.update({
                "${index}" : {
                  "sender" : {
                    "id" : "${controller.user.value.id}",
                    "imageUrl" : "${controller.user.value.imageUrl}",
                    "isOnline" : "${messages[0].sender?.isOnline}",
                    "name" : "${controller.user.value.name}"
                  },
                  "text" :"${widget.SendMessage.text}",
                  "time": "${formatted}",
                  "unread": "${messages[0].unread}"
                }
              }
              );
              widget.SendMessage.text = '';
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
        title: Text('채팅방이름~'), //채팅방 이름
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref().child('/ChatList/${widget.index}').onValue,
        builder: (context, AsyncSnapshot snapshot) {

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Text(
              '${snapshot.hasError.toString()}'
            );
          }
          else{
            var Chats = jsonDecode(jsonEncode(snapshot.data.snapshot.value));
            List<Chat> ChatList = [];
            for (Map<String, dynamic> i in Chats) {
              ChatList.add(Chat.fromJson(i));
            }
            int ChatIndex = ChatList.length;



            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    controller: ScrollController(
                      initialScrollOffset: context.height,
                    ),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20),
                    itemCount: ChatList.length,
                    itemBuilder: (context, int index) {
                      Chat CurrentChat = ChatList[index];
                      //final Message message = messages[index];
                      final bool isMe = CurrentChat.sender?.id == controller.user.value.id;
                      final bool isSameUser = prevUserId == CurrentChat.sender?.id;
                      prevUserId = CurrentChat.sender?.id;
                      return chatBubble(CurrentChat, isMe, isSameUser, context);
                    },
                  ),
                ),
                _sendMessageArea(ChatIndex),
              ],
            );
          }
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