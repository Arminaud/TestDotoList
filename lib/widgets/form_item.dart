import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoarminaud/utils/colors.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class FormItem extends StatelessWidget {
  final Task? task;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  FormItem({
    super.key,
    this.task,
  });

  /// Fonction permettant d'ajouter ou de modifier une tâche
  void _formAction(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (task == null) {
      Provider.of<TaskProvider>(context, listen: false).addTask(
        _titleController.text,
        _descriptionController.text,
      );
    } else {
      Provider.of<TaskProvider>(context, listen: false).updateTask(
        task!.id,
        _titleController.text,
        _descriptionController.text,
        task!.isComplete,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(
        milliseconds: 800
      ),
      backgroundColor: Colors.green,
      content: Text(
        'Opération réussite avec succès',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      )
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (task != null) {
      _titleController.text = task!.title;
      _descriptionController.text = task!.description;
    }
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Titre de la tâche",
              ),
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return "Ce champ est requis";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Description",
              ),
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return "Ce champ est requis";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: MyColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: MyColors.primaryColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: const Text("Annuler"),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextButton(
                      onPressed: () {
                        _formAction(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: MyColors.secondaryColor,
                        backgroundColor: MyColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Enregistrer"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}