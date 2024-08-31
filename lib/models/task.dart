class Task {
  String id;
  String title;
  String description;
  bool isComplete;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isComplete = false,
  });
}