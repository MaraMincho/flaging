import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flaging/screen/boardlist.dart';
import 'package:flaging/screen/googlemap.dart';
import 'package:flaging/screen/login_Screen.dart';
import 'package:flaging/screen/main_Screen.dart';
import 'package:flaging/screen/mypage.dart';
part 'app_router.gr.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, initial: true),
    AutoRoute(page: MainScreen),
    AutoRoute(page: MyPage),
    AutoRoute(page: GoogleMapShow),
    AutoRoute(page: BoardList)
  ],
)
class $AppRouter {}