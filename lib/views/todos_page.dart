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
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(todosModel.todos[index].description),
                            IconButton(
                              onPressed: () {
                                late ToDo updatedToDo = ToDo(
                                    id: todosModel.todos[index].id,
                                    isCompleted:
                                        !todosModel.todos[index].isCompleted,
                                    description:
                                        todosModel.todos[index].description,
                                    createdTime:
                                        todosModel.todos[index].createdTime,
                                    deadlineTime:
                                        todosModel.todos[index].deadlineTime);
                                todosModel.update(updatedToDo);
                              },
                              icon: Icon(
                                Icons.check_circle,
                                color: todosModel.todos[index].isCompleted
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ));
                    },
                  );
        ;
      },
    );
  }
}
