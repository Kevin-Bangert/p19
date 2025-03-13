import 'package:flutter/material.dart';
import 'database_repository.dart';
import 'task.dart';

class TaskListScreen extends StatefulWidget {
  final DatabaseRepository repo;

  const TaskListScreen({required this.repo, super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Future<List<Task>>? _tasksFuture;

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  void _refreshTasks() {
    _tasksFuture = widget.repo.getTasks();
    setState(() {});
  }

  Future<void> _addTask() async {
    final newTask = Task(
      title: 'New Task',
      description: 'Description',
      isCompleted: false,
    );
    await widget.repo.insertTask(newTask);
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: FutureBuilder<List<Task>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<Task> tasks = snapshot.data!;
            if (tasks.isEmpty) {
              return const Center(child: Text('No tasks available'));
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].description),
                  trailing: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (value) {
                      // Handle task update
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _addTask,
      ),
    );
  }
}
