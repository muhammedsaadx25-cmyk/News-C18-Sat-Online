import 'package:flutter/cupertino.dart';
import 'package:news/features/home/home_screen.dart';

abstract class RoutesManger{
  static const String homeScreen = '/homeScreen';

  static Map<String, WidgetBuilder> routes = {
    homeScreen : (_)=> HomeScreen(),
  };
}