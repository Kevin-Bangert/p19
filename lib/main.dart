import 'package:flutter/material.dart';
import 'database_repository.dart';
import 'mock_database.dart';
import 'task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late DatabaseRepository repo; // Repository-Instanz
  List<Task> tasks = []; // Liste der Aufgaben

  @override
  void initState() {
    super.initState();
    repo = MockDatabase(); // MockDatabase verwenden
    _loadTasks(); // Aufgaben beim Start laden
  }

  Future<void> _loadTasks() async {
    List<Task> loadedTasks = await repo.getTasks();
    setState(() {
      tasks = loadedTasks; // Zustand aktualisieren
    });
  }

  Future<void> _addTask() async {
    Task newTask = Task(
      title: 'Neue Aufgabe',
      description: 'Beschreibung',
      isCompleted: false,
    );
    await repo.insertTask(newTask);
    _loadTasks(); // Liste nach Hinzufügen aktualisieren
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aufgaben')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            trailing: Checkbox(
              value: tasks[index].isCompleted,
              onChanged: (value) {
                // Hier könnte man die Aufgabe aktualisieren
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask, // Neue Aufgabe hinzufügen
        child: Icon(Icons.add),
      ),
    );
  }
}
