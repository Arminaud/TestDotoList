import 'package:flutter/material.dart';
import 'package:todoarminaud/utils/colors.dart';
import 'add_task_screen.dart';
import '../widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Gestion des Tâches'),
        backgroundColor: MyColors.secondaryColor,
        shape: Border.all(
          width: 1,
          color: MyColors.fourthColor,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskList(),
      ),
    );
  }
}