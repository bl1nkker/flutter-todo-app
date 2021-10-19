import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/todoList/todo_card.dart';
import 'package:flutter_todo_app/db/models/todo.dart';

class ToDoList extends StatelessWidget {
  final List<ToDo> todos;
  const ToDoList({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ToDoCard(todo: todos[index]);
      },
    );
    ;
  }
}
