import 'package:flutter/material.dart';

class QuizBook {

  late int id;
  String title;
  IconData icon;
  Color color;
  
  QuizBook({required this.id, this.title = '[TITLE]', this.icon = Icons.not_interested_outlined, this.color = Colors.blue});

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'icon': icon.codePoint, 'color': color.toARGB32()};
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, icon: $icon, color:$color}';
  }

}