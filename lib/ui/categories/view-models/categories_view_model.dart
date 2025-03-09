import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/categories/categories_repository.dart';
import 'package:app_perguntas_educacionais/data/repositories/selected_book/selected_book_repository.dart';
import 'package:app_perguntas_educacionais/domain/models/category/category.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';
import 'package:flutter/material.dart';

class CategoriesViewModel extends ChangeNotifier {
  CategoriesViewModel({
    required this.categoriesRepository,
    required this.selectedBookRepository
  }) {
    load();
  }

  final CategoriesRepository categoriesRepository;
  final SelectedBookRepository selectedBookRepository;

  List<Category> _categories = [];

  List<Category> get categories => _categories;

  void load() async {
    log("Load categories");
    final result = await categoriesRepository.getCategoryList();
    switch (result) {
      case Ok():
      log("categories loaded: ${result.value}");
      _categories = result.value;
      for (Category category in _categories) {
        log("Category: id = ${category.id}, title = ${category.title}, imagePath = ${category.imagePath}");
      }
      notifyListeners();

      case Error():
        return;
    }
  }

  void selectBook(int id) async {
    selectedBookRepository.setSelectedBook(id);
  }

}