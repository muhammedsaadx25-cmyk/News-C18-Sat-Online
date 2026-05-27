import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 166.h,
      color: ColorsManager.white,
      child: Text(
        "News App",
        style: GoogleFonts.inter(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.black,
        ),
      ),
    );
  }
}
