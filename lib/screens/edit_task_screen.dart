import 'package:flutter/material.dart';
import 'package:todoarminaud/utils/colors.dart';
import 'package:todoarminaud/widgets/form_item.dart';
import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  EditTaskScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.secondaryColor,
        shape: Border.all(
          width: 1,
          color: MyColors.fourthColor,
        ),
        title: const Text('Modifier la Tâche'),
      ),
      body: FormItem(
        task: task,
      ),
    );
  }
}
