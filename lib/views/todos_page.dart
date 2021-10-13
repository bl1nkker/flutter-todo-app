import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/db/todo_database.dart';
import 'package:flutter_todo_app/provider/todo_list.dart';
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
  }

  // Future refreshTodos() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   this.todos = await ToDosDatabase.instance.readAll();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<ToDoModel>(context, listen: false).retrieveToDos();
    return Consumer<ToDoModel>(
      builder: (context, todosModel, child) {
        return isLoading
            ? const CircularProgressIndicator()
            : todosModel.todos.isEmpty
                ? const Text('Nothing is there...',
                    style: TextStyle(color: Colors.white))
                : ListView.builder(
                    itemCount: todosModel.todos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            // Navigator to todo details here
                          },
                          title: Text(todosModel.todos[index].description),
                        ),
                      );
                    },
                  );
        ;
      },
    );
  }
}
