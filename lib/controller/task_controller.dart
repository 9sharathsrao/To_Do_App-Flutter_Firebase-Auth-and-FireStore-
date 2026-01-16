import 'package:todo/controller/database_helper.dart';
import 'package:todo/controller/firestore_helper.dart'; // Added this
import 'package:todo/model/task.dart'; 

class TaskController {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> loadTask() async {
    _tasks = await DatabaseHelper().getTask();
  }

  Future<void> addTask(String title, String date) async {
    // 1. Create task (isDone defaults to false/0)
    final task = Task(title: title, date: date, isDone: false); 
    
    // 2. Save to Local SQL and get the ID
    final id = await DatabaseHelper().insertTask(task);
    task.id = id;

    // 3. Save to Firestore
    await FirestoreHelper().addTaskFire(task);
    
    await loadTask();
  }

  // FIX: Added Firestore update here
  Future<void> updateTaskStatus(Task task, bool isDone) async {
  // 1. Create the updated task object
  final updatedTask = Task(
    id: task.id, 
    title: task.title, 
    date: task.date, 
    isDone: isDone
  );

  // 2. Update Local SQLite Database
  await DatabaseHelper().updateTask(updatedTask);

  // 3. Update Firestore Cloud Database
  // This is the missing piece for cloud sync!
  await FirestoreHelper().updateTaskFire(updatedTask);

  // 4. Refresh the local list so the UI knows the data changed
  await loadTask();
}

  Future<void> deleteTask(Task task) async {
    if (task.id != null) {
      await DatabaseHelper().deleteTask(task.id!);
      // Firestore delete is already handled inside your DatabaseHelper.deleteTask 
      // based on the code you showed me earlier.
      await loadTask();
    } else {
      print("Task ID is null");
    }
  }
}