import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.goToHome});

  final void Function() goToHome;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: Column(
        children: [
          Container(
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
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    goToHome();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.home_filled, color: ColorsManager.white),
                      SizedBox(width: 8),
                      Text(
                        "Go To Home",
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
                Divider(height: 1, thickness: 1, color: ColorsManager.white),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Icon(Icons.mode_night_outlined, color: ColorsManager.white),
                    SizedBox(width: 8),
                    Text(
                      "Theme",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(width: 1, color: ColorsManager.white),
                  ),

                  child: Row(
                    children: [
                      Text(
                        "Dark",
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.white,
                        ),
                      ),
                      Spacer(),
                      DropdownButton(
                        underline: Container(),
                        items: ["Light", "Dark"].map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Divider(height: 1, thickness: 1, color: ColorsManager.white),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Icon(Icons.language, color: ColorsManager.white),
                    SizedBox(width: 8),
                    Text(
                      "Language",
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(width: 1, color: ColorsManager.white),
                  ),

                  child: Row(
                    children: [
                      Text(
                        "English",
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.white,
                        ),
                      ),
                      Spacer(),
                      DropdownButton(
                        underline: Container(),
                        items: ["English", "Arabic"].map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
