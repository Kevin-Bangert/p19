class Task {
  final int? id; // ID kann null sein, wird später gesetzt
  final String title;
  final String description;
  final bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}
