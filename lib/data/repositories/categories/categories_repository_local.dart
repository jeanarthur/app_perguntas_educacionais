import 'package:app_perguntas_educacionais/data/repositories/categories/categories_repository.dart';
import 'package:app_perguntas_educacionais/data/services/local/local_data_service.dart';
import 'package:app_perguntas_educacionais/domain/models/category/category.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';

class CategoriesRepositoryLocal implements CategoriesRepository {
  CategoriesRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;

  final LocalDataService _localDataService;

  @override
  Future<Result<Category>> getCategory(int id) {
    final categories = _localDataService.getCategories();
    final category = categories.where((category) => category.id == id).firstOrNull;

    if (category != null) {
      return Future.value(Result.ok(category));
    } else {
      return Future.value(Result.error('Invalid category id' as Exception));
    }

  }

  @override
  Future<Result<List<Category>>> getCategoryList() {
    return Future.value(Result.ok(_localDataService.getCategories()));
  }

  

}