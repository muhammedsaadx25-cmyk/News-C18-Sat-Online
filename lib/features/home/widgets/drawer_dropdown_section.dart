import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';

class DrawerDropdownSection extends StatelessWidget {
  const DrawerDropdownSection({
    super.key,
    required this.title,
    required this.icon,
    required this.currentValue,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final String currentValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: ColorsManager.white),
            SizedBox(width: 8.w),
            Text(
              title,
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
                currentValue,
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.white,
                ),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: currentValue,
                underline: Container(),
                items: items.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
