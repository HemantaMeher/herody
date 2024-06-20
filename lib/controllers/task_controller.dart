// lib/controllers/task_controller.dart
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  late Box<Task> taskBox;

  @override
  void onInit() {
    super.onInit();
    taskBox = Hive.box<Task>('tasks');
    loadTasks();
  }

  void loadTasks() {
    tasks.assignAll(taskBox.values.toList());
  }

  void addTask(Task task) {
    taskBox.add(task);
    tasks.add(task);
  }

  void editTask(int index, Task task) {
    taskBox.putAt(index, task);
    tasks[index] = task;
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);
    tasks.removeAt(index);
  }

  void toggleTaskCompletion(int index) {
    if (index >= 0 && index < tasks.length) {
      Task task = tasks[index];
      task.isCompleted = !task.isCompleted;
      taskBox.putAt(index, task);
      tasks[index] = task;
    }
  }
}
