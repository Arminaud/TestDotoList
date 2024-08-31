import 'package:flutter/material.dart';
import 'package:todoarminaud/widgets/form_item.dart';
import '../utils/colors.dart';

class AddTaskScreen extends StatelessWidget {
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
        title: Text('Ajouter une Tâche'),
      ),
      body: FormItem()
    );
  }
}