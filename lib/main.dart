import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:flutter_todo_app/views/add_todo.dart';
import 'package:flutter_todo_app/views/todos_page.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MaterialApp(initialRoute: '/', routes: {
//     "/": (context) => ToDosPage(),
//     "/home": (context) => ToDoDetails(),
//     '/add': (context) => AddToDo()
//   }, ));
// }
void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final screens = [ToDosPage(), AddToDo()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.black;
    Color secondaryColor = Colors.deepPurpleAccent.shade700;
    Color iconsColor = Colors.amber;
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => ToDoModel(),
        child: Scaffold(
          body: Container(
            color: primaryColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: IndexedStack(
              children: screens,
              index: currentIndex,
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            color: secondaryColor,
            backgroundColor: primaryColor,
            buttonBackgroundColor: secondaryColor,
            items: <Widget>[
              Icon(Icons.verified, size: 25, color: iconsColor),
              Icon(Icons.add, size: 45, color: Colors.red.shade300),
              Icon(Icons.list, size: 25, color: iconsColor),
            ],
            onTap: (index) {
              // Navigator here
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
