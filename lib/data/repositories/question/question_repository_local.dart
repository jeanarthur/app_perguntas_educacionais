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
  List<Question>? get questionList => _questionList;

  @override
  Future<Result<Question>> getQuestion(int id) async {
    log("[QuestionRepositoryLocal] [getQuestion] Buscando questão com id: $id");
    if (_questionList == null) {
      final result = await getQuestionList(_selectedQuizBookId!);
      switch (result) {
        case Ok():
          _questionList = result.value;
        case Error():
          return Result.error(result.error);
      }
    }
    
    try {
      final question = _questionList!.firstWhere((q) => q.id == id);
      return Result.ok(question);
    } catch (e) {
      return Result.error(Exception('Questão não encontrada'));
    }
  }

  @override
  Future<Result<List<Question>>> getQuestionList(int quizBookId) async {
    log("[QuestionRepositoryLocal] [getQuestionList] Carregando questões para quizBookId: $quizBookId");
    _selectedQuizBookId = quizBookId;
    try {
      final questions = await _localDataService.getQuestionList(quizBookId);
      _questionList = questions;
      log("[QuestionRepositoryLocal] [getQuestionList] ${questions.length} questões carregadas");
      if (_questionList!.isNotEmpty) {
        _selectedQuestion = _questionList!.first;
      }
      return Result.ok(questions);
    } catch (e) {
      log("[QuestionRepositoryLocal] [getQuestionList] Erro ao carregar questões: $e");
      return Result.error(Exception('Erro ao carregar questões'));
    }
  }

  @override
  Future<Result<Question>> getSelectedQuestion() async {
    log("[QuestionRepositoryLocal] [getSelectedQuestion] Questão selecionada: ${_selectedQuestion?.toString()}");
    if (_selectedQuestion == null) {
      if (_questionList == null) {
        log("[QuestionRepositoryLocal] [getSelectedQuestion] Lista de questões nula, carregando...");
        final result = await getQuestionList(_selectedQuizBookId!);
        switch (result) {
          case Ok():
            _questionList = result.value;
            if (_questionList!.isNotEmpty) {
              _selectedQuestion = _questionList!.first;
              log("[QuestionRepositoryLocal] [getSelectedQuestion] Primeira questão selecionada: ${_selectedQuestion?.toString()}");
            } else {
              log("[QuestionRepositoryLocal] [getSelectedQuestion] Nenhuma questão encontrada");
              return Result.error(Exception('Nenhuma questão disponível'));
            }
          case Error():
            return Result.error(result.error);
        }
      } else if (_questionList!.isEmpty) {
        log("[QuestionRepositoryLocal] [getSelectedQuestion] Lista de questões vazia");
        return Result.error(Exception('Nenhuma questão disponível'));
      } else {
        _selectedQuestion = _questionList!.first;
        log("[QuestionRepositoryLocal] [getSelectedQuestion] Primeira questão da lista selecionada: ${_selectedQuestion?.toString()}");
      }
    }
    return Result.ok(_selectedQuestion!);
  }

  @override
  Future<Result<void>> setSelectedQuestion(int id) async {
    log("[QuestionRepositoryLocal] [setSelectedQuestion] Definindo questão selecionada: $id");
    final result = await getQuestion(id);
    switch (result) {
      case Ok():
        _selectedQuestion = result.value;
        return const Result.ok(null);
      case Error():
        return Result.error(result.error);
    }
  }
  
  @override
  Future<Result<void>> createQuestion(Question question) async {
    log("[QuestionRepositoryLocal] [createQuestion] Criando nova questão");
    try {
      await _localDataService.createQuestion(question);
      _questionList = null; // Força recarregamento na próxima requisição
      return const Result.ok(null);
    } catch (e) {
      log("[QuestionRepositoryLocal] [createQuestion] Erro ao criar questão: $e");
      return Result.error(Exception('Erro ao criar questão'));
    }
  }
  
  @override
  Future<Result<void>> deleteQuestion(int id) async {
    log("[QuestionRepositoryLocal] [deleteQuestion] Removendo questão: $id");
    try {
      await _localDataService.deleteQuestion(id);
      if (_selectedQuestion?.id == id) {
        _selectedQuestion = null;
      }
      _questionList = null; // Força recarregamento na próxima requisição
      return const Result.ok(null);
    } catch (e) {
      log("[QuestionRepositoryLocal] [deleteQuestion] Erro ao remover questão: $e");
      return Result.error(Exception('Erro ao remover questão'));
    }
  }
  
  @override
  Future<Result<void>> updateQuestion(Question question) async {
    log("[QuestionRepositoryLocal] [updateQuestion] Atualizando questão: ${question.id}");
    try {
      await _localDataService.updateQuestion(question);
      if (_selectedQuestion?.id == question.id) {
        _selectedQuestion = question;
      }
      _questionList = null; // Força recarregamento na próxima requisição
      return const Result.ok(null);
    } catch (e) {
      log("[QuestionRepositoryLocal] [updateQuestion] Erro ao atualizar questão: $e");
      return Result.error(Exception('Erro ao atualizar questão'));
    }
  }
  
  @override
  Future<Result<Question>> getNextQuestion() async {
    if (_questionList == null || _questionList!.isEmpty) {
      return Result.error(Exception('Nenhuma questão disponível'));
    }
    
    final currentIndex = _questionList!.indexWhere((q) => q.id == _selectedQuestion?.id);
    if (currentIndex == -1 || currentIndex >= _questionList!.length - 1) {
      return Result.error(Exception('Não há próxima questão'));
    }
    
    _selectedQuestion = _questionList![currentIndex + 1];
    return Result.ok(_selectedQuestion!);
  }
  
  @override
  Future<Result<Question>> getPreviousQuestion() async {
    if (_questionList == null || _questionList!.isEmpty) {
      return Result.error(Exception('Nenhuma questão disponível'));
    }
    
    final currentIndex = _questionList!.indexWhere((q) => q.id == _selectedQuestion?.id);
    if (currentIndex <= 0) {
      return Result.error(Exception('Não há questão anterior'));
    }
    
    _selectedQuestion = _questionList![currentIndex - 1];
    return Result.ok(_selectedQuestion!);
  }
}