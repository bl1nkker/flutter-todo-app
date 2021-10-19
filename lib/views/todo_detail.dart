import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_todo_app/db/models/todo.dart';

class ToDoDetails extends StatelessWidget {
  final ToDo todo;
  const ToDoDetails({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Hello World'));
  }
}
