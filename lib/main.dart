import 'package:flutter/material.dart';
import 'models/task.dart';
import 'screens/add_task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Task> tasks = [];

  String searchQuery = "";
  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();

    tasks.add(
      Task(
        title: "Learn Flutter",
        description: "Build Task App",
        dueDate: DateTime.now(),
        status: "To-Do",
      ),
    );
  }

  // 🔥 Dependency logic
  bool isTaskBlocked(Task task) {
    if (task.blockedBy == null) return false;

    final dependency = tasks.firstWhere(
      (t) => t.title == task.blockedBy,
      orElse: () => Task(
        title: "",
        description: "",
        dueDate: DateTime.now(),
        status: "Done",
      ),
    );

    return dependency.status != "Done";
  }

  @override
  Widget build(BuildContext context) {

    List<Task> filteredTasks = tasks.where((task) {
      final matchesSearch = task.title
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesFilter = selectedFilter == "All"
          ? true
          : task.status == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
      ),
      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search tasks...",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          DropdownButton<String>(
            value: selectedFilter,
            items: ["All", "To-Do", "In Progress", "Done"]
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedFilter = value!;
              });
            },
          ),

          Expanded(
            child: filteredTasks.isEmpty
                ? Center(child: Text("No tasks found"))
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];

                      return Opacity(
                        opacity: isTaskBlocked(task) ? 0.5 : 1.0,
                        child: Card(
                          color: isTaskBlocked(task)
                              ? Colors.grey[300]
                              : Colors.white,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.status),

                            // 🔥 Tap to change status
                            onTap: () {
                              setState(() {
                                if (task.status == "To-Do") {
                                  task.status = "In Progress";
                                } else if (task.status == "In Progress") {
                                  task.status = "Done";
                                } else {
                                  task.status = "To-Do";
                                }
                              });
                            },

                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  tasks.remove(task);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddTaskScreen(existingTasks: tasks),
            ),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}