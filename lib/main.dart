import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/task_provider.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestion des Tâches',
        home: HomeScreen(),
      ),
    );
  }
}
