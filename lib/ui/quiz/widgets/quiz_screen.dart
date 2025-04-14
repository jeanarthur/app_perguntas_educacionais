import 'package:app_perguntas_educacionais/domain/models/question/question.dart';
import 'package:app_perguntas_educacionais/ui/quiz/view-models/quiz_view_model.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.viewModel});

  final QuizViewModel viewModel;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final questions = widget.viewModel.questionList;
        if (questions.isEmpty) {
          return const Center(child: Text("Nenhuma questão disponível"));
        }

        final currentQuestion = questions[_currentQuestionIndex];
        return Scaffold(
          backgroundColor: Colors.brown[500],
          appBar: AppBar(
            title: Text(
              "Quiz - Questão ${_currentQuestionIndex + 1}/${questions.length}",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.brown[600],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.brown[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentQuestion.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ...List.generate(
                          currentQuestion.options.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ElevatedButton(
                              onPressed: _isAnswered ? null : () => _checkAnswer(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _getOptionColor(index),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                currentQuestion.options[index],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_isAnswered)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[300],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _currentQuestionIndex < questions.length - 1
                          ? "Próxima Questão"
                          : "Ver Resultado",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _checkAnswer(int selectedIndex) {
    setState(() {
      _isAnswered = true;
      if (selectedIndex == widget.viewModel.questionList[_currentQuestionIndex].correctOptionIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.viewModel.questionList.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswered = false;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Resultado Final"),
        content: Text(
          "Você acertou $_score de ${widget.viewModel.questionList.length} questões!",
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  Color? _getOptionColor(int index) {
    if (!_isAnswered) return Colors.brown[300];
    
    final correctIndex = widget.viewModel.questionList[_currentQuestionIndex].correctOptionIndex;
    if (index == correctIndex) return Colors.green;
    return Colors.red;
  }
} 