import 'package:flutter/foundation.dart';
import 'task.dart';

abstract class DatabaseRepository {
  Future<Task> insertTask(Task task); // Neue Aufgabe einfügen
  Future<List<Task>> getTasks(); // Alle Aufgaben abrufen
  Future<void> updateTask(Task task); // Aufgabe aktualisieren
  Future<void> deleteTask(int id); // Aufgabe löschen
}
