import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/quiz_book/quiz_book_repository.dart';
import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';
import 'package:flutter/material.dart';

class CategoriesViewModel extends ChangeNotifier {
  CategoriesViewModel({
    required this.quizBookRepository
  }) {
    load();
  }

  final QuizBookRepository quizBookRepository;

  List<QuizBook> _quizBookList = [];

  List<QuizBook> get quizBookList => _quizBookList;

  void load() async {
    log("Load quizBookList");
    final result = await quizBookRepository.getQuizBookList();
    switch (result) {
      case Ok():
      log("quizBookList loaded: ${result.value}");
      _quizBookList = result.value;
      for (QuizBook category in _quizBookList) {
        log("Category: id = ${category.id}, title = ${category.title}, imagePath = ${category.imagePath}");
      }
      notifyListeners();

      case Error():
        return;
    }
  }

  void selectBook(int id) async {
    quizBookRepository.setSelectedQuizBook(id);
  }

}