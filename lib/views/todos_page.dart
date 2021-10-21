import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/todoList/todo_list.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class ToDosPage extends StatefulWidget {
  ToDosPage({Key? key}) : super(key: key);

  @override
  _ToDosPageState createState() => _ToDosPageState();
}

class _ToDosPageState extends State<ToDosPage> {
  late List<ToDo> todos;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Provider.of<ToDoModel>(context, listen: false).retrieveToDos();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Provider.of<ToDoModel>(context, listen: true).todos.isEmpty
            ? const Text('Nothing is there...',
                style: TextStyle(color: Colors.white))
            : ToDoList();
  }
}
