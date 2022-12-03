import 'package:flaging/screen/home_screen.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
class User {
  String? id;
  String? name;
  String? imageUrl;
  User({
    this.id,
    this.name,
    this.imageUrl
  });
}

class UserController extends GetxController{
  var user = new User(
    id: "1",
    name: "누구?",
    imageUrl: "images/icons/steelo.png"
  ).obs;

  void change({
    required String id, required String paraname, required String paraimageurl
}) {
    user.update((val) {
      val?.id = id;
      val?.imageUrl = paraimageurl;
      val?.name = paraname;
    });
  }
}

class SetChat extends GetxController{
  var user = new User();
  var Chats = <Chat>[];
}