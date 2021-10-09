import 'package:flutter/material.dart';
import 'package:flutter_todo_app/views/edit_todo.dart';
import 'package:flutter_todo_app/views/todo_detail.dart';
import 'package:flutter_todo_app/views/todos_page.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    "/": (context) => ToDosPage(),
    "/home": (context) => ToDoDetails(),
  }));
}
