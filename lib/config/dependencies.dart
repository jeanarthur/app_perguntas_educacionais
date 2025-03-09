import 'package:app_perguntas_educacionais/data/repositories/categories/categories_repository.dart';
import 'package:app_perguntas_educacionais/data/repositories/categories/categories_repository_local.dart';
import 'package:app_perguntas_educacionais/data/repositories/selected_book/selected_book_repository.dart';
import 'package:app_perguntas_educacionais/data/repositories/selected_book/selected_book_respository_local.dart';
import 'package:app_perguntas_educacionais/data/services/local/local_data_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersLocal {
  return [
    Provider.value(value: LocalDataService()),
    Provider(create: (context) => CategoriesRepositoryLocal(localDataService: context.read()) as CategoriesRepository),
    Provider(create: (context) => SelectedBookRespositoryLocal() as SelectedBookRepository),
  ];
}