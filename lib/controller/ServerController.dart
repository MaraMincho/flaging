import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


Future<dynamic> GetData() async {
  var url = 'http://15.164.142.62:8080/members/me';
  Map<String, String> headers2 = {
    "authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyNTM3ODk3MzQ0In0.dm6bAl8ijiATgbc4IPlX9zW39lgRBjMjurf6LbcKsBU",
    "accept": "application/json",
    "content-type":"application/json"
  };
  final response = await http.get(
      Uri.parse(url),
      headers: headers2
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
    return response.body;
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('실패 ㅠㅠ');
  }
}


Future<String> insertMemberdata() async {
  var url = 'http://15.164.142.62:8080/runnings';
  Map<String, String> headers2 = {
    "authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyNTM3ODk3MzQ0In0.dm6bAl8ijiATgbc4IPlX9zW39lgRBjMjurf6LbcKsBU",
    "accept": "application/json",
    "content-type":"application/json"
  };
  final msg = jsonEncode({
    "title": "러닝 타이틀",
    "content": "러닝 본문",
    "doName": "러닝 도네임",
    "sigungu": "러닝 시군구",
    "location": "러닝 로케이션",
    "runningDate": "2022-05-27T14:43:18.4804722",
    "runningAgeType": "TEENAGE",
    "maxPeople": "10",
    "imgUrlList": [
      "www.가나다라.com",
      "www.마바사.com",
      "www.아자차카.com",
      "www.타파하.com"
    ]
  });
  final response = await http.post(
      Uri.parse(url),
      body: msg,
      headers: headers2
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
    return response.body;
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('실패 ㅠㅠ');
  }
}