import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/question/question_repository.dart';
import 'package:app_perguntas_educacionais/data/services/local/local_data_service.dart';
import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

class QuestionRepositoryLocal implements QuestionRepository {
  QuestionRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;

  final LocalDataService _localDataService;

  Question? _selectedQuestion;
  Question? get selectedQuestion => _selectedQuestion;

  int? _selectedQuizBookId;
  int? get selectedQuizBookId => _selectedQuizBookId;

  List<Question>? _questionList;

  @override
  Future<Result<Question>> getQuestion(int id) async {
    final quizBookList = await _localDataService.getQuestionList(selectedQuizBookId!);
    final quizBook = quizBookList.where((quizBook) => quizBook.id == id).firstOrNull;

    if (quizBook != null) {
      return Future.value(Result.ok(quizBook));
    } else {
      return Future.value(Result.error('Invalid quizBook id' as Exception));
    }
  }

  @override
  Future<Result<List<Question>>> getQuestionList(int quizBookId) async {
    return Future.value(Result.ok(await _localDataService.getQuestionList(quizBookId)));
  }

  @override
  Future<Result<Question>> getSelectedQuestion() async {
    log("[QuestionRepositoryLocal] [getSelectedQuestion] initialSelectedQuestion: ${_selectedQuestion.toString()}");
    if (_selectedQuestion == null) {
      var resultFallback = await getQuestionList(selectedQuizBookId!);
        switch (resultFallback) {
          case Ok():
            _selectedQuestion = resultFallback.value.first;
          case Error():
            return Result.error(resultFallback.error);
        }
    }
    return Future.value(Result.ok(_selectedQuestion!));
  }

  @override
  Future<Result<void>> setSelectedQuestion(int id) async {
    var result = await getQuestion(id);
    switch (result) {
      case Ok():
        _selectedQuestion = result.value;
        return const Result.ok(null);
      case Error():
        return Result.error(result.error);
    }
  }
  
  @override
  Future<Result<void>> createQuestion(Question quizBook) async {
    var result = await _localDataService.createQuestion(quizBook);
    if (result != null) {
      return Future.value(Result.ok(null));
    } else {
      return Future.value(Result.error('Error on create quiz book' as Exception));
    }
  }
  
  @override
  Future<Result<void>> deleteQuestion(int id) async {
    var result = await _localDataService.deleteQuestion(id);
    if (result != null) {
      if (_selectedQuestion?.id == id) {
        _selectedQuestion = null;
      }
      return Future.value(Result.ok(null));
    } else {
      return Future.value(Result.error(Exception('Error on delete quiz book')));
    }
  }
  
  @override
  Future<Result<void>> updateQuestion(Question quizBook) async {
    var result = await _localDataService.updateQuestion(quizBook);
    if (result != null) {
      if (_selectedQuestion?.id == quizBook.id) {
        _selectedQuestion = quizBook;
      }
      return Future.value(Result.ok(null));
    } else {
      return Future.value(Result.error(Exception('Error on delete quiz book')));
    }
  }
  
  @override
  Future<Result<Question>> getNextQuestion() {
    // TODO: implement getNextQuestion
    throw UnimplementedError();
  }
  
  @override
  Future<Result<Question>> getPreviousQuestion() {
    // TODO: implement getPreviousQuestion
    throw UnimplementedError();
  }
}