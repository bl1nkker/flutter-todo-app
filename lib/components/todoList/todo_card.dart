import 'package:flutter/material.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:flutter_todo_app/views/todo_detail.dart';
import 'package:provider/provider.dart';

class ToDoCard extends StatelessWidget {
  final ToDo todo;
  const ToDoCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _todoDetailModalBottomSheet(context, todo);
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(todo.description),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    late ToDo updatedToDo = ToDo(
                        id: todo.id,
                        isCompleted: !todo.isCompleted,
                        description: todo.description,
                        createdTime: todo.createdTime,
                        deadlineTime: todo.deadlineTime);
                    Provider.of<ToDoModel>(context, listen: false)
                        .update(updatedToDo);
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: todo.isCompleted ? Colors.green : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ToDoModel>(context, listen: false)
                        .delete(todo.id as int);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  void _todoDetailModalBottomSheet(BuildContext context, ToDo todo) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return ToDoDetails(todoId: todo.id!, parentContext: context);
        });
  }
}
