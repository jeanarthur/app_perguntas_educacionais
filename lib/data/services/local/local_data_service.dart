import 'package:app_perguntas_educacionais/domain/models/category/category.dart';
import 'package:flutter/material.dart';

class LocalDataService {
  List<Category> getCategories() {
    return [
      Category(id: 0, title: 'Matemática', color: Colors.blue),
      Category(id: 1, title: 'Língua Portuguesa', imagePath: 'assets/images/portuguese_quiz_cover.png', color: Colors.red),
      Category(id: 2, title: 'Inglês', color: Colors.orange),
      Category(id: 3, title: 'Geografia', color: Colors.brown),
    ];
  }
}