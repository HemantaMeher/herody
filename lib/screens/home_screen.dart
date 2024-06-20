// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import './task_screen.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List App',style: TextStyle(color: Colors.white,fontFamily: "arial"),),
        centerTitle: true,
        backgroundColor: Colors.grey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
        ),
      ),
      body: Obx(() => ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          final task = taskController.tasks[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            padding: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(11),topRight: Radius.circular(11)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7
                  )
                ]
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(11),topRight: Radius.circular(11)),
              ),
              child: ListTile(
                leading: InkWell(
                  onTap: () => Get.to(() => TaskScreen(task: task, index: index)),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(1.2),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey.withOpacity(.5),
                        child: Icon(Icons.edit_outlined,color: Colors.black,),
                      ),
                    ),
                  ),
                ),
                title: Text(task.title, style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : null,color: Colors.white,fontWeight: FontWeight.w600,fontFamily: "arial")),
                subtitle: Text(task.description),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    taskController.toggleTaskCompletion(index);
                  },
                ),
                // onTap: () => Get.to(() => TaskScreen(task: task, index: index)),
                onLongPress: () {
                  // taskController.deleteTask(index);
                  _showMyDialog(context,index);
                },
              ),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => TaskScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }


  Future<void> _showMyDialog(context,index) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to delete this?',style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      taskController.deleteTask(index);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white
                    ),
                    child: const Text('Yes'),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey
                    ),
                    child: const Text('No'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
