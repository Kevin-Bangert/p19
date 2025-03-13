import 'dart:async';
import 'database_repository.dart';
import 'task.dart';

class MockDatabase implements DatabaseRepository {
  final List<Task> _tasks = []; // In-Memory-Datenbank als Liste
  int _nextId = 1; // Automatische ID-Vergabe

  @override
  Future<Task> insertTask(Task task) async {
    int id = task.id ?? _nextId++; // ID zuweisen, falls keine vorhanden
    Task newTask = Task(
      id: id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
    );
    _tasks.add(newTask);
    return newTask; // Rückgabe der eingefügten Aufgabe mit ID
  }

  @override
  Future<List<Task>> getTasks() async {
    return _tasks; // Rückgabe aller Aufgaben
  }

  @override
  Future<void> updateTask(Task task) async {
    if (task.id == null) {
      throw Exception('ID wird fürs Aktualisieren benötigt');
    }
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task; // Aufgabe ersetzen
    } else {
      throw Exception('Task nicht gefunden');
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    _tasks.removeWhere((t) => t.id == id); // Aufgabe mit ID löschen
  }
}
