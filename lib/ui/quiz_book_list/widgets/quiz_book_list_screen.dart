import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/view-models/quiz_book_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Questionaries extends StatelessWidget {
  const Questionaries({super.key, required this.viewModel});

  final CategoriesViewModel viewModel;

  @override
  Widget build(BuildContext context) {

    debugPrint("Categories widget loaded");

    return Scaffold(
      backgroundColor: Colors.brown[500],
      appBar: AppBar(
        title: Text("Questionários", style: TextStyle(color: Colors.grey[200]),),
        backgroundColor: Colors.brown[600],
        leading: InkWell(
          onTap: () {
            context.go(Routes.home);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, child) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: [
                      for (QuizBook quizBook in viewModel.quizBookList)
                        InkWell(
                          onTap: () => {
                            viewModel.selectBook(quizBook.id),
                            context.go(Routes.home)
                          },
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.brown[900],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 8,
                                  color: Colors.brown[500],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 8,
                                  color: Colors.brown[500],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 8,
                                  color: Colors.brown[500],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 8,
                                  color: Colors.brown[500],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Card(
                                  color: Colors.brown[100],
                                  child: Book(quizBook: quizBook, scale: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}