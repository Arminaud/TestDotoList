import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoarminaud/utils/colors.dart';
import 'package:todoarminaud/widgets/task_item.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      var newState = switch (index) {
                        0 => DisplayState.all,
                        1 => DisplayState.active,
                        _ => DisplayState.completed
                      };
                      final provider =
                      Provider.of<TaskProvider>(context, listen: false);
                      provider.updateDisplayState(newState);
                    },
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8)),
                    selectedColor: MyColors.secondaryColor,
                    fillColor: MyColors.primaryColor,
                    textStyle: const TextStyle(fontSize: 12),
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 90,
                    ),
                    isSelected: [
                      taskProvider.displayState == DisplayState.all,
                      taskProvider.displayState == DisplayState.active,
                      taskProvider.displayState == DisplayState.completed,
                    ],
                    children: [
                      Text("Tout (${taskProvider.allCount})"),
                      Text("En cours (${taskProvider.activeCount})"),
                      Text("Terminé (${taskProvider.completedCount})"),
                    ],
                  ),
                ],
              ),
            ),
            taskProvider.tasks.isEmpty ?  const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.hide_source_rounded,
                    size: 30,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Aucunne tâche trouvée ...",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  )
                ],
              ),
            ):
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = taskProvider.tasks[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TaskItem(task: task,),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 70,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}