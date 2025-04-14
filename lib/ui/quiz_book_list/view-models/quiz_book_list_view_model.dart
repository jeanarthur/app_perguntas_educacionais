import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/question/question_repository.dart';
import 'package:app_perguntas_educacionais/data/repositories/quiz_book/quiz_book_repository.dart';
import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';
import 'package:flutter/material.dart';

class CategoriesViewModel extends ChangeNotifier {
  CategoriesViewModel({
    required this.quizBookRepository,
    required this.questionRepository
  }) {
    load();
  }

  final QuizBookRepository quizBookRepository;
  final QuestionRepository questionRepository;

  List<QuizBook> _quizBookList = [];

  List<QuizBook> get quizBookList => _quizBookList;

  void load() async {
    log("[quiz_book_list_view_model] Load quizBookList");
    refreshList();
  }

  void selectBook(int id) async {
    log("[CategoriesViewModel] [selectBook] selecting quiz book with id: $id");
    final result = await quizBookRepository.setSelectedQuizBook(id);
    switch (result) {
      case Ok():
        log("[CategoriesViewModel] [selectBook] quiz book selected successfully");
        notifyListeners();
      case Error():
        log("[CategoriesViewModel] [selectBook] error selecting quiz book: ${result.error}");
        // TODO: Tratar erro
        break;
    }
  }

  void createBook(QuizBook quizBook) async {
    log("[CategoriesViewModel] [createBook] creating quiz book...");
    await quizBookRepository.createQuizBook(quizBook);
    refreshList();
  }

  void updateBook(QuizBook quizBook) async {
    log("[CategoriesViewModel] [createBook] creating quiz book...");
    await quizBookRepository.updateQuizBook(quizBook);
    refreshList();
  }

  void deleteBook(int id) async {
    log("[CategoriesViewModel] [deleteBook] deleting quiz book...");
    await quizBookRepository.deleteQuizBook(id);
    refreshList();
  }

  void refreshList() async {
    final result = await quizBookRepository.getQuizBookList();
    switch (result) {
      case Ok():
      log("[quiz_book_list_view_model] quizBookList loaded: ${result.value}");
      _quizBookList = result.value;
      for (QuizBook category in _quizBookList) {
        log("[quiz_book_list_view_model] Category: id = ${category.id}, title = ${category.title}, icon = ${category.icon}");
      }
      notifyListeners();

      case Error():
        return;
    }
  }
}