import 'package:app_perguntas_educacionais/domain/models/selected_book/selected_book.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

abstract class SelectedBookRepository {
  Future<Result<SelectedBook>> getSelectedBook();
  Future<Result<void>> setSelectedBook(int id);
}