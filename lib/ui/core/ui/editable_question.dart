import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/view-models/question_list_view_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class EditableQuestion extends StatefulWidget {
  const EditableQuestion({
    super.key,
    required this.viewModel,
    this.question,
    this.onStateChanged
  });

  final QuestionListViewModel viewModel;
  final Question? question;
  final VoidCallback? onStateChanged;

  @override
  State<EditableQuestion> createState() => _EditableQuestionState();
}

class _EditableQuestionState extends State<EditableQuestion> {
  late TextEditingController _titleController;
  late List<TextEditingController> _optionControllers;
  int? _selectedOptionIndex;
  bool _isValid = false;
  bool _isChanged = false;
  final ValueNotifier<Question?> _currentQuestion = ValueNotifier<Question?>(null);

  @override
  void initState() {
    super.initState();
    developer.log("[EditableQuestion] [initState] question: ${widget.question?.toString()}");
    _titleController = TextEditingController(text: widget.question?.title ?? '');
    _optionControllers = List.generate(4, (index) => 
      TextEditingController(text: widget.question?.options[index] ?? '')
    );
    _selectedOptionIndex = widget.question?.correctOptionIndex;
    _currentQuestion.value = widget.question;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  @override
  void didUpdateWidget(EditableQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    developer.log("[EditableQuestion] [didUpdateWidget] oldQuestion: ${oldWidget.question?.toString()}, newQuestion: ${widget.question?.toString()}");
    if (widget.question != oldWidget.question) {
      _currentQuestion.value = widget.question;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateForm(widget.question);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    _currentQuestion.dispose();
    super.dispose();
  }

  void _validateForm() {
    bool isValid = _titleController.text.isNotEmpty &&
      _optionControllers.every((controller) => controller.text.isNotEmpty) &&
      _selectedOptionIndex != null;

    bool isChanged = widget.question == null || 
      _titleController.text != widget.question?.title ||
      _optionControllers.asMap().entries.any((entry) => entry.value.text != widget.question?.options[entry.key]) ||
      _selectedOptionIndex != widget.question?.correctOptionIndex;

    developer.log("[EditableQuestion] [validateForm] isValid: $isValid, isChanged: $isChanged, currentQuestion: ${_currentQuestion.value?.toString()}");
    setState(() {
      _isValid = isValid;
      _isChanged = isChanged;
    });
    widget.onStateChanged?.call();
  }

  Question _createQuestion() {
    return Question(
      id: widget.question?.id ?? -1,
      quizBookId: widget.viewModel.quizBookId,
      title: _titleController.text,
      options: _optionControllers.map((c) => c.text).toList(),
      correctOptionIndex: _selectedOptionIndex!
    );
  }

  void _clearForm() {
    developer.log("[EditableQuestion] [clearForm]");
    _titleController.clear();
    for (var controller in _optionControllers) {
      controller.clear();
    }
    _selectedOptionIndex = null;
    _currentQuestion.value = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  void _updateForm(Question? question) {
    developer.log("[EditableQuestion] [updateForm] question: ${question?.toString()}");
    _titleController.text = question?.title ?? '';
    for (var i = 0; i < 4; i++) {
      _optionControllers[i].text = question?.options[i] ?? '';
    }
    _selectedOptionIndex = question?.correctOptionIndex;
    _currentQuestion.value = question;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Question?>(
      valueListenable: _currentQuestion,
      builder: (context, currentQuestion, child) {
        return ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            final bool isNewQuestion = currentQuestion == null || widget.viewModel.currentIndex == -1;
            developer.log("[EditableQuestion] [build] isNewQuestion: $isNewQuestion, currentQuestion: ${currentQuestion?.toString()}, currentIndex: ${widget.viewModel.currentIndex}");
            
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          isNewQuestion ? "Nova Questão" : "Editar Questão",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[900],
                          ),
                        ),
                      ),
                      if (!isNewQuestion)
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              developer.log("[EditableQuestion] [onPressed] Remover - currentQuestion: ${_currentQuestion.value?.toString()}");
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Confirmar remoção"),
                                  content: const Text("Tem certeza que deseja remover esta questão?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        developer.log("[EditableQuestion] [onPressed] Confirmar remoção - questionId: ${_currentQuestion.value?.id}");
                                        widget.viewModel.deleteQuestion(_currentQuestion.value!.id);
                                        Navigator.of(context).pop();
                                        if (widget.viewModel.currentIndex > 0) {
                                          widget.viewModel.previousQuestion();
                                          _updateForm(widget.viewModel.selectedQuestion);
                                        } else if (widget.viewModel.questionList.isNotEmpty) {
                                          widget.viewModel.nextQuestion();
                                          _updateForm(widget.viewModel.selectedQuestion);
                                        } else {
                                          _clearForm();
                                          widget.viewModel.selectQuestion(-1);
                                          widget.onStateChanged?.call();
                                        }
                                      },
                                      child: const Text("Remover"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Digite a pergunta",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (_) => _validateForm(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Opções",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "* Selecione a opção correta",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(4, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _selectedOptionIndex == index,
                          onChanged: (selected) {
                            _selectedOptionIndex = selected! ? index : null;
                            _validateForm();
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _optionControllers[index],
                            decoration: InputDecoration(
                              hintText: "Digite a opção ${index + 1}",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (_) => _validateForm(),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: ElevatedButton(
                          onPressed: widget.viewModel.questionList.isNotEmpty && 
                            (widget.viewModel.currentIndex == -1 || widget.viewModel.currentIndex > 0) ? () {
                            developer.log("[EditableQuestion] [onPressed] Anterior - currentIndex: ${widget.viewModel.currentIndex}");
                            widget.viewModel.previousQuestion();
                            _updateForm(widget.viewModel.selectedQuestion);
                          } : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            backgroundColor: Colors.brown[300],
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Anterior"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: _isValid && _isChanged ? () {
                            developer.log("[EditableQuestion] [onPressed] ${isNewQuestion ? "Criar" : "Salvar"} - isValid: $_isValid, isChanged: $_isChanged");
                            if (isNewQuestion) {
                              final newQuestion = _createQuestion();
                              widget.viewModel.createQuestion(newQuestion);
                              developer.log("[EditableQuestion] [onPressed] Questão criada, atualizando formulário");
                              Future.delayed(const Duration(milliseconds: 100), () {
                                final updatedQuestion = widget.viewModel.questionList.lastWhere((q) => q.title == newQuestion.title);
                                widget.viewModel.selectQuestion(updatedQuestion.id);
                                _updateForm(updatedQuestion);
                                widget.onStateChanged?.call();
                              });
                            } else {
                              widget.viewModel.updateQuestion(_createQuestion());
                            }
                          } : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            backgroundColor: Colors.brown[300],
                            foregroundColor: Colors.black,
                          ),
                          child: Text(isNewQuestion ? "Criar" : "Salvar"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: !isNewQuestion || _isValid ? () {
                            developer.log("[EditableQuestion] [onPressed] Próximo - currentIndex: ${widget.viewModel.currentIndex}");
                            widget.viewModel.nextQuestion();
                            _updateForm(widget.viewModel.selectedQuestion);
                            widget.onStateChanged?.call();
                          } : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            backgroundColor: Colors.brown[300],
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Próximo"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}