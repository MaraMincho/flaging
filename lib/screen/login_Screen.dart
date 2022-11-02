import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaging/appvalue.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login_buttons/social_login_buttons.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 180,),
              Text('Move Eco and Echo',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
                letterSpacing: -6.5,
                shadows: [myShadow]
              ),),
              Text('Flagging',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 70,
                letterSpacing: -3,
                shadows: [myShadow],
              ),),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    SocialLoginButton(buttonType: SocialLoginButtonType.google, onPressed: () {
                    }),
                    SizedBox(height: 10,),
                    SocialLoginButton(buttonType: SocialLoginButtonType.github, onPressed: (){
                      signInWithGoogle();
                      FirebaseAuth auth = FirebaseAuth.instance;
                      if (auth.currentUser != null) {
                        print("체크가 널이 아닐 경우");
                        print(auth.currentUser!.uid);
                      }
                    }),
                    SizedBox(height: 50,),
                    Container(
                      height: 300,
                        width: 250,
                        child: Image.asset('images/imgs/trashCan.png',))
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  print(1);
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  print(2);
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print(3);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
