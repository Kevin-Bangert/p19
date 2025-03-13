import 'dart:async';
import 'database_repository.dart';
import 'task.dart';

class MockDatabase implements DatabaseRepository {
  final List<Task> _tasks = [];
  int _nextId = 1;

  @override
  Future<Task> insertTask(Task task) async {
    await Future.delayed(Duration(seconds: 1));
    int id = task.id ?? _nextId++;
    Task newTask = Task(
      id: id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
    );
    _tasks.add(newTask);
    return newTask;
  }

  @override
  Future<List<Task>> getTasks() async {
    await Future.delayed(Duration(seconds: 2));
    return _tasks;
  }

  @override
  Future<void> updateTask(Task task) async {
    await Future.delayed(Duration(seconds: 1));
    if (task.id == null) {
      throw Exception('Ohne ID kann die Aufgabe nicht aktualisiert werden');
    }
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    } else {
      throw Exception('Task nicht gefunden');
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    await Future.delayed(Duration(seconds: 3));
    _tasks.removeWhere((t) => t.id == id);
  }
}
