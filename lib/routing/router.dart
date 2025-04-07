import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/profile/widgets/profile_screen.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/view-models/quiz_book_list_view_model.dart';
import 'package:app_perguntas_educacionais/ui/quiz_book_list/widgets/quiz_book_list_screen.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_screen.dart';
import 'package:app_perguntas_educacionais/ui/ranking/widgets/ranking_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) {
        final viewModel = HomeViewModel(
          quizBookRepository: context.read()
        );
        return simpleTransition(HomeScreen(title: 'App Perguntas Educacionais', viewModel: viewModel));
      }
    ),
    GoRoute(
      path: Routes.quizBookList,
      pageBuilder: (context, state) {
        final viewModel = CategoriesViewModel(
          quizBookRepository: context.read()
        );
        return simpleTransition(Questionaries(viewModel: viewModel));
      }
    ),
    GoRoute(
      path: Routes.quizBookForm,
      pageBuilder: (context, state) {
        final viewModel = CategoriesViewModel(
          quizBookRepository: context.read()
        );
        return simpleTransition(Questionaries(viewModel: viewModel, index: 1));
      }
    ),
    GoRoute(
      path: Routes.ranking,
      pageBuilder: (context, state) {
        return simpleTransition(Ranking());
      }
    ),
    GoRoute(
      path: Routes.profile,
      pageBuilder: (context, state) {
        return simpleTransition(ProfileScreen());
      }
    )
  ]
);

CustomTransitionPage<dynamic> simpleTransition(Widget child) {
  return CustomTransitionPage(
    child: child, 
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
  );
}

