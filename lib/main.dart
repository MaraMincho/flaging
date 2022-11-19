import 'package:firebase_core/firebase_core.dart';
import 'package:flaging/color_schemes.g.dart';
import 'package:flaging/firebase_options.dart';
import 'package:flaging/screen/chat_screen.dart';
import 'package:flaging/screen/home_screen.dart';
import 'package:flaging/screen/login_Screen.dart';
import 'package:flaging/screen/main_Screen.dart';
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

