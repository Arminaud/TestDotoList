import 'package:flutter_test/flutter_test.dart';
import 'package:todoarminaud/providers/task_provider.dart';
import 'package:todoarminaud/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Assure que les bindings nécessaires pour Flutter sont initialisés avant de démarrer les tests.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Avant chaque test, initialise `SharedPreferences` avec des valeurs fictives.
  // Cela simule l'état initial de `SharedPreferences` sans avoir besoin d'un accès aux services natifs.
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // Groupe de tests pour le `TaskProvider`.
  group('TaskProvider Tests', () {
    // Variable pour stocker une instance de `TaskProvider` utilisée dans chaque test.
    late TaskProvider taskProvider;

    // Avant chaque test, une nouvelle instance de `TaskProvider` est créée pour garantir un environnement de test isolé.
    setUp(() {
      taskProvider = TaskProvider();
    });

    // Test pour vérifier que la liste des tâches est vide à l'initialisation du `TaskProvider`.
    test('Initial tasks list should be empty', () {
      // On s'attend à ce que la liste des tâches soit vide après l'initialisation.
      expect(taskProvider.tasks, isEmpty);
    });

    // Test pour vérifier que l'ajout d'une tâche augmente la longueur de la liste des tâches.
    test('Add task should increase tasks list length', () async {
      // Ajoute une nouvelle tâche avec un titre et une description.
      await taskProvider.addTask('Test Task', 'This is a test task.');

      // On s'attend à ce que la liste des tâches contienne une tâche après l'ajout.
      expect(taskProvider.tasks.length, 1);

      // On vérifie que les détails de la tâche ajoutée sont corrects.
      expect(taskProvider.tasks[0].title, 'Test Task');
      expect(taskProvider.tasks[0].description, 'This is a test task.');
      expect(taskProvider.tasks[0].isComplete, false);
    });

    // Test pour vérifier que la mise à jour d'une tâche modifie correctement les détails de la tâche.
    test('Update task should modify the task details', () async {
      // Ajoute une nouvelle tâche pour qu'il y ait une tâche à mettre à jour.
      await taskProvider.addTask('Test Task', 'This is a test task.');

      // On récupère la tâche ajoutée pour la modifier.
      final task = taskProvider.tasks[0];

      // Mise à jour des détails de la tâche.
      await taskProvider.updateTask(task.id, 'Updated Task', 'This is an updated test task.', true);

      // On vérifie que les détails de la tâche ont été mis à jour correctement.
      expect(taskProvider.tasks[0].title, 'Updated Task');
      expect(taskProvider.tasks[0].description, 'This is an updated test task.');
      expect(taskProvider.tasks[0].isComplete, true);
    });

    // Test pour vérifier que la suppression d'une tâche diminue la longueur de la liste des tâches.
    test('Delete task should decrease tasks list length', () async {
      // Ajoute une nouvelle tâche pour qu'il y ait une tâche à supprimer.
      await taskProvider.addTask('Test Task', 'This is a test task.');

      // On récupère la tâche ajoutée pour la supprimer.
      final task = taskProvider.tasks[0];

      // Suppression de la tâche.
      await taskProvider.deleteTask(task.id);

      // On s'attend à ce que la liste des tâches soit vide après la suppression.
      expect(taskProvider.tasks, isEmpty);
    });
  });
}
