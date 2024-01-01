import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/Controller/controller.dart';
import 'package:to_do/Controller/theme_service.dart';
import 'package:to_do/View/home_page.dart';
import 'package:to_do/Utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:to_do/dataBase/data_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();
  Hive.registerAdapter(DataBaseAdapter());
 TaskController.task = await Hive.openBox("TaskBox");
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(ScreenUtilInit(
    designSize: const Size(412, 898),
    minTextAdapt: true,
    splitScreenMode: true,
    ensureScreenSize: true,
    builder: (context, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        themeMode: ThemeService.theme(),
        darkTheme: Themes.dark,
        home: HomePage(),
      );
    },
  ));
}
