class Task {
  String title;
  String description;
  DateTime dueDate;
  String status;
  String? blockedBy;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    this.blockedBy,
  });
}