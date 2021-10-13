import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/provider/todo_list.dart';
import 'package:provider/provider.dart';

class AddToDo extends StatefulWidget {
  AddToDo({Key? key}) : super(key: key);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final ToDo newTodo = ToDo(
              isCompleted: false,
              description: 'This is new TODO',
              createdTime: DateTime(2020, 10, 10),
              deadlineTime: DateTime(2020, 10, 11));
          Provider.of<ToDoModel>(context, listen: false).add(newTodo);
        },
        child: Container(
          color: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
