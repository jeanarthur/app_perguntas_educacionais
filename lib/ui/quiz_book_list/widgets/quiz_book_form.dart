import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/editable_book.dart';
import 'package:app_perguntas_educacionais/ui/core/ui/editable_question.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/view-models/question_list_view_model.dart';
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
  late QuestionListViewModel _questionViewModel;
  final ValueNotifier<bool> _dialogState = ValueNotifier<bool>(false);
  final ValueNotifier<Question?> _questionState = ValueNotifier<Question?>(null);

  @override
  void initState() {
    super.initState();
    _questionViewModel = QuestionListViewModel(
      questionRepository: widget.parent.viewModel.questionRepository,
      quizBookId: widget.quizBook.id
    );
    _questionState.value = _questionViewModel.selectedQuestion;
  }

  @override
  void dispose() {
    _dialogState.dispose();
    _questionState.dispose();
    super.dispose();
  }

  void _showQuestionDialog() {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        return ValueListenableBuilder<bool>(
          valueListenable: _dialogState,
          builder: (context, value, child) {
            return ValueListenableBuilder<Question?>(
              valueListenable: _questionState,
              builder: (context, question, child) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        EditableQuestion(
                          viewModel: _questionViewModel,
                          question: question,
                          onStateChanged: () {
                            _dialogState.value = !_dialogState.value;
                            _questionState.value = _questionViewModel.selectedQuestion;
                          }
                        ),
                      ],
                    ),
                  )
                );
              }
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Align(
            alignment: Alignment.center,
            child: ListenableBuilder(
              listenable: _questionViewModel,
              builder: (context, child) {
                return Column(
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
                    Builder(
                      builder: (context) {
                        var saveButton = ElevatedButton(
                          onPressed: _editedQuizBook != null && ((!widget.isEditMode && _isValid) || (widget.isEditMode && _isChanged)) ? () {
                            if (widget.isEditMode) {
                              widget.parent.viewModel.updateBook(_editedQuizBook);
                            } else {
                              widget.parent.viewModel.createBook(_editedQuizBook);
                            }
                        
                            widget.createCallback(_editedQuizBook);
                          } : null,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                            side: BorderSide(color: Colors.brown[100] as Color, width: 10, strokeAlign: 1),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey
                          ),
                          child: Text("Salvar", style: TextStyle(fontSize: 26)),
                        );

                        var questionButton = ElevatedButton(
                          onPressed: _showQuestionDialog,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                            side: BorderSide(color: Colors.brown[100] as Color, width: 10, strokeAlign: 1),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey
                          ),
                          child: Icon(Icons.list_alt_outlined, size: 37,),
                        );

                        return widget.isEditMode ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            saveButton,
                            questionButton
                          ],
                        ) : saveButton;
                      }
                    )
                  ],
                );
              }
            ),
          ),
        );
  }
}