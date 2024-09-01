import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoarminaud/utils/colors.dart';
import 'package:todoarminaud/widgets/task_dialog.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/edit_task_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  late TaskProvider? taskProvider;

  TaskItem({super.key, required this.task, this.taskProvider});

  /// Fonction permettant d'afficher la confirmation avant suppression de la tâche
  /// [task] est la tâche à supprimer
  void _showTaskDialog(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: TaskDialog(
            task: task,
            onValidation: () {
              taskProvider!.deleteTask(task.id);
            },
          ),
        );
      },
    );
  }

  Widget _renderCheckBox() {
    if (!task.isComplete) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey[600]!,
            width: 2,
          ),
        ),
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(top: 6),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(top: 6),
      alignment: Alignment.center,
      child: const Icon(
        Icons.check,
        size: 14,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: task.isComplete ? MyColors.thirdColor : MyColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 5,
            spreadRadius: 1,
            blurStyle: BlurStyle.normal,
            offset: const Offset(3, 3)
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                taskProvider!.updateTask(task.id, task.title, task.description, !task.isComplete);
              },
              child: _renderCheckBox(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(task: task),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                      ),
                    ),
                    Text(
                      task.description,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _showTaskDialog(context, task);
              //taskProvider.deleteTask(task.id);
            },
            child: Container(
              height: 65,
              width: 45,
              child: const Icon(
                Icons.delete_outline_rounded,
                color: MyColors.dangerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}