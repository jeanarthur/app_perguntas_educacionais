import 'dart:developer';

import 'package:app_perguntas_educacionais/data/repositories/categories/categories_repository.dart';
import 'package:app_perguntas_educacionais/data/repositories/selected_book/selected_book_repository.dart';
import 'package:app_perguntas_educacionais/domain/models/category/category.dart';
import 'package:app_perguntas_educacionais/utils/result.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required this.categoriesRepository,
    required this.selectedBookRepository
  }) {
    load();
  }

  Category _selectedBook = Category(id: 0);

  final SelectedBookRepository selectedBookRepository;
  final CategoriesRepository categoriesRepository;

  Category get selectedBook => _selectedBook;

  void load() async {
    var result = await selectedBookRepository.getSelectedBook();
    switch (result) {
      case Ok():
        var selectedBook = result.value;
        log('book selected: ${selectedBook.id}');
        var resultCategory = await categoriesRepository.getCategory(selectedBook.id);
        switch (resultCategory) {
          case Ok():
            _selectedBook = resultCategory.value;
            log('category: ${_selectedBook.title}');
            notifyListeners();
          case Error():
            log('error on get category: ${resultCategory.error}');
            return;
        }

      case Error():
        log('error on get selected book: ${result.error}');
        return;
    }
  }

}