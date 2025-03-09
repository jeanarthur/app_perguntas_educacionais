import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:flutter/material.dart';

class LocalDataService {
  List<QuizBook> getQuizBookList() {
    return [
      QuizBook(id: 0, title: 'Matemática', color: Colors.blue),
      QuizBook(id: 1, title: 'Língua Portuguesa', imagePath: 'assets/images/portuguese_quiz_cover.png', color: Colors.red),
      QuizBook(id: 2, title: 'Inglês', color: Colors.orange),
      QuizBook(id: 3, title: 'Geografia', color: Colors.brown),
    ];
  }
}