import 'package:app_perguntas_educacionais/domain/models/category/category.dart';
import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/categories/view-models/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Questionaries extends StatelessWidget {
  const Questionaries({super.key, required this.viewModel});

  final CategoriesViewModel viewModel;

  @override
  Widget build(BuildContext context) {

    debugPrint("Categories widget loaded");

    return Scaffold(
  appBar: AppBar(
    title: Text("Questionários"),
    leading: InkWell(
      onTap: () {
        context.go(Routes.home);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black54,
      ),
    ),
  ),
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, child) {
              return ListView(
                children: [
                  for (Category category in viewModel.categories)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ListTile(title: Text(category.title)),
                            ),
                            OutlinedButton(
                              onPressed: () => {
                                viewModel.selectBook(category.id),
                                context.go(Routes.home)
                              },
                              child: Text('Selecionar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  ),
);

  }
}