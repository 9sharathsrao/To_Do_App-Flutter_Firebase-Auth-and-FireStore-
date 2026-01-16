import 'package:flutter/material.dart';
import 'package:todo/controller/task_controller.dart';

class AddTaskScreen extends StatefulWidget {

  final TaskController controller;

    AddTaskScreen({super.key, required this.controller});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _textEditingController = TextEditingController();

  List<String> option = ["Today", "Tommorrow", "Next Week", "Next Month"];

  // FIX 1: Initialize this with "Today" so it's never null
  String selectedOption = "Today"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: 'Enter Task title to be added'),
            ),
            DropdownButtonFormField<String>(
              value: selectedOption, // Use the variable here
              items: option.map((String value) {
                return DropdownMenuItem(child: Text(value), value: value);
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_textEditingController.text.trim().isNotEmpty) {
                  // The await happens here
                  await widget.controller.addTask(
                    _textEditingController.text, 
                    selectedOption, // No '!' needed now
                  );
                  
                  // FIX 2: Check if the widget is still in the tree before popping
                  if (mounted) {
                    Navigator.pop(context, true);
                  }
                }
              }, 
              child: const Text("Save Task"),
            )
          ],
        ),
      ),
    );
  }
}