import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/Controller/controller.dart';
import 'package:to_do/View/add_task_page.dart';
import '../Controller/theme_service.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static GlobalKey<AnimatedListState> list_key = GlobalKey<AnimatedListState>();
  static int box_length = 0;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Tween<Offset> _val = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  List tasks = [];
  DateTime selected_date = DateTime.now();
  DateTime date=DateTime.now().subtract(Duration(days: 4));
  @override
  void initState() {
    super.initState();
      
    TaskController taskController = Get.put(TaskController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (int i = 0; i < TaskController.task.length; i++) {
        HomePage.box_length = i + 1;
        HomePage.list_key.currentState!
            .insertItem(i, duration: Duration(seconds: 1));
      }
    });
  }

  Color selectedColor(int index) {
    if (taskController.getTask(index).color == 0) {
      return Color(0xFF4e5ae8);
    } else if (taskController.getTask(index).color == 1)
      return Colors.red;
    else
      return Colors.amber;
  }

  bool compareDate(DateTime time1, DateTime time2) =>
      (time1.year == time2.year &&
          time1.month == time2.month &&
          time1.day == time2.day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                setState(() {
                  ThemeService.isDark = !ThemeService.isDark;
                });
                ThemeService.SaveThemeState(ThemeService.isDark);
                ThemeService.changeTheme();
                ;
              },
              child: Icon(
                ThemeService.GetThemeState()
                    ? Icons.wb_sunny_outlined
                    : Icons.nightlight_round,
                color:
                    ThemeService.GetThemeState() ? Colors.white : Colors.black,
              )),
          actions: [
            Icon(
              Icons.person,
              color: ThemeService.GetThemeState() ? Colors.white : Colors.black,
            ),
            SizedBox(
              width: 10.w,
            )
          ]),
      body: SafeArea(
        child: Column(children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        DateFormat.yMMMMd().format(DateTime.now()).toString(),
                        style: GoogleFonts.lato(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ThemeService.GetThemeState() == false
                                ? Colors.grey
                                : Colors.grey[400]),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 25.w),
                    child: Text(
                      "Today",
                      style: GoogleFonts.lato(
                          fontSize: 26.sp, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AddTaskPage(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: Container(
                  width: 125.w,
                  height: 55.h,
                  margin: EdgeInsets.only(left: 75.w, top: 15.h),
                  child: Center(
                      child: Text(
                    "+ Add Task",
                    style: TextStyle(color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF4e5ae8),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h, left: 25.w),
            child: DatePicker(DateTime.now(), daysCount: 10,
                onDateChange: (selectedDate) {
              setState(() {
                selected_date = selectedDate;
              });
            },
                selectionColor: Color(0xFF4e5ae8),
                height: 100.h,
                width: 75.w,
                selectedTextColor: Colors.white,
                initialSelectedDate: DateTime.now(),
                dateTextStyle: GoogleFonts.lato(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                dayTextStyle: GoogleFonts.lato(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                monthTextStyle: GoogleFonts.lato(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
          ),
          GetBuilder<TaskController>(
            builder: (controller) {
              return Expanded(
                child: AnimatedList(
                  padding: EdgeInsets.only(top: 20),
                  initialItemCount: HomePage.box_length,
                  key: HomePage.list_key,
                  itemBuilder: (context, index, animation) {
                    if (compareDate(
                        taskController.getTask(index).date, selected_date)) {
                      return SlideTransition(
                        position: animation.drive(_val),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 25.w, right: 25.w, bottom: 25.h),
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: selectedColor(index),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 12.w, top: 15.h),
                                    child: Text(
                                      "${taskController.getTask(index).title}",
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Icon(
                                          Icons.access_time_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 11.5,
                                          left: 5,
                                        ),
                                        child: Text(
                                          "${taskController.getTask(index).start} - ${taskController.getTask(index).end}",
                                          style: GoogleFonts.lato(
                                              color: Colors.grey.shade100,
                                              fontSize: 13.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10.w, top: 10.h, bottom: 15.h),
                                    width: 250.w,
                                    child: Text(
                                      "${taskController.getTask(index).note} ",
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 40.w, right: 20),
                                width: 1,
                                height: 75,
                                color: Colors.white,
                              ),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "TO DO",
                                  style: GoogleFonts.lato(
                                      color: Colors.white, fontSize: 12.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else if (TaskController.task.length == 0) {
                      return Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 100.h),
                              width: 150.w,
                              height: 150.w,
                              child: Image.asset(
                                "assets/Checklist.png",
                                fit: BoxFit.cover,
                              )),
                          Container(
                            child: Text("You do not have any task yet!",
                                style: GoogleFonts.lato()),
                          ),
                          Container(
                            child: Text(
                              "Add new tasksto make your day productive",
                              style: GoogleFonts.lato(),
                            ),
                          ),
                        ],
                      );
                    } else
                      return Container();
                  },
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
