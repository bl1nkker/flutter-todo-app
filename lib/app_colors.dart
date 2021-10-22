import 'package:flutter/material.dart';

const Color darkThemeBg = Color.fromRGBO(10, 6, 61, 1);
const RadialGradient firstBallGradient = RadialGradient(colors: [
  Color.fromRGBO(43, 141, 252, .45),
  Color.fromRGBO(10, 252, 241, .45),
]);
const RadialGradient secondBallGradient = RadialGradient(colors: [
  Color.fromRGBO(250, 0, 225, .31),
  Color.fromRGBO(68, 25, 255, .31),
]);

//Todo List
const LinearGradient cardGradientBg = LinearGradient(colors: [
  Color.fromRGBO(153, 153, 153, 0.4),
  Color.fromRGBO(153, 153, 153, 0.4)
], begin: Alignment.topRight, end: Alignment.bottomLeft);
const Color cardDescriptionTextColor = Colors.white;
const Color cardDeadlineTextColor = Colors.grey;
const Color cardCompleteIcon = Color.fromRGBO(43, 255, 103, .71);
const Color cardDeleteIcon = Color.fromRGBO(255, 38, 71, .71);

// Bottom NavBar
const Color transparentColor = Color.fromRGBO(153, 153, 153, 0.5);
const Color middleButtonIconColor = Colors.white;
const Color firstButtonIconColor = Color.fromRGBO(0, 255, 225, 1);
const Color thirdButtonIconColor = Color.fromRGBO(0, 255, 225, 1);
const LinearGradient middleButtonGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 38, 71, .71),
      Color.fromRGBO(250, 0, 225, .91),
      Color.fromRGBO(68, 25, 255, .71),
      Color.fromRGBO(43, 141, 252, .71),
      Color.fromRGBO(78, 252, 241, .71),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [.1, .3, .4, .7, 1]);
