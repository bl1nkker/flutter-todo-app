// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ToDoDetails extends StatelessWidget {
  final ToDo todo;
  final BuildContext parentContext;
  const ToDoDetails({Key? key, required this.todo, required this.parentContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .5,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.amber, size: 25.0)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.cancel, color: Colors.red, size: 25.0))
                ],
              ),
              const SizedBox(height: 35.0),
              Text(
                todo.description,
                style: const TextStyle(fontSize: 24.0),
              ),
              Text(
                'Created at: ' +
                    DateFormat('EEEE, d MMM')
                        .format(todo.createdTime)
                        .toString(),
                style: TextStyle(fontSize: 12.0),
              ),
              // Add color behaviour
              SizedBox(height: 50.0),
              Text(
                'Deadline at: ' +
                    DateFormat('EEEE, d HH:mm')
                        .format(todo.deadlineTime)
                        .toString(),
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 50.0),
              SizedBox(
                width: double.infinity,
                child: IconButton(
                  onPressed: () {
                    late ToDo updatedToDo = ToDo(
                        id: todo.id,
                        isCompleted: !todo.isCompleted,
                        description: todo.description,
                        createdTime: todo.createdTime,
                        deadlineTime: todo.deadlineTime);
                    Provider.of<ToDoModel>(parentContext, listen: false)
                        .update(updatedToDo);
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: todo.isCompleted ? Colors.green : Colors.grey,
                    size: 72.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
