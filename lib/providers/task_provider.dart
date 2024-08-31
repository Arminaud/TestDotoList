import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum DisplayState {
  all,
  active,
  completed,
}

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  DisplayState _displayState = DisplayState.all;

  DisplayState get displayState => _displayState;

  /// Récupérer la liste de tâches
  List<Task> get tasks {
    return switch (_displayState) {
      DisplayState.completed => _tasks.where((t) => t.isComplete).toList(),
      DisplayState.active => _tasks.where((t) => !t.isComplete).toList(),
      _ => _tasks,
    };
  }

  /// Récupérer le nombre total des tâches
  int get allCount => _tasks.length;

  /// Récupérer le nombre des tâches encours
  int get activeCount => _tasks.where((t) => !t.isComplete).length;

  /// Récupérer le nombre de tâches completes
  int get completedCount => _tasks.where((t) => t.isComplete).length;

  /// Initialiser la liste des tâches depuis notre base de données
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List<dynamic> decodedTasks = json.decode(tasksString);
      _tasks = decodedTasks.map((task) => Task(
        id: task['id'],
        title: task['title'],
        description: task['description'],
        isComplete: task['isComplete'],
      )).toList();
    }
    notifyListeners();
  }

  /// Ajouter une nouvelle tâche dans la liste de tâche
  /// et mettre à jour la base de données
  /// [title] est le titre de la tâche
  /// [description] est la description de la tâche
  Future<void> addTask(String title, String description) async {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    _tasks.add(newTask);
    await saveTasks();
    notifyListeners();
  }

  /// Mettre à jour une tâche de la liste de tâche
  /// et mettre à jour la base de données
  /// [id] est l'indentifiant de la tâche
  /// [title] est le titre de la tâche
  /// [description] est la description de la tâche
  Future<void> updateTask(String id, String title, String description, bool isComplete) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = Task(id: id, title: title, description: description, isComplete: isComplete);
      await saveTasks();
      notifyListeners();
    }
  }

  /// Supprimer une tâche de la liste de tâche
  /// et mettre à jour la base de données
  /// [id] est l'indentifiant de la tâche
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    await saveTasks();
    notifyListeners();
  }

  /// Enregister au format json la list de tâche dans la base de données
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedTasks = json.encode(_tasks.map((task) => {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'isComplete': task.isComplete,
    }).toList());
    await prefs.setString('tasks', encodedTasks);
  }

  /// Filtrer la liste
  void updateDisplayState(DisplayState newState) {
    _displayState = newState;
    notifyListeners();
  }
}