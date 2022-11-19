
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class GetXController extends GetxController{
  var userdata = User();
  late RxString userName;
  late RxString userImgae;
  late RxDouble font;

  void SetUser() {
    userName = userdata.name.toString().obs;
    userImgae = userdata.ImageUrl.toString().obs;
  }

  // RxDouble LargeSizeFont = 0.obs as RxDouble;
  // RxDouble MediumSizeFont = 0.obs as RxDouble;
  // RxDouble SmallSizeFont = 0.obs as RxDouble;
  // void SetFontSize(BuildContext context) {
  //   font = MediaQuery.of(context).size.width as RxDouble;
  //   LargeSizeFont = (font / 6) as RxDouble;
  //   MediumSizeFont = (font / 15) as RxDouble;
  //   SmallSizeFont = (font / 20) as RxDouble;
  // }
}

class User {
  final name;
  final ImageUrl;
  User({
    this.name = '정다함',
    this.ImageUrl = 'images/icons/steelo.png',
});
}