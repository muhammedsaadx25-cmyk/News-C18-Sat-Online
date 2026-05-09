import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/features/home/widgets/drawer_dropdown_section.dart';
import 'package:news/features/home/widgets/drawer_header_widget.dart';
import 'package:news/features/home/widgets/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.goToHome});

  final void Function() goToHome;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: Column(
        children: [
          const DrawerHeaderWidget(),
          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DrawerItem(
                  icon: Icons.home_filled,
                  title: "Go To Home",
                  onTap: goToHome,
                ),
                SizedBox(height: 24.h),
                const Divider(
                    height: 1, thickness: 1, color: ColorsManager.white),
                SizedBox(height: 24.h),
                DrawerDropdownSection(
                  title: "Theme",
                  icon: Icons.mode_night_outlined,
                  currentValue: "Dark",
                  items: const ["Light", "Dark"],
                  onChanged: (value) {},
                ),
                SizedBox(height: 24.h),
                const Divider(
                    height: 1, thickness: 1, color: ColorsManager.white),
                SizedBox(height: 24.h),
                DrawerDropdownSection(
                  title: "Language",
                  icon: Icons.language,
                  currentValue: "English",
                  items: const ["English", "Arabic"],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
