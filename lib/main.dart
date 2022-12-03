import 'package:firebase_core/firebase_core.dart';
import 'package:flaging/color_schemes.g.dart';
import 'package:flaging/firebase_options.dart';
import 'package:flaging/screen/login_Screen.dart';
import 'package:flaging/screen/main_Screen.dart';
import 'package:flaging/screen/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(GetMaterialApp(
    title: 'Flutter Demo',
    initialRoute: '/',
    routes: {
      '/' :(context) => LoginScreen(),
      MainScreen.routename :(context) => MainScreen(),
    },
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'gsans',
      colorScheme: lightColorScheme,
    ),
  ));
}

// return WebView(
// initialUrl: 'https://kauth.kakao.com/oauth/authorize?client_id=7f8c9995a36f55554348032c83b16b96&redirect_uri=http://15.164.142.62:8080/login/oauth2/code/kakao&response_type=code',
// javascriptMode: JavascriptMode.unrestricted
// );