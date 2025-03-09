import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeCurrentBook extends StatelessWidget {
  const HomeCurrentBook({super.key, required this.viewModel});
  
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Book(category: viewModel.selectedBook),
      ],
    );
  }
}