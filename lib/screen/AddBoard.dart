import 'package:flutter/material.dart';

class InsertBoard extends StatefulWidget {
  const InsertBoard({Key? key}) : super(key: key);

  @override
  State<InsertBoard> createState() => _InsertBoardState();
}


class _InsertBoardState extends State<InsertBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('hello wolrd'),
        ],
      ),
    );
  }
}
