import 'dart:developer';

class Question {

  late int id;
  int quizBookId;
  String title;
  List<String> options;
  int correctOptionIndex;
  
  Question({required this.id, required this.quizBookId, required this.title, required this.options, required this.correctOptionIndex});

  Map<String, Object?> toMap() {
    return {'id': id, 'quizBookId': quizBookId, 'title': title, 'options': options.join('<endOption>'), 'correctOptionIndex': correctOptionIndex};
  }

  @override
  String toString() {
    return 'Question{id: $id, quizBookid: $quizBookId, title: $title, options: ${options.join('<endOption>')}, correctOptionIndex:$correctOptionIndex}';
  }

  static Question copyOf(Question question) {
    return Question(id: question.id, quizBookId: question.quizBookId, title: question.title, options: question.options, correctOptionIndex: question.correctOptionIndex);
  }

  bool areEqualTo(Question question) {
    log("[Question] [areEqualTo] id: [$id | ${question.id}] <${id == question.id}>");
    log("[Question] [areEqualTo] quizBookId: [$quizBookId | ${question.quizBookId}] <${id == question.quizBookId}>");
    log("[Question] [areEqualTo] title: [$title | ${question.title}] <${title == question.title}>");
    log("[Question] [areEqualTo] icon: [${options.join('<endOption>')} | ${question.options.join('<endOption>')}] <${options.join('<endOption>') == question.options.join('<endOption>')}>");
    log("[Question] [areEqualTo] color: [$correctOptionIndex | ${question.correctOptionIndex}] <${correctOptionIndex == question.correctOptionIndex}>");
    return id == question.id &&
      quizBookId == question.quizBookId &&
      title == question.title &&
      options.join('<endOption>') == question.options.join('<endOption>') &&
      correctOptionIndex == question.correctOptionIndex;
  }

}