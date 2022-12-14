import 'dart:convert';
import 'dart:io';

import 'package:flaging/screen/AddBoard.dart';
import 'package:flaging/screen/main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BoardList extends StatefulWidget {
  const BoardList({Key? key}) : super(key: key);

  @override
  State<BoardList> createState() => _BoardListState();
}


Future<String> fetchBoardlist() async {
  print("여기까지는?");
  String url = "http://15.164.142.62:8080/runnings";
  var response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization" : "Bearer 123"
      },
  );
  print(response.statusCode);
  print(response.body);
  return response.body;
}


class _BoardListState extends State<BoardList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchBoardlist(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Scaffold(
              appBar: AppBar(),
              body: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async{
                                   fetchBoardlist();
                                  },
                                  child: Text(
                                    '정왕1동',
                                    style: TextStyle(
                                        fontSize: 25, letterSpacing: -1.5),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(InsertBoard());
                              },
                              child: Icon(
                                Icons.add,
                                size: 30,
                              ),
                            )
                          ],
                        ), //위에
                        cardcapturecherry(),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Card cardcapturecherry() {
    return Card(
      borderOnForeground: true,

      child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(child: profileicons(),
                  alignment: Alignment.topLeft,),
                SizedBox(width: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('정다함',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.5,
                          height: 1

                      ),),
                    Row(
                      children: [
                        Text('경기도 시흥시  |  3시간 전',
                          style: TextStyle(
                              fontSize: 13,
                              letterSpacing: -1.5
                          ),),
                      ],
                    )
                  ],
                )
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(15, 15, 20, 0),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('모집중   ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffEA8E4C),
                              fontWeight: FontWeight.w700
                          ),),
                        Text('플로깅 빡세게 할 사람 구해요~')
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                )),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 20),
              alignment: Alignment.topLeft,
              child: Opacity(
                opacity: 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble,
                          size: 20,),
                        SizedBox(width: 8,),
                        Text("전 연령",
                          style: TextStyle(
                              fontSize: 12
                          ),),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_outlined,
                          size: 20,),
                        SizedBox(width: 8,),
                        Text("시간",
                          style: TextStyle(
                              fontSize: 12
                          ),),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.thumb_up,
                          size: 20,),
                        SizedBox(width: 8,),
                        Text("참여자",
                          style: TextStyle(
                              fontSize: 12
                          ),),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity - 30,
              height: 200,
              child: MapSample(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/icons/steelo.png'))
              ),
            )


          ],
        ),
      ),
    );
  }

  PhysicalModel profileicons() {
    return PhysicalModel(
      shape: BoxShape.circle,
      color: Colors.black,
      elevation: 5,

      child: Container(
        height: 100,
        width: 100,

        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(
                  'images/imgs/steelo.png'
              )
          ),
        ),
      ),
    );
  }
}