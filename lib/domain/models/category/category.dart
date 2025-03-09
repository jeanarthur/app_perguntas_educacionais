import 'package:flutter/material.dart';

class Category {

  late int id;
  String title;
  String imagePath;
  MaterialColor color;
  
  Category({required this.id, this.title = '[TITLE]', this.imagePath = 'assets/images/quiz_default.png', this.color = Colors.blue});

}