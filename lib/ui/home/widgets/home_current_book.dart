import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeCurrentBook extends StatelessWidget {
  const HomeCurrentBook({super.key, required this.viewModel});
  
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {

    debugPrint("Render current selected quiz book: ${viewModel.selectedQuizBook.id} | ${viewModel.selectedQuizBook.title}");

    return Column(
      children: [
        Book(quizBook: viewModel.selectedQuizBook),
      ],
    );
  }
}