// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/app_colors.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddToDo extends StatefulWidget {
  AddToDo({Key? key}) : super(key: key);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final descriptionController = TextEditingController();
  final deadlineTimeController = TextEditingController();
  final colorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: height * .3,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        decoration: BoxDecoration(
            color: transparentColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white.withOpacity(.3), width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  labelText: 'What you need to do?',
                  labelStyle: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white),
                  suffixIcon: IconButton(
                      onPressed: () => descriptionController.clear(),
                      icon: Icon(Icons.delete)),
                  fillColor: Color.fromRGBO(153, 153, 153, 0.4),
                  filled: true,
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: deadlineTimeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(15)),
                      ),
                      labelText: 'Set the deadline',
                      labelStyle: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                      suffixIcon: IconButton(
                          onPressed: () => descriptionController.clear(),
                          icon: Icon(Icons.delete)),
                      fillColor: Color.fromRGBO(153, 153, 153, 0.4),
                      filled: true,
                    ),
                    style: const TextStyle(color: Colors.white),
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
                    readOnly: true,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                      controller: colorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15)),
                        ),
                        labelText: 'Pick the color',
                        labelStyle: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                        suffixIcon: IconButton(
                            onPressed: () => descriptionController.clear(),
                            icon: Icon(Icons.delete)),
                        fillColor: Color.fromRGBO(153, 153, 153, 0.4),
                        filled: true,
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Submit TODO
                final ToDo newTodo = ToDo(
                    isCompleted: false,
                    description: descriptionController.text,
                    deadlineTime: DateTime.parse(deadlineTimeController.text),
                    createdTime: DateTime.now());
                Provider.of<ToDoModel>(context, listen: false).add(newTodo);
                Navigator.pushNamed(context, '/');
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                    gradient: addTodoButtonGradient,
                    borderRadius: BorderRadius.circular(10.0)),
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: Center(
                    child: Text('CREATE',
                        style: TextStyle(
                            color: addTodoTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
