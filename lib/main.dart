import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TODO App', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.black;
    Color secondaryColor = Colors.deepPurpleAccent.shade700;
    Color iconsColor = Colors.amber;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: lightPrimaryColor,
      //   title: const Text('TODO App'),
      // ),
      body: Center(
        child: Container(
            color: primaryColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Text('This is TODO app')),
      ),
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
    );
  }
}
