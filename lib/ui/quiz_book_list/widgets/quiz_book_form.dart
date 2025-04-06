import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/editable_book.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/widgets/quiz_book_list_screen.dart';
import 'package:flutter/material.dart';

class QuizBookForm extends StatefulWidget {
  const QuizBookForm({super.key, required this.parent,required this.quizBook, required this.createCallback});

  final QuizBook quizBook;
  final Questionaries parent;
  final Function createCallback;

  @override
  State<QuizBookForm> createState() => _QuizBookFormState();
}

class _QuizBookFormState extends State<QuizBookForm> {
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.brown[100],
                  child: EditableBook(
                    quizBook: widget.quizBook, 
                    scale: 2, 
                    isValidCallback: (isValid) => {
                      setState(() {
                        _isValid = isValid;
                      })
                    }),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _isValid ? () {
                    widget.parent.viewModel.createBook(widget.quizBook);
                    widget.createCallback();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                    side: BorderSide(color: Colors.brown[100] as Color, width: 10, strokeAlign: 1),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey
                  ),
                  child: Text("Salvar", style: TextStyle(fontSize: 26)),
                )
              ],
            ),
          ),
        );
  }
}