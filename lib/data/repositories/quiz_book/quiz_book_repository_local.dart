import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/quiz_book/quiz_book_repository.dart';
import 'package:app_perguntas_educacionais/data/services/local/local_data_service.dart';
import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

class QuizBookRepositoryLocal implements QuizBookRepository {
  QuizBookRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;

  final LocalDataService _localDataService;

  QuizBook? _selectedQuizBook;
  QuizBook? get selectedQuizBook => _selectedQuizBook;

  @override
  Future<Result<QuizBook>> getQuizBook(int id) async {
    final quizBookList = await _localDataService.getQuizBookList();
    final quizBook = quizBookList.where((quizBook) => quizBook.id == id).firstOrNull;

    if (quizBook != null) {
      return Future.value(Result.ok(quizBook));
    } else {
      return Future.value(Result.error('Invalid quizBook id' as Exception));
    }
  }

  @override
  Future<Result<List<QuizBook>>> getQuizBookList() async {
    return Future.value(Result.ok(await _localDataService.getQuizBookList()));
  }

  @override
  Future<Result<QuizBook>> getSelectedQuizBook() async {
    log("[QuizBookRepositoryLocal] [getSelectedQuizBook] initialSelectedQuizBook: ${_selectedQuizBook.toString()}");
    if (_selectedQuizBook == null) {
      var resultFallback = await getQuizBookList();
        switch (resultFallback) {
          case Ok():
            _selectedQuizBook = resultFallback.value.first;
          case Error():
            return Result.error(resultFallback.error);
        }
    }
    return Future.value(Result.ok(_selectedQuizBook!));
  }

  @override
  Future<Result<void>> setSelectedQuizBook(int id) async {
    var result = await getQuizBook(id);
    switch (result) {
      case Ok():
        _selectedQuizBook = result.value;
        return const Result.ok(null);
      case Error():
        return Result.error(result.error);
    }
  }
  
  @override
  Future<Result<void>> createQuizBook(QuizBook quizBook) async {
    var result = await _localDataService.createQuizBook(quizBook);
    if (result != null) {
      return Future.value(Result.ok(null));
    } else {
      return Future.value(Result.error('Error on create quiz book' as Exception));
    }
  }
  
  @override
  Future<Result<void>> deleteQuizBook(int id) async {
    var result = await _localDataService.deleteQuizBook(id);
    if (result != null) {
      if (_selectedQuizBook?.id == id) {
        _selectedQuizBook = null;
      }
      return Future.value(Result.ok(null));
    } else {
      return Future.value(Result.error(Exception('Error on delete quiz book')));
    }
  }
  
  @override
  Future<Result<void>> updateQuizBook(QuizBook quizBook) async {
    var result = await _localDataService.updateQuizBook(quizBook);
    if (result != null) {
      if (_selectedQuizBook?.id == quizBook.id) {
        _selectedQuizBook = quizBook;
      }
      return Future.value(Result.ok(null));
    } else {
      return Future.value(Result.error(Exception('Error on delete quiz book')));
    }
  }
}