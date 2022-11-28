
import '../models/message_model.dart';
import 'package:flutter/material.dart';

import '../screen/home_screen.dart';


chatBubble(Chat message, bool isMe, bool isSameUser, BuildContext context) {
  if (isMe) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topRight,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80,
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Text(
              '${message.text} +3',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        !isSameUser
            ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              '${message.time} ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
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
                radius: 15,
                backgroundImage: AssetImage('images/icons/steelo.png'), //담는거
              ),
            ),
          ],
        )
            : Container(
          child: null,
        ),
      ],
    );
  } else {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80,
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Text(
              '${message.text} +44',  // 메시지 입력
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ),
        !isSameUser
            ? Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
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
                radius: 15,
                backgroundImage: AssetImage('images/icons/steelo.png'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '${message.time} +23',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        )
            : Container(
          child: null,
        ),
      ],
    );
  }
}