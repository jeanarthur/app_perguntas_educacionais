import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/editable_book.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/widgets/quiz_book_list_screen.dart';
import 'package:flutter/material.dart';

class QuizBookForm extends StatefulWidget {
  const QuizBookForm({super.key, required this.parent,required this.quizBook, required this.createCallback, this.isEditMode = false});

  final QuizBook quizBook;
  final Questionaries parent;
  final Function createCallback;
  
  final bool isEditMode;

  @override
  State<QuizBookForm> createState() => _QuizBookFormState();
}

class _QuizBookFormState extends State<QuizBookForm> {
  bool _isValid = false;
  bool _isChanged = false;
  var _editedQuizBook = null;

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
                    isValidCallback: (isValid, isChanged, editedQuizBook) => {
                      setState(() {
                        _isValid = isValid;
                        _isChanged = isChanged;
                        _editedQuizBook = editedQuizBook;
                      })
                    }),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _editedQuizBook != null && ((!widget.isEditMode && _isValid) || (widget.isEditMode && _isChanged)) ? () {
                    if (widget.isEditMode) {
                      widget.parent.viewModel.updateBook(_editedQuizBook);
                    } else {
                      widget.parent.viewModel.createBook(_editedQuizBook);
                    }

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