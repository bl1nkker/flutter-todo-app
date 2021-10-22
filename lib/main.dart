// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_todo_app/app_colors.dart';
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
  runApp(ChangeNotifierProvider(
      create: (context) => ToDoModel(), child: MaterialApp(home: HomePage())));
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: darkThemeBg,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Positioned(
                top: MediaQuery.of(context).size.height * -.1,
                left: -25,
                child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, gradient: firstBallGradient))),
            Positioned(
                top: MediaQuery.of(context).size.height * .6,
                right: 0,
                child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, gradient: secondBallGradient))),
            IndexedStack(
              children: screens,
              index: currentIndex,
            ),
          ]),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          color: transparentColor,
          backgroundColor: darkThemeBg,
          items: <Widget>[
            Container(
              child: Icon(Icons.list_alt_outlined,
                  size: 30, color: firstButtonIconColor),
            ),
            Container(
                decoration: BoxDecoration(
                    gradient: middleButtonGradient,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.add, size: 45, color: middleButtonIconColor)),
            Container(
                child: Icon(Icons.info_outline,
                    size: 30, color: thirdButtonIconColor)),
          ],
          onTap: (index) {
            // Navigator here
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
