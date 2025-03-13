import 'task.dart';

abstract class DatabaseRepository {
  Future<Task> insertTask(Task task);
  Future<List<Task>> getTasks();
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
}
