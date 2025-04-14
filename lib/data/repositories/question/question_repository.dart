import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

abstract class QuestionRepository {
  Future<Result<List<Question>>> getQuestionList(int quizBookId);
  Future<Result<Question>> getQuestion(int id);
  Future<Result<Question>> getSelectedQuestion();
  Future<Result<Question>> getNextQuestion();
  Future<Result<Question>> getPreviousQuestion();
  Future<Result<void>> setSelectedQuestion(int id);
  Future<Result<void>> createQuestion(Question question);
  Future<Result<void>> updateQuestion(Question question);
  Future<Result<void>> deleteQuestion(int id);
}