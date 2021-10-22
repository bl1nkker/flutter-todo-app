import 'package:flutter/material.dart';
import 'package:flutter_todo_app/app_colors.dart';
import 'package:flutter_todo_app/components/todoList/todo_card.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:intl/intl.dart';

class ToDoRow {
  final DateTime date;
  final List<ToDo> children;

  const ToDoRow({required this.date, required this.children});
}

class ToDoByDates extends StatefulWidget {
  final List<ToDo> todos;
  const ToDoByDates({Key? key, required this.todos}) : super(key: key);

  @override
  State<ToDoByDates> createState() => _ToDoByDatesState();
}

class _ToDoByDatesState extends State<ToDoByDates> {
  List<ToDoRow> sortedToDos = [];
  @override
  void initState() {
    super.initState();
    sortedToDos.add(ToDoRow(
        date: widget.todos[0].deadlineTime, children: [widget.todos[0]]));
  }

  @override
  Widget build(BuildContext context) {
    if (sortedToDos.isNotEmpty) {
      sortedToDos = [];
      for (var i = 0; i < widget.todos.length; i++) {
        // If todo exist in new list, finds it
        if (sortedToDos.indexWhere((element) =>
                    element.date == widget.todos[i].deadlineTime) !=
                -1 &&
            sortedToDos.isNotEmpty) {
          final index = sortedToDos.indexWhere(
              (element) => element.date == widget.todos[i].deadlineTime);
          sortedToDos[index].children.add(widget.todos[i]);
        } else {
          sortedToDos.add(ToDoRow(
              date: widget.todos[i].deadlineTime, children: [widget.todos[i]]));
        }
      }
    }
    return ListView.builder(
      itemCount: sortedToDos.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
              child: Text(
                DateFormat('EEEE, d MMM')
                    .format(sortedToDos[index].date)
                    .toString(),
                style: TextStyle(
                    color: cardDeadlineTextColor,
                    fontSize: 36,
                    fontWeight: FontWeight.w200),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    ...sortedToDos[index]
                        .children
                        .map((todo) => ToDoCard(todo: todo))
                        .toList()
                  ],
                )),
          ],
        );
      },
    );
  }
}
