import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/question/question_repository.dart';
import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';
import 'package:flutter/material.dart';

class QuestionListViewModel extends ChangeNotifier {
  QuestionListViewModel({
    required this.questionRepository,
    required this.quizBookId
  }) {
    load();
  }

  final QuestionRepository questionRepository;
  final int quizBookId;

  List<Question> _questionList = [];
  List<Question> get questionList => _questionList;

  Question? _selectedQuestion;
  Question? get selectedQuestion => _selectedQuestion;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void load() async {
    log("[QuestionListViewModel] Load questionList");
    refreshList();
  }

  void refreshList() async {
    final result = await questionRepository.getQuestionList(quizBookId);
    switch (result) {
      case Ok():
        log("[QuestionListViewModel] questionList loaded: ${result.value}");
        _questionList = result.value;
        if (_questionList.isNotEmpty && _selectedQuestion == null) {
          _selectedQuestion = _questionList.first;
          _currentIndex = 0;
        }
        notifyListeners();

      case Error():
        return;
    }
  }

  void createQuestion(Question question) async {
    log("[QuestionListViewModel] [createQuestion] creating question...");
    await questionRepository.createQuestion(question);
    refreshList();
  }

  void updateQuestion(Question question) async {
    log("[QuestionListViewModel] [updateQuestion] updating question...");
    await questionRepository.updateQuestion(question);
    refreshList();
  }

  void deleteQuestion(int id) async {
    log("[QuestionListViewModel] [deleteQuestion] deleting question...");
    await questionRepository.deleteQuestion(id);
    refreshList();
  }

  void nextQuestion() async {
    if (_currentIndex < _questionList.length - 1) {
      _currentIndex++;
      _selectedQuestion = _questionList[_currentIndex];
      notifyListeners();
    } else {
      _currentIndex = _questionList.length;
      _selectedQuestion = null;
      notifyListeners();
    }
  }

  void previousQuestion() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      _selectedQuestion = _questionList[_currentIndex];
      notifyListeners();
    }
  }

  void selectQuestion(int index) {
    if (index >= 0 && index < _questionList.length) {
      _currentIndex = index;
      _selectedQuestion = _questionList[index];
    } else {
      _currentIndex = _questionList.length;
      _selectedQuestion = null;
    }
    notifyListeners();
  }
} 