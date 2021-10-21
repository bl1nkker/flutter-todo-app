// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ToDoDetails extends StatefulWidget {
  final int todoId;
  final BuildContext parentContext;
  const ToDoDetails(
      {Key? key, required this.todoId, required this.parentContext})
      : super(key: key);

  @override
  State<ToDoDetails> createState() => _ToDoDetailsState();
}

class _ToDoDetailsState extends State<ToDoDetails> {
  bool editMode = false;
  final descriptionController = TextEditingController();
  final deadlineTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoModel>(builder: (context, todosModel, child) {
      // Kostyl yeaaaaaaaah
      final currentTodo =
          todosModel.todos.firstWhere((element) => element.id == widget.todoId);
      if (descriptionController.text.isEmpty &&
          deadlineTimeController.text.isEmpty) {
        descriptionController.text = currentTodo.description;
        deadlineTimeController.text = currentTodo.deadlineTime.toString();
      }
      return Container(
          height: MediaQuery.of(context).size.height * 2,
          child: Center(child: buildForm(currentTodo)));
    });
  }

  Widget buildForm(ToDo currentTodo) {
    final Icon leftUpIcon = editMode
        ? Icon(Icons.verified_outlined, color: Colors.green, size: 25.0)
        : Icon(Icons.edit, color: Colors.amber, size: 25.0);
    final Widget deadlineField = editMode
        ? TextField(
            controller: deadlineTimeController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.blue.shade50),
            style: const TextStyle(fontSize: 24.0, color: Colors.black),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                setState(() {
                  deadlineTimeController.text = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
            readOnly: true)
        : Text(
            'Deadline at: ' +
                DateFormat('EEEE, d HH:mm')
                    .format(currentTodo.deadlineTime)
                    .toString(),
            style: TextStyle(fontSize: 16.0),
          );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    editMode = !editMode;
                  });
                  if (!editMode &&
                      (currentTodo.description != descriptionController.text ||
                          currentTodo.deadlineTime.toString() !=
                              deadlineTimeController.text)) {
                    final ToDo updatedTodo = ToDo(
                        id: currentTodo.id,
                        isCompleted: currentTodo.isCompleted,
                        description: descriptionController.text,
                        createdTime: currentTodo.createdTime,
                        deadlineTime:
                            DateTime.parse(deadlineTimeController.text));
                    Provider.of<ToDoModel>(context, listen: false)
                        .update(updatedTodo);
                  }
                },
                icon: leftUpIcon),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel, color: Colors.red, size: 25.0))
          ],
        ),
        const SizedBox(height: 35.0),
        editMode
            ? TextField(
                controller: descriptionController,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.blue.shade50),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done)
            : Text(
                currentTodo.description,
                style: const TextStyle(fontSize: 24.0),
              ),
        Text(
          'Created at: ' +
              DateFormat('EEEE, d MMM')
                  .format(currentTodo.createdTime)
                  .toString(),
          style: TextStyle(fontSize: 12.0),
        ),
        // Add color behaviour
        SizedBox(height: 50.0),
        deadlineField,
        SizedBox(height: 50.0),
        SizedBox(
          width: double.infinity,
          child: IconButton(
            onPressed: () {
              late ToDo updatedToDo = ToDo(
                  id: currentTodo.id,
                  isCompleted: !currentTodo.isCompleted,
                  description: currentTodo.description,
                  createdTime: currentTodo.createdTime,
                  deadlineTime: currentTodo.deadlineTime);
              Provider.of<ToDoModel>(context, listen: false)
                  .update(updatedToDo);
            },
            icon: Icon(
              Icons.check_circle,
              color: currentTodo.isCompleted ? Colors.green : Colors.grey,
              size: 72.0,
            ),
          ),
        ),
      ],
    );
  }
}
