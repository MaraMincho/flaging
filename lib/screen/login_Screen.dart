import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaging/appvalue.dart';
import 'package:flaging/screen/main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
                child: Text('Move Eco and Echo',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  letterSpacing: -6.5,
                  shadows: [myShadow]
                ),),
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
                    SocialLoginButton(buttonType: SocialLoginButtonType.google, onPressed: () {
                      if (auth != null) {
                        print("로그인 했습니당.");
                        print(auth.currentUser);
                      }
                      else{
                        print("로그인 안했습니당.");
                      }
                    }),
                    SizedBox(height: 10,),
                    GestureDetector(
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
                        Get.to(const MainScreen());
                        Navigator.pushNamed(context, MainScreen.routename);
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
