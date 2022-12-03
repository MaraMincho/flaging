import 'package:flaging/controller/Me.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewer extends StatelessWidget {
  const ProfileViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final LargeSizeFont = (size.width / 7);
    final MediumSizeFont = (size.width / 15);
    final SmallSizeFont = (size.width / 20);
    var controller = Get.put(UserController());
    return
      Column( // 반응형 상태관리 - 1
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi\n${controller.user.value.name}',
                    style: TextStyle(
                        fontSize: LargeSizeFont,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1,
                        height: 1),
                  ), //profile 소개 멘트
                  Text(
                    '오늘도 힘차게 뛰어볼까요?',
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: -1.5
                    ),
                  ),
                ],
              ),

              Flexible(
                child: GestureDetector(
                  child: PhysicalModel(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    elevation: 5,

                    child: Container(
                      height: 120,
                      width: 120,

                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                '${controller.user.value.imageUrl}'
                            )
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  }
}
