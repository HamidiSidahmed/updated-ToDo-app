import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  static bool isDark = false;
  static String key = "isDark";
 static final box = GetStorage();
 static void SaveThemeState(bool Dark) {
    box.write(key, Dark);
  }

 static bool GetThemeState() {
   
      if(box.read(key)==null) return false;
      else return box.read(key);
  }
 static ThemeMode theme(){
    return GetThemeState()==false?ThemeMode.light:ThemeMode.dark;
  }
  static void changeTheme(){
  Get.changeThemeMode(GetThemeState()==false?ThemeMode.light:ThemeMode.dark);
  }
}
