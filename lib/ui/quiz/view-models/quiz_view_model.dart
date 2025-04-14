import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
import 'package:app_perguntas_educacionais/data/repositories/question/question_repository.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class QuizViewModel extends ChangeNotifier {
  QuizViewModel({
    required this.questionRepository,
    required this.quizBookId
  }) {
    loadQuestions();
  }

  final QuestionRepository questionRepository;
  final int quizBookId;

  List<Question> _questionList = [];
  List<Question> get questionList => _questionList;

  Future<void> loadQuestions() async {
    developer.log("[QuizViewModel] [loadQuestions] Carregando questões para quizBookId: $quizBookId");
    final result = await questionRepository.getQuestionList(quizBookId);
    switch (result) {
      case Ok():
        _questionList = result.value;
        developer.log("[QuizViewModel] [loadQuestions] ${_questionList.length} questões carregadas");
        notifyListeners();
      case Error():
        developer.log("[QuizViewModel] [loadQuestions] Erro ao carregar questões: ${result.error}");
        _questionList = [];
        notifyListeners();
        break;
    }
  }
} 