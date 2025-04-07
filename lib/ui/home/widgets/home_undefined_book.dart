import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeUndefinedBook extends StatelessWidget {
  const HomeUndefinedBook({super.key});
  
  @override
  Widget build(BuildContext context) {

    debugPrint("Render undefined quiz book");

    return Column(
      children: [
        Card(
          color: Colors.brown[100],
          child: Book(quizBook: QuizBook(id: -1, title: "", icon: Icons.question_mark_outlined, color: Color.fromARGB(255, 88, 88, 88))),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go(Routes.quizBookForm);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                side: BorderSide(color: Colors.brown[100] as Color, width: 10, strokeAlign: 1),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text("Criar", style: TextStyle(fontSize: 26)),
            )
          ],
        )
      ],
    );
  }
}