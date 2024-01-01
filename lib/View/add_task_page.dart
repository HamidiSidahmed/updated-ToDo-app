import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Controller/controller.dart';
import 'package:to_do/Utils/cutom_field.dart';
import 'package:to_do/View/home_page.dart';
import 'package:to_do/dataBase/data_base.dart';

import '../Controller/theme_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

TaskController taskController = Get.find();
TextEditingController TitleController = TextEditingController();
TextEditingController NoteController = TextEditingController();
TextEditingController RemindController = TextEditingController();
TextEditingController ReapeatController = TextEditingController();
TextEditingController StartController = TextEditingController();
TextEditingController EndController = TextEditingController();
TextEditingController DateController = TextEditingController();

TimeOfDay? start_time = TimeOfDay.now();
TimeOfDay? end_time = TimeOfDay.now();
int selected_color = 0;
List<int> remiders = [5, 10, 15, 20, 25];
int? selected_reminder = 5;
List<String> repeat = ["None", "Daily", "Weekly", "Monthly"];
String? selected_repeat = "None";

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ThemeService.GetThemeState() ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          Icon(
            Icons.person,
            color: ThemeService.GetThemeState() ? Colors.white : Colors.black,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, top: 25, bottom: 5),
              child: Text(
                "Add Task",
                style: GoogleFonts.lato(
                    fontSize: 23.sp, fontWeight: FontWeight.bold),
              ),
            ),
            CustomField(
              title: "Title",
              hint: "Enter title here",
              controller: TitleController,
              widget: Container(
                width: 0,
              ),
              read_only: false,
            ),
            CustomField(
              title: "Note",
              hint: "Enter note here",
              controller: NoteController,
              widget: Container(width: 0),
              read_only: false,
            ),
            CustomField(
              title: "Date",
              hint: "${DateFormat.yMd().format(date)}",
              controller: TextEditingController(),
              widget: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Container(
                          color: ThemeService.GetThemeState()
                              ? Color(0xFF121212)
                              : Colors.grey[100],
                          height: 150.h,
                          child: CupertinoDatePicker(
                            onDateTimeChanged: (value) {
                              setState(() {
                                date = value;
                              });
                            },
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                          ));
                    },
                  );
                },
                child: Icon(Icons.calendar_today),
              ),
              read_only: true,
            ),
            Row(
              children: [
                Container(
                  width: 190.w,
                  child: CustomField(
                    title: "Start",
                    hint: start_time == null
                        ? "${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}"
                        : "${start_time!.hour.toString().padLeft(2, '0')}:${start_time!.minute.toString().padLeft(2, '0')}",
                    controller: StartController,
                    widget: GestureDetector(
                      onTap: () async {
                        start_time = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dial,
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        setState(() {
                          start_time;
                        });
                      },
                      child: Icon(Icons.access_time),
                    ),
                    read_only: true,
                  ),
                ),
                Container(
                    width: 190.w,
                    child: CustomField(
                      title: "End",
                      hint: end_time == null
                          ? "${(TimeOfDay.now().hour + 1).toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}"
                          : "${end_time!.hour.toString().padLeft(2, '0')}:${end_time!.minute.toString().padLeft(2, '0')}",
                      controller: EndController,
                      widget: GestureDetector(
                        onTap: () async {
                          end_time = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.dial,
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          setState(() {
                            end_time;
                          });
                        },
                        child: Icon(Icons.access_time),
                      ),
                      read_only: true,
                    )),
              ],
            ),
            CustomField(
              title: "Remind",
              hint: "$selected_reminder minutes early",
              controller: EndController,
              widget: Container(
                width: 25.w,
                child: DropdownButton(
                  underline: Container(
                    height: 0,
                  ),
                  elevation: 4,
                  padding: EdgeInsets.only(top: 0, right: 10),
                  isExpanded: true,
                  menuMaxHeight: 100,
                  items: [
                    DropdownMenuItem(
                        value: remiders[0],
                        child: Text(remiders[0].toString())),
                    DropdownMenuItem(
                        value: remiders[1],
                        child: Text(remiders[1].toString())),
                    DropdownMenuItem(
                        value: remiders[2],
                        child: Text(remiders[2].toString())),
                    DropdownMenuItem(
                        value: remiders[3],
                        child: Text(remiders[3].toString())),
                    DropdownMenuItem(
                        value: remiders[4],
                        child: Text(remiders[4].toString())),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selected_reminder = value;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: ThemeService.GetThemeState()
                        ? Colors.grey[100]
                        : Colors.grey[400],
                  ),
                ),
              ),
              read_only: true,
            ),
            CustomField(
              title: "Repeat",
              hint: "$selected_repeat",
              controller: EndController,
              widget: Container(
                width: 60,
                child: DropdownButton(
                  underline: Container(
                    height: 0,
                  ),
                  elevation: 4,
                  padding: EdgeInsets.only(top: 0, right: 10),
                  isExpanded: true,
                  menuMaxHeight: 100.h,
                  items: [
                    DropdownMenuItem(value: repeat[0], child: Text(repeat[0])),
                    DropdownMenuItem(value: repeat[1], child: Text(repeat[1])),
                    DropdownMenuItem(value: repeat[2], child: Text(repeat[2])),
                    DropdownMenuItem(value: repeat[3], child: Text(repeat[3])),
                  ],
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      selected_repeat = value;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: ThemeService.GetThemeState()
                        ? Colors.grey[100]
                        : Colors.grey[400],
                  ),
                ),
              ),
              read_only: true,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25.w, top: 25.h),
                      child: Text(
                        "Color",
                        style: GoogleFonts.lato(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected_color = 0;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 25.w, top: 5.h),
                            child: CircleAvatar(
                              maxRadius: 12,
                              backgroundColor: Color(0xFF4e5ae8),
                              child: selected_color == 0
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected_color = 1;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15.w, top: 5.h),
                            child: CircleAvatar(
                                maxRadius: 12,
                                backgroundColor: Colors.red,
                                child: selected_color == 1
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : null),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selected_color = 2;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15.w, top: 5.h),
                            child: CircleAvatar(
                                maxRadius: 12,
                                backgroundColor: Colors.amber,
                                child: selected_color == 2
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18.sp,
                                      )
                                    : null),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    taskController.addTask(
                        DataBase(
                            title: TitleController.text,
                            note: NoteController.text,
                            date: date,
                            start: start_time == null
                                ? "${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}"
                                : "${start_time!.hour.toString().padLeft(2, '0')}:${start_time!.minute.toString().padLeft(2, '0')}",
                            end: end_time == null
                                ? "${(TimeOfDay.now().hour + 1).toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}"
                                : "${end_time!.hour.toString().padLeft(2, '0')}:${end_time!.minute.toString().padLeft(2, '0')}",
                            remind: selected_reminder!,
                            repeat: selected_repeat!,
                            color: selected_color),
                        date.toString());
                   HomePage.list_key.currentState!.insertItem(TaskController.task.length-1,duration: Duration(seconds: 1));
                    setState(() {
                      HomePage.box_length = TaskController.task.length;
                    });

                    Get.back();
                  },
                  child: Container(
                    width: 125.w,
                    height: 55.h,
                    margin: EdgeInsets.only(left: 125.w, top: 30.h),
                    child: Center(
                        child: Text(
                      "+ Create Task",
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
          ],
        ),
      ),
    );
  }
}
