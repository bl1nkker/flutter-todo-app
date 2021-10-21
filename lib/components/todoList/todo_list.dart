import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/todoList/todo_by_dates.dart';
import 'package:flutter_todo_app/components/todoList/todo_card.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoModel>(builder: (context, todosModel, child) {
      return ToDoByDates(todos: todosModel.todos);
    });
  }
}
