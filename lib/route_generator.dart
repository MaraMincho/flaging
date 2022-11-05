import 'package:auto_route/annotations.dart';
import 'package:flaging/screen/googlemap.dart';
import 'package:flaging/screen/login_Screen.dart';
import 'package:flaging/screen/main_Screen.dart';
import 'package:flaging/screen/mypage.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, initial: true),
    AutoRoute(page: MainScreen),
    AutoRoute(page: MyPage),
    AutoRoute(page: GoogleMapShow),
  ],
)
class $AppRouter {}