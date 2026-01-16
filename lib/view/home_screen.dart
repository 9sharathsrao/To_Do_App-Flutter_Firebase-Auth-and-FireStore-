import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/controller/auth_helper.dart';
import 'package:todo/controller/task_controller.dart';
import 'package:todo/model/task.dart';
import 'package:todo/view/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _controller = TaskController();

  //below is a method of stateful Wid. This runs/calls before first state is even created.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await _controller.loadTask();
    setState(() {});
  }

  Future<void> _toggleTask(Task task, bool? value) async {
    await _controller.updateTaskStatus(task, value!);
    setState(() {});
  }

  Future<void> _deleteTask(Task task) async {
    await _controller.deleteTask(task);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final crnuser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${crnuser!.email}"),
        actions: [
          IconButton(
              onPressed: () {
                AuthHelper().logout(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddTaskScreen(controller: _controller)));
            if (result == true) {
              await _loadTasks();
            }
          }),
      body: _controller.tasks.isEmpty
          ? Center(
              child: Text("No task yet"),
            )
          : ListView.builder(
              itemCount: _controller.tasks.length,
              itemBuilder: (context, index) {
                final task = _controller.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.date),
                  trailing: Checkbox(
                    value: task.isDone, 
                    onChanged: (bool? value) async {
                      if (value != null) {
                        // Use the method you already defined in this class!
                        await _toggleTask(task, value); 
                      }
                    },
                  ),
                  onLongPress: () => _deleteTask(task),
                );
              }),
    );
  }
}
