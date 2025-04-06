import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

abstract class QuizBookRepository {
  Future<Result<List<QuizBook>>> getQuizBookList();
  Future<Result<QuizBook>> getQuizBook(int id);
  Future<Result<QuizBook>> getSelectedQuizBook();
  Future<Result<void>> setSelectedQuizBook(int id);
  Future<Result<void>> createQuizBook(QuizBook quizBook);
}