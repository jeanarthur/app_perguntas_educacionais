import 'package:app_perguntas_educacionais/domain/models/category/category.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

abstract class CategoriesRepository {

  Future<Result<List<Category>>> getCategoryList();

  Future<Result<Category>> getCategory(int id);

}