import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/resources/routes_manager.dart';

import 'config/theme/theme_manager.dart';

void main() {
  runApp(const News());
}

class News extends StatelessWidget {
  const News({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,_)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: RoutesManger.routes,
        initialRoute: RoutesManger.homeScreen,
        theme: ThemeManager.light,
        darkTheme:ThemeManager.dark ,
        themeMode: ThemeMode.light ,

      ),

    );
  }
}
