import 'dart:developer';

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

  static QuizBook copyOf(QuizBook quizBook) {
    return QuizBook(id: quizBook.id, title: quizBook.title, icon: quizBook.icon, color: quizBook.color);
  }

  bool areEqualTo(QuizBook quizBook) {
    log("[QuizBook] [areEqualTo] id: [$id | ${quizBook.id}] <${id == quizBook.id}>");
    log("[QuizBook] [areEqualTo] title: [$title | ${quizBook.title}] <${title == quizBook.title}>");
    log("[QuizBook] [areEqualTo] icon: [${icon.codePoint} | ${quizBook.icon.codePoint}] <${icon.codePoint == quizBook.icon.codePoint}>");
    log("[QuizBook] [areEqualTo] color: [${color.toARGB32()} | ${quizBook.color.toARGB32()}] <${color.toARGB32() == quizBook.color.toARGB32()}>");
    return id == quizBook.id &&
      title == quizBook.title &&
      icon.codePoint == quizBook.icon.codePoint &&
      color.toARGB32() == quizBook.color.toARGB32();
  }

}