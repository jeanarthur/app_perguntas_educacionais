import 'package:flutter/material.dart';

class QuizBook {

  late int id;
  String title;
  String imagePath;
  ColorSwatch color;
  
  QuizBook({required this.id, this.title = '[TITLE]', this.imagePath = 'assets/images/quiz_default.png', this.color = Colors.blue});

}