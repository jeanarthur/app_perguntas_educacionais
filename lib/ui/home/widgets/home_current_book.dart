import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeCurrentBook extends StatelessWidget {
  const HomeCurrentBook({super.key, required this.viewModel});
  
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {

    debugPrint("Render current selected quiz book: ${viewModel.selectedQuizBook.id} | ${viewModel.selectedQuizBook.title} | ${viewModel.selectedQuizBook.icon}");

    Color getComplementaryColor(Color color) {
      int red = (color.r * 255).toInt();
      int green = (color.g * 255).toInt();
      int blue = (color.b * 255).toInt();

      // Calculate the complementary color
      int compRed = 255 - red;
      int compGreen = 255 - green;
      int compBlue = 255 - blue;

      return Color.fromARGB((color.a * 255).toInt(), compRed, compGreen, compBlue);
    }

    return Column(
      children: [
        Card(
          color: Colors.brown[100],
          child: Book(quizBook: viewModel.selectedQuizBook),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                side: BorderSide(color: Colors.brown[100] as Color, width: 10, strokeAlign: 1),
                backgroundColor: getComplementaryColor(viewModel.selectedQuizBook.color),
                foregroundColor: Colors.white,
              ),
              child: Text("Iniciar", style: TextStyle(fontSize: 26)),
            )
          ],
        )
      ],
    );
  }
}