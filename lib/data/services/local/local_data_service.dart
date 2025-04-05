import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:flutter/material.dart';

class LocalDataService {
  List<QuizBook> getQuizBookList() {
    return [
      QuizBook(id: 0, title: 'Matemática', icon: Icons.calculate_outlined, color: Colors.blue),
      QuizBook(id: 1, title: 'Língua Portuguesa', icon: Icons.abc_outlined, color: Colors.red),
      QuizBook(id: 2, title: 'Inglês', icon: Icons.flag_outlined, color: Colors.orange),
      QuizBook(id: 3, title: 'Geografia', icon: Icons.travel_explore_outlined, color: Colors.brown),
    ];
  }
}