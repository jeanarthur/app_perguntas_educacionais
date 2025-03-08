import 'package:app_perguntas_educacionais/data/repositories/categories/categories_repository_local.dart';
import 'package:app_perguntas_educacionais/data/services/local/local_data_service.dart';
import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/categories/view-models/categories_view_model.dart';
import 'package:app_perguntas_educacionais/ui/categories/widgets/categories_screen.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_screen.dart';
import 'package:app_perguntas_educacionais/ui/ranking/widgets/ranking_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewModel();
        return HomeScreen(title: 'App Perguntas Educacionais', viewModel: viewModel);
      }
    ),
    GoRoute(
      path: Routes.categories,
      builder: (context, state) {
        final localDataService = LocalDataService();
        final viewModel = CategoriesViewModel(
          categoriesRepository: CategoriesRepositoryLocal(localDataService: localDataService)
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