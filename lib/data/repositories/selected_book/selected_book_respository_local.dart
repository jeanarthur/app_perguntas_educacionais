import 'package:app_perguntas_educacionais/data/repositories/selected_book/selected_book_repository.dart';
import 'package:app_perguntas_educacionais/domain/models/selected_book/selected_book.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

class SelectedBookRespositoryLocal implements SelectedBookRepository {

  SelectedBook? _selectedBook;

  SelectedBook? get selectedBook => _selectedBook;

  @override
  Future<Result<SelectedBook>> getSelectedBook() {
    return Future.value(Result.ok(_selectedBook!));
  }
  
  @override
  Future<Result<void>> setSelectedBook(int id) async {
    _selectedBook = SelectedBook(id: id);
    return const Result.ok(null);
  }
}