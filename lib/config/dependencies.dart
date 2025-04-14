import 'package:app_perguntas_educacionais/data/repositories/question/question_repository.dart';
import 'package:app_perguntas_educacionais/data/repositories/question/question_repository_local.dart';
import 'package:app_perguntas_educacionais/data/repositories/quiz_book/quiz_book_repository.dart';
import 'package:app_perguntas_educacionais/data/repositories/quiz_book/quiz_book_repository_local.dart';
import 'package:app_perguntas_educacionais/data/services/local/local_data_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersLocal {
  return [
    Provider.value(value: LocalDataService()),
    Provider(create: (context) => QuizBookRepositoryLocal(localDataService: context.read()) as QuizBookRepository),
    Provider(create: (context) => QuestionRepositoryLocal(localDataService: context.read()) as QuestionRepository),
  ];
}