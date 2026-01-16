//This contains core database code. SQL code like CRUD
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/controller/firestore_helper.dart';
import 'package:todo/model/task.dart';

class DatabaseHelper {
  static Database? _db;

  // //Method:- this will return a complete databse
  Future<Database> get db async{
    _db ??= await initDb();
    return _db!;
  }


  //Method which initializes the database
  Future<Database> initDb() async{
    final path = join(await getDatabasesPath(), 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''
          CREATE TABLE tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          date TEXT,
          isDone INTEGER)''');
      }
    );
  }

  //Method to CRUD operations
  //Create
  Future<int> insertTask(Task task) async{
    //fetching
    final dbClient = await db;
    int newId = await dbClient.insert('tasks', task.toMap());
    task.id = newId;
    // await FirestoreHelper().addTaskFire(task);
    return newId;
    
  }

  //Read
  Future<List<Task>> getTask() async{
    final dbClient = await db;
    
    final List<Map<String,dynamic>> maps = await dbClient.query('tasks');

    // List<Task> tasks = [];
    // maps.forEach((map){
    //   Task task = Task.fromMap(map);
    //   tasks.add(task);
    // });
    // return tasks;

    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  //Update
  Future<int> updateTask(Task task) async{
    final dbClient = await db;

    await FirestoreHelper().updateTaskFire(task);

    return await dbClient.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  //Delete
  Future<int> deleteTask(int id) async{

    await FirestoreHelper().deleteTask(id.toString());
    final dbClient = await db;
    return await dbClient.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }


  deleteMyDb() async{
    final path = join(await getDatabasesPath(), 'todo.db');
    await deleteDatabase(path);
  }

  // Inside DatabaseHelper class
Future<void> resetDatabase() async {
  if (_db != null) {
    await _db!.close(); // Properly close the connection
    _db = null;         // This is the most important line!
  }
  final path = join(await getDatabasesPath(), 'todo.db');
  await deleteDatabase(path); // Delete the old file
}
}
