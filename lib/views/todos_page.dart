import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/db/todo_database.dart';

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
    refreshTodos();
  }

  Future refreshTodos() async {
    setState(() {
      isLoading = true;
    });
    this.todos = await ToDosDatabase.instance.readAll();
    setState(() {
      isLoading = false;
    });
    print(todos);
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.black;
    Color secondaryColor = Colors.deepPurpleAccent.shade700;
    Color iconsColor = Colors.amber;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: lightPrimaryColor,
        //   title: const Text('TODO App'),
        // ),
        body: Container(
          color: primaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: isLoading
              ? const CircularProgressIndicator()
              : todos.isEmpty
                  ? const Text('Nothing is there...',
                      style: TextStyle(color: Colors.white))
                  : buildTodos(),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator to Edit todo page
              final ToDo newTodo = ToDo(
                  isCompleted: false,
                  description: 'This is new TODO',
                  createdTime: DateTime(2020, 10, 10),
                  deadlineTime: DateTime(2020, 10, 11));
              ToDosDatabase.instance.create(newTodo);
            },
            child: const Icon(
              Icons.add,
              color: Colors.amber,
            )),
        // NavBar
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          color: secondaryColor,
          backgroundColor: primaryColor,
          buttonBackgroundColor: secondaryColor,
          items: <Widget>[
            Icon(Icons.verified, size: 25, color: iconsColor),
            Icon(Icons.list, size: 25, color: iconsColor),
            Icon(Icons.favorite_outline_outlined, size: 25, color: iconsColor),
            Icon(Icons.logout, size: 25, color: iconsColor),
          ],
          onTap: (index) {
            // Navigator here
            // debugPrint("Current index is $index");
          },
        ),
      ),
    );
  }

  Widget buildTodos() => ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                // Navigator to todo details here
              },
              title: Text(todos[index].description),
            ),
          );
        },
      );
}
