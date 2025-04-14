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

  final QuizBookRepository quizBookRepository;

  List<QuizBook> _quizBookList = [];
  List<QuizBook> get quizBookList => _quizBookList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  int? _selectedQuizBookId;
  int? get selectedQuizBookId => _selectedQuizBookId;

  void selectQuizBook(int id) {
    _selectedQuizBookId = id;
    notifyListeners();
  }

  void load() async {
    _isLoading = true;
    notifyListeners();

    final result = await quizBookRepository.getQuizBookList();
    switch (result) {
      case Ok():
        _quizBookList = result.value;
        final selectedResult = await quizBookRepository.getSelectedQuizBook();
        switch (selectedResult) {
          case Ok():
            _selectedQuizBookId = selectedResult.value.id;
          case Error():
            // TODO: Tratar erro
            break;
        }
      case Error():
        // TODO: Tratar erro
        break;
    }

    _isLoading = false;
    notifyListeners();
  }
}