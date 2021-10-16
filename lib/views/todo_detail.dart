import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_todo_app/db/models/todo.dart';

class ToDoDetails extends StatelessWidget {
  final ToDo todo;
  const ToDoDetails({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: todo,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                  onPressed: () {
                    // Provider
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.redAccent,
                  ),
                ),
                Text(todo.description),
                IconButton(
                  onPressed: () {
                    // Provider
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                )
              ]),
              SizedBox(height: 10.0),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                      'Created at: ${todo.createdTime.hour.toString()} : ${todo.createdTime.minute.toString()}'),
                  Text(
                      'Deadline at: ${todo.deadlineTime.hour.toString()} : ${todo.deadlineTime.minute.toString()}'),
                ],
              )
            ]),
          ),
        ));
  }
}
