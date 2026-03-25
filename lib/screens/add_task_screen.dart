import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final List<Task> existingTasks;

  AddTaskScreen({required this.existingTasks});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  // 🔥 Draft storage
  static String? draftTitle;
  static String? draftDescription;
  static String? draftStatus;

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  String selectedStatus = "To-Do";
  DateTime selectedDate = DateTime.now();
  String? blockedBy;

  bool isLoading = false; // 🔥 loading state

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: draftTitle ?? "");
    descriptionController = TextEditingController(text: draftDescription ?? "");

    selectedStatus = draftStatus ?? "To-Do";
  }

  // 🔥 UPDATED SAVE FUNCTION WITH DELAY
  void saveTask() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // ⏳ simulate delay
    await Future.delayed(Duration(seconds: 2));

    final newTask = Task(
      title: titleController.text,
      description: descriptionController.text,
      dueDate: selectedDate,
      status: selectedStatus,
      blockedBy: blockedBy,
    );

    // clear draft
    draftTitle = null;
    draftDescription = null;
    draftStatus = null;

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
              onChanged: (value) {
                draftTitle = value;
              },
            ),

            // Description
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
              onChanged: (value) {
                draftDescription = value;
              },
            ),

            SizedBox(height: 10),

            // Status
            DropdownButton<String>(
              value: selectedStatus,
              items: ["To-Do", "In Progress", "Done"]
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                  draftStatus = value;
                });
              },
            ),

            SizedBox(height: 10),

            // Blocked By (dynamic)
            DropdownButton<String>(
              hint: Text("Blocked By (optional)"),
              value: blockedBy,
              items: widget.existingTasks
                  .map((task) => DropdownMenuItem(
                        value: task.title,
                        child: Text(task.title),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  blockedBy = value;
                });
              },
            ),

            SizedBox(height: 20),

            // 🔥 Save Button with loading
            ElevatedButton(
              onPressed: isLoading ? null : saveTask,
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text("Save Task"),
            ),
          ],
        ),
      ),
    );
  }
}