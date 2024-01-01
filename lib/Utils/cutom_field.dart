import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/Controller/theme_service.dart';

class CustomField extends StatelessWidget {
  String title, hint;
  TextEditingController controller;
  Widget widget;
  bool read_only;
  CustomField(
      {required this.title,
      required this.hint,
      required this.controller,
      required this.widget,
      required this.read_only});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 25.w, top: 25.h),
          child: Text(
            title,
            style:
                GoogleFonts.lato(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 23.w, top: 5.h),
          height: 52.h,
          width: 360.w,
          child: TextFormField(
            
              style: GoogleFonts.lato(fontSize: 14.sp,),
              textAlignVertical: TextAlignVertical.bottom,
              readOnly: read_only,
              controller: controller,
              autofocus: false,
              cursorColor: ThemeService.GetThemeState()
                  ? Colors.grey[100]
                  : Colors.grey[400],
              decoration: InputDecoration(
                  suffixIconColor: ThemeService.GetThemeState()
                      ? Colors.grey[100]
                      : Colors.grey[400],
                  suffixIcon: widget,
                  hintText: hint,
                  hintStyle: GoogleFonts.lato(fontSize: 14.sp),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)))),
        )
      ],
    );
  }
}
