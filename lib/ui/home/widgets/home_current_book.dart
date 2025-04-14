import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCurrentBook extends StatelessWidget {
  const HomeCurrentBook({super.key, required this.viewModel});
  
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final selectedQuizBook = viewModel.quizBookList.firstWhere(
      (quizBook) => quizBook.id == viewModel.selectedQuizBookId,
      orElse: () => QuizBook(
        id: -1,
        title: "Nenhum livro selecionado",
        icon: Icons.question_mark_outlined,
        color: Color.fromARGB(255, 88, 88, 88)
      )
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.brown[100],
          child: Book(quizBook: selectedQuizBook, scale: 2),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: viewModel.selectedQuizBookId != -1 ? () {
            context.push(Routes.quiz, extra: viewModel.selectedQuizBookId);
          } : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
            side: BorderSide(color: Colors.brown[100] as Color, width: 10, strokeAlign: 1),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey
          ),
          child: const Text("Iniciar", style: TextStyle(fontSize: 26)),
        ),
      ],
    );
  }

  Color getComplementaryColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness(1 - hsl.lightness).toColor();
  }
}