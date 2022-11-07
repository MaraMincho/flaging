import 'package:flaging/appvalue.dart';
import 'package:flutter/material.dart';
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
              SizedBox(height: 170,),
              SizedBox(height: 10,),
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
                    SocialLoginButton(buttonType: SocialLoginButtonType.google, onPressed: (){}),
                    SizedBox(height: 10,),
                    SocialLoginButton(buttonType: SocialLoginButtonType.github, onPressed: (){}),
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
