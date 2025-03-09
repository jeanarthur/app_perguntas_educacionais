import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/quiz_book/quiz_book_repository.dart';
import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required this.quizBookRepository
  }) {
    load();
  }

  QuizBook _selectedQuizBook = QuizBook(id: 0);

  final QuizBookRepository quizBookRepository;

  QuizBook get selectedQuizBook => _selectedQuizBook;

  void load() async {
    var result = await quizBookRepository.getSelectedQuizBook();
    switch (result) {
      case Ok():
        _selectedQuizBook = result.value;
        log('Selected quiz book: ${selectedQuizBook.id} | ${selectedQuizBook.title}');
        notifyListeners();
      case Error():
        log('Error on get selected quiz book: ${result.error}');
        return;
    }
  }

}