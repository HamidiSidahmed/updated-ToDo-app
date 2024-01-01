import 'package:hive/hive.dart';

part 'data_base.g.dart';

@HiveType(typeId: 1)
class DataBase {
  @HiveField(0)
  String title;

  @HiveField(1)
  String note;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String start;

  @HiveField(4)
  String end;

  @HiveField(5)
  int remind;

  @HiveField(6)
  String repeat;

  @HiveField(7)
  int color;
  DataBase(
      {required this.title,
      required this.note,
      required this.date,
      required this.start,
      required this.end,
      required this.remind,
      required this.repeat,
      required this.color});
}
