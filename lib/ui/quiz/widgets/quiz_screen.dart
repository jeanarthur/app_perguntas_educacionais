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
  int? _selectedIndex;

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
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / questions.length,
                  backgroundColor: Colors.brown[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.brown[400]!),
                  minHeight: 8,
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.brown[100],
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Questão ${_currentQuestionIndex + 1}/${questions.length}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.brown[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentQuestion.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ...List.generate(
                          currentQuestion.options.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: _getOptionColor(index),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _isAnswered ? null : () => _checkAnswer(index),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _isAnswered
                                                ? _getOptionIconColor(index)
                                                : Colors.brown[200],
                                          ),
                                          child: Icon(
                                            _getOptionIcon(index),
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            currentQuestion.options[index],
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: _isAnswered
                                                  ? Colors.white
                                                  : Colors.brown[900],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_isAnswered)
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isAnswered ? 1.0 : 0.0,
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[300],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        _currentQuestionIndex < questions.length - 1
                            ? "Próxima Questão"
                            : "Ver Resultado",
                        style: const TextStyle(fontSize: 18),
                      ),
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
      _selectedIndex = selectedIndex;
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
        _selectedIndex = null;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _score >= widget.viewModel.questionList.length / 2
                    ? Icons.emoji_events
                    : Icons.sentiment_dissatisfied,
                size: 64,
                color: _score >= widget.viewModel.questionList.length / 2
                    ? Colors.amber
                    : Colors.brown[300],
              ),
              const SizedBox(height: 16),
              Text(
                "Resultado Final",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Você acertou $_score de ${widget.viewModel.questionList.length} questões!",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Fechar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _getOptionColor(int index) {
    if (!_isAnswered) return Colors.brown[50];
    
    final correctIndex = widget.viewModel.questionList[_currentQuestionIndex].correctOptionIndex;
    if (index == _selectedIndex) {
      return index == correctIndex ? Colors.green[400] : Colors.red[400];
    }
    return Colors.brown[50];
  }

  Color? _getOptionIconColor(int index) {
    if (!_isAnswered) return Colors.brown[300];
    
    final correctIndex = widget.viewModel.questionList[_currentQuestionIndex].correctOptionIndex;
    if (index == _selectedIndex) {
      return index == correctIndex ? Colors.green[600] : Colors.red[600];
    }
    return Colors.brown[300];
  }

  IconData _getOptionIcon(int index) {
    if (!_isAnswered) return Icons.circle_outlined;
    
    final correctIndex = widget.viewModel.questionList[_currentQuestionIndex].correctOptionIndex;
    if (index == _selectedIndex) {
      return index == correctIndex ? Icons.check : Icons.close;
    }
    return Icons.circle_outlined;
  }
} 