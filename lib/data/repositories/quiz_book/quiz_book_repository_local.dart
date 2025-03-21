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
  Future<Result<QuizBook>> getQuizBook(int id) {
    final quizBookList = _localDataService.getQuizBookList();
    final quizBook = quizBookList.where((quizBook) => quizBook.id == id).firstOrNull;

    if (quizBook != null) {
      return Future.value(Result.ok(quizBook));
    } else {
      return Future.value(Result.error('Invalid quizBook id' as Exception));
    }
  }

  @override
  Future<Result<List<QuizBook>>> getQuizBookList() {
    return Future.value(Result.ok(_localDataService.getQuizBookList()));
  }

  @override
  Future<Result<QuizBook>> getSelectedQuizBook() async {
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
}