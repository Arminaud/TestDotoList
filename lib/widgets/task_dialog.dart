import 'package:flutter/material.dart';
import 'package:todoarminaud/utils/colors.dart';

import '../models/task.dart';

class TaskDialog extends StatelessWidget {
  final Task task;
  final Function onValidation;
  const TaskDialog({super.key, required this.task, required this.onValidation});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: MyColors.dangerColor,
                  size: 30,
                ),
                SizedBox(width: 5,),
                Text(
                  "SUPPRESSION",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  )
                ),
                SizedBox(width: 5,),
                Icon(
                  Icons.warning_amber_rounded,
                  color: MyColors.dangerColor,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: "Voulez-vous vraiment supprimer ",
                style: const TextStyle(
                  color: MyColors.primaryColor
                ),
                children: [
                  TextSpan(
                    text: task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const TextSpan(
                    text: " ?"
                  )
                ]
              )
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
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: MyColors.dangerColor,
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
                        onValidation();
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
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: MyColors.secondaryColor,
                        backgroundColor: MyColors.dangerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Valider"),
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
