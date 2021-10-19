import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => descriptionController.clear(),
                      icon: Icon(Icons.delete)),
                  fillColor: Colors.amber,
                  filled: true,
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.done),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: deadlineTimeController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () => deadlineTimeController.clear(),
                          icon: Icon(Icons.delete)),
                      fillColor: Colors.amber,
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
                        suffixIcon: IconButton(
                            onPressed: () => colorController.clear(),
                            icon: Icon(Icons.delete)),
                        fillColor: Colors.amber,
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
                print('Please, add me!' + colorController.text);
                final ToDo newTodo = ToDo(
                    isCompleted: false,
                    description: descriptionController.text,
                    deadlineTime: DateTime.parse(deadlineTimeController.text),
                    createdTime: DateTime.now());
                Provider.of<ToDoModel>(context, listen: false).add(newTodo);
                Navigator.pushNamed(context, '/');
              },
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: 20.0,
                child: Text('Create TODO'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
