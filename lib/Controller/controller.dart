import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do/dataBase/data_base.dart';

class TaskController extends GetxController {
  static late Box task;
  static int boxlength = 0;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> _initializeTaskBox() async {
    boxlength = task.length;
  }

  void addTask(DataBase database, String date) async {
    await task.add(database);
    update();
  }

 dynamic getTask(int index) {
    return task.getAt(index);
  }
}
