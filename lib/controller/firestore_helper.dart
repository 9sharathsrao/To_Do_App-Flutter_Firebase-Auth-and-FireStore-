import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/controller/database_helper.dart';
import 'package:todo/model/task.dart';

class FirestoreHelper{

  final _user = FirebaseAuth.instance.currentUser;

  late CollectionReference taskRef;

  //When class obj is created the constructor is the first who gets invoked.
  FirestoreHelper(){
    //Fetching user details
    taskRef = FirebaseFirestore.instance.collection('users').doc(_user!.uid).collection('tasks');

  }

  //Creating user before login
  createUser(User newuser) async{

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(newuser.uid);

    final docSnapshot = await userDoc.get();

    if(!docSnapshot.exists){
      await userDoc.set({
        //Setting the field
        "uid" : newuser.uid,
        "email" : newuser.email,
        "createdAt" : FieldValue.serverTimestamp(),
      });
    }
    else{
      print("User already Exists");
    }
  }

  //adding task to cloud
  addTaskFire(Task task) async{
    await taskRef.doc(task.id.toString()).set(task.toMap());
  }

  fetchTaskFire() async{
    //In snapshot we have stored these 'collection('tasks');'
    final snapshot = await taskRef.get();

    final dbHelper = DatabaseHelper(); // Create one instance

    for (var doc in snapshot.docs) {
      // Only insert locally, don't trigger another Firestore upload
      await dbHelper.insertTask(Task.fromMap(doc.data() as Map<String, dynamic>));
    }
  }

  updateTaskFire(Task task) async{
    await taskRef.doc(task.id.toString()).update(task.toMap());
  }

  deleteTask(String id) async{
    await taskRef.doc(id).delete();
  }



}