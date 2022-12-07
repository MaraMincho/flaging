import 'dart:convert';
import 'dart:io';
import 'package:flaging/screen/WebView.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaging/appvalue.dart';
import 'package:flaging/controller/Me.dart';
import 'package:flaging/screen/main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http ;

import '../controller/ServerController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String UserToken = "f5P2oO3NpkC0NTNip_Gg3I4HXFn10VC0ACHmFkYtCilxIQAAAYTge_RZ";

Future<String> Member2() async{
  String _url = "http://15.164.142.62:8080/members/";
  final response = await http.get(Uri.parse(_url),
  headers: {
    "authorization" : "$UserToken"
  });
  print(response.body);
  return response.body;
}
Future<void> signIn() async {
  final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
    'client_id' : '7f8c9995a36f55554348032c83b16b96',
    'redirect_uri' : 'http://15.164.142.62:8080/login/oauth2/code/kakao',
    'response_type': 'code',
  });

  final result = await FlutterWebAuth2.authenticate(
      url: url.toString(), callbackUrlScheme : "http");


  print(result);
  final body = Uri.parse(result).queryParameters;
  print(body);
}

Future<String> fetchInfo() async {
  var url = 'http://15.164.142.62:8080/members/me';
  Map<String, String> headers2 = {
    "authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyNTM3ODk3MzQ0In0.dm6bAl8ijiATgbc4IPlX9zW39lgRBjMjurf6LbcKsBU",
    "accept": "application/json",
    "content-type":"application/json"
  };
  final msg = jsonEncode({
    "nickname":"하이용^_^",
    "introduce": "??-_-"
  });
  final response = await http.patch(
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




class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Flexible(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, MainScreen.routename);
                  },
                  child: Text('Move Eco and Echo',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    letterSpacing: -6.5,
                    shadows: [myShadow]
                  ),),
                ),
              ),
              Flexible(
                child: Text('Flagging',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 70,
                  letterSpacing: -3,
                  shadows: [myShadow],
                ),),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SocialLoginButton(buttonType: SocialLoginButtonType.google, onPressed: () async{

                      GetData();



                    }),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        controller.change(id: '1', paraname: '누구세요', paraimageurl: 'images/icons/steelo.png');
                        print(controller.user.value.name);
                      },
                      child: Image.asset('images/icons/kakaotalk_login.png',
                      ),
                    ),
                    SizedBox(height: 10,),
                    SocialLoginButton(buttonType: SocialLoginButtonType.github, onPressed: (){
                      signInWithGoogle();
                    }),
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  alignment: Alignment.topCenter,
                    height: 300,
                    width: 250,
                    child: GestureDetector(
                      child: Image.asset(
                        'images/imgs/trashCan.png',
                      ),
                      onTap: () {
                        controller.change(id: '0', paraname: '이세돌', paraimageurl: 'images/icons/steelo.png');
                        print(controller.user.value.name);
                        //Navigator.pushNamed(context, MainScreen.routename);
                      },
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
