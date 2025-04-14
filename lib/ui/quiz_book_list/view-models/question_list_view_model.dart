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
    loadQuestions();
  }

  final QuestionRepository questionRepository;
  final int quizBookId;

  List<Question> _questionList = [];
  List<Question> get questionList => _questionList;

  Question? _selectedQuestion;
  Question? get selectedQuestion => _selectedQuestion;

  int _currentIndex = -1;
  int get currentIndex => _currentIndex;

  Future<void> loadQuestions() async {
    log("[QuestionListViewModel] [loadQuestions] Carregando questões para quizBookId: $quizBookId");
    final result = await questionRepository.getQuestionList(quizBookId);
    switch (result) {
      case Ok():
        _questionList = result.value;
        log("[QuestionListViewModel] [loadQuestions] ${_questionList.length} questões carregadas");
        if (_questionList.isNotEmpty) {
          _currentIndex = 0;
          final selectedResult = await questionRepository.getSelectedQuestion();
          switch (selectedResult) {
            case Ok():
              _selectedQuestion = selectedResult.value;
              log("[QuestionListViewModel] [loadQuestions] Questão selecionada: ${_selectedQuestion?.toString()}");
            case Error():
              log("[QuestionListViewModel] [loadQuestions] Erro ao selecionar questão: ${selectedResult.error}");
              break;
          }
        } else {
          _currentIndex = -1;
          _selectedQuestion = null;
          log("[QuestionListViewModel] [loadQuestions] Nenhuma questão encontrada");
        }
        notifyListeners();
      case Error():
        log("[QuestionListViewModel] [loadQuestions] Erro ao carregar questões: ${result.error}");
        break;
    }
  }

  void selectQuestion(int id) {
    log("[QuestionListViewModel] [selectQuestion] Selecionando questão com id: $id");
    if (id == -1) {
      _currentIndex = -1;
      _selectedQuestion = null;
      notifyListeners();
      return;
    }
    
    final index = _questionList.indexWhere((q) => q.id == id);
    if (index != -1) {
      _currentIndex = index;
      _selectedQuestion = _questionList[index];
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentIndex < _questionList.length - 1) {
      _currentIndex++;
      _selectedQuestion = _questionList[_currentIndex];
      notifyListeners();
    } else {
      _currentIndex = -1;
      _selectedQuestion = null;
      notifyListeners();
    }
  }

  void previousQuestion() {
    log("[QuestionListViewModel] [previousQuestion] currentIndex: $_currentIndex");
    if (_currentIndex == -1) {
      // Se estiver no modo de criação, vai para a última questão
      _currentIndex = _questionList.length - 1;
      _selectedQuestion = _questionList.last;
    } else if (_currentIndex > 0) {
      _currentIndex--;
      _selectedQuestion = _questionList[_currentIndex];
    }
    notifyListeners();
  }

  Future<void> createQuestion(Question question) async {
    log("[QuestionListViewModel] [createQuestion] Criando nova questão");
    final result = await questionRepository.createQuestion(question);
    switch (result) {
      case Ok():
        await loadQuestions();
        log("[QuestionListViewModel] [createQuestion] Questão criada com sucesso");
      case Error():
        log("[QuestionListViewModel] [createQuestion] Erro ao criar questão: ${result.error}");
        break;
    }
  }

  Future<void> updateQuestion(Question question) async {
    log("[QuestionListViewModel] [updateQuestion] Atualizando questão ${question.id}");
    final result = await questionRepository.updateQuestion(question);
    switch (result) {
      case Ok():
        await loadQuestions();
        log("[QuestionListViewModel] [updateQuestion] Questão atualizada com sucesso");
      case Error():
        log("[QuestionListViewModel] [updateQuestion] Erro ao atualizar questão: ${result.error}");
        break;
    }
  }

  Future<void> deleteQuestion(int id) async {
    log("[QuestionListViewModel] [deleteQuestion] Removendo questão $id");
    final result = await questionRepository.deleteQuestion(id);
    switch (result) {
      case Ok():
        await loadQuestions();
        log("[QuestionListViewModel] [deleteQuestion] Questão removida com sucesso");
      case Error():
        log("[QuestionListViewModel] [deleteQuestion] Erro ao remover questão: ${result.error}");
        break;
    }
  }
} 