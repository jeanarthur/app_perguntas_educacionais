import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/view-models/quiz_book_list_view_model.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/widgets/quiz_book_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Questionaries extends StatefulWidget {
  const Questionaries({super.key, required this.viewModel, this.index});

  final CategoriesViewModel viewModel;
  final int? index;

  @override
  State<Questionaries> createState() => _QuestionariesState();
}

class _QuestionariesState extends State<Questionaries> {
  int _index = 0;
  var _selectedQuizBook = null;

  @override
  void initState() {
    super.initState();
    _index = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {

    debugPrint("Categories widget loaded");

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        if (!didPop) context.go(Routes.home);
      },
      child: Scaffold(
        backgroundColor: Colors.brown[500],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          backgroundColor: Colors.brown[300],
          indicatorColor: Colors.brown[100],
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.check_circle, color: Colors.black),
              label: 'Selecionar'
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle, color: Colors.black),
              label: 'Adicionar'
            ),
            NavigationDestination(
              icon: Icon(Icons.change_circle, color: Colors.black),
              label: 'Editar'
            ),
            NavigationDestination(
              icon: Icon(Icons.remove_circle, color: Colors.black),
              label: 'Remover'
            ),
          ],
          onDestinationSelected: (value) => {
            if (value != _index) {
              setState(() {
                _index = value;
                _selectedQuizBook = null;
              })
            }
          },
        ),
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
        body: Builder(
          builder: (context) {
            switch (_index) {
              case 0: return QuizBookList(
                widget: widget,
                selectBookCallback: (quizBook) => {
                  widget.viewModel.selectBook(quizBook.id),
                  context.go(Routes.home)
                }
              );
              case 1: return QuizBookForm(
                parent: widget, 
                quizBook: QuizBook(id: -1, title: "", icon: Icons.question_mark_outlined, color: Color.fromARGB(255, 88, 88, 88)),
                createCallback: (quizBook) => {
                  setState(() {
                    _index = 0;
                  })
                },
              );
              case 2: return _selectedQuizBook == null ? QuizBookList(
                widget: widget,
                selectBookCallback: (quizBook) {
                  setState(() {
                    _selectedQuizBook = quizBook;
                  });
                }
              ) : QuizBookForm(
                parent: widget, 
                quizBook: _selectedQuizBook,
                createCallback: () => {
                  setState(() {
                    _index = 0;
                  })
                },
                isEditMode: true,
              );
              case 3: return QuizBookList(
                widget: widget,
                selectBookCallback: (quizBook) {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Excluir ${quizBook.title}?"), 
                        actions: [
                          TextButton(
                            onPressed: () {
                              widget.viewModel.deleteBook(quizBook.id);
                              Navigator.of(context).pop();
                            },
                            child: Text('Confirmar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                        ],
                      );
                    }
                  );
                }
              );
              default: return QuizBookList(
                widget: widget,
                selectBookCallback: (quizBook) => {
                  widget.viewModel.selectBook(quizBook.id),
                  context.go(Routes.home)
                }
              );
            }
          }
        ),
      ),
    );
  }
}

class QuizBookList extends StatelessWidget {
  const QuizBookList({
    super.key,
    required this.widget,
    required this.selectBookCallback
  });

  final Questionaries widget;
  final Function selectBookCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, child) {
                return GridView.count(
                  crossAxisCount: 2,
                  children: [
                    for (QuizBook quizBook in widget.viewModel.quizBookList)
                      InkWell(
                        onTap: () => {
                          selectBookCallback(quizBook)
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
    );
  }
}