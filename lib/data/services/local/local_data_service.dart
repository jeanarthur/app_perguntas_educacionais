import 'package:app_perguntas_educacionais/domain/models/category/category.dart';

class LocalDataService {
  List<Category> getCategories() {
    return [
      Category(id: 0, title: 'Matemática'),
      Category(id: 1, title: 'Língua Portuguesa'),
      Category(id: 2, title: 'Inglês'),
      Category(id: 3, title: 'Geografia'),
    ];
  }
}