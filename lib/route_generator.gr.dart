// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import 'screen/googlemap.dart' as _i4;
import 'screen/login_Screen.dart' as _i1;
import 'screen/main_Screen.dart' as _i2;
import 'screen/mypage.dart' as _i3;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LoginScreen.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
      );
    },
    MainScreen.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.MainScreen(),
      );
    },
    MyRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.MyPage(),
      );
    },
    GoogleMapShow.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.GoogleMapShow(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          LoginScreen.name,
          path: '/',
        ),
        _i5.RouteConfig(
          MainScreen.name,
          path: '/main-screen',
        ),
        _i5.RouteConfig(
          MyRoute.name,
          path: '/my-page',
        ),
        _i5.RouteConfig(
          GoogleMapShow.name,
          path: '/google-map-show',
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreen extends _i5.PageRouteInfo<void> {
  const LoginScreen()
      : super(
          LoginScreen.name,
          path: '/',
        );

  static const String name = 'LoginScreen';
}

/// generated route for
/// [_i2.MainScreen]
class MainScreen extends _i5.PageRouteInfo<void> {
  const MainScreen()
      : super(
          MainScreen.name,
          path: '/main-screen',
        );

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i3.MyPage]
class MyRoute extends _i5.PageRouteInfo<void> {
  const MyRoute()
      : super(
          MyRoute.name,
          path: '/my-page',
        );

  static const String name = 'MyRoute';
}

/// generated route for
/// [_i4.GoogleMapShow]
class GoogleMapShow extends _i5.PageRouteInfo<void> {
  const GoogleMapShow()
      : super(
          GoogleMapShow.name,
          path: '/google-map-show',
        );

  static const String name = 'GoogleMapShow';
}
