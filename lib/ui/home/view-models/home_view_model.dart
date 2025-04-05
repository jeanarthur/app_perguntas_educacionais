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
  bool _isLoading = true;

  final QuizBookRepository quizBookRepository;

  QuizBook get selectedQuizBook => _selectedQuizBook;
  bool get isLoading => _isLoading;

  void load() async {
    var result = await quizBookRepository.getSelectedQuizBook();
    _isLoading = false;
    switch (result) {
      case Ok():
        _selectedQuizBook = result.value;
        log('[home_view_model] Selected quiz book: ${selectedQuizBook.id} | ${selectedQuizBook.title} | ${selectedQuizBook.icon}');
        notifyListeners();
      case Error():
        log('[home_view_model] Error on get selected quiz book: ${result.error}');
        return;
    }
  }

}