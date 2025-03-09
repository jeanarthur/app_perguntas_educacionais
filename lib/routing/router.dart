import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/view-models/quiz_book_list_view_model.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/widgets/quiz_book_list_screen.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_screen.dart';
import 'package:app_perguntas_educacionais/ui/ranking/widgets/ranking_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewModel(
          quizBookRepository: context.read()
        );
        return HomeScreen(title: 'App Perguntas Educacionais', viewModel: viewModel);
      }
    ),
    GoRoute(
      path: Routes.quizBookList,
      builder: (context, state) {
        final viewModel = CategoriesViewModel(
          quizBookRepository: context.read()
        );
        return Questionaries(viewModel: viewModel);
      }
    ),
    GoRoute(
      path: Routes.ranking,
      builder: (context, state) {
        return Ranking();
      }
    )
  ]
);