import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classificação"),
        leading: InkWell(
          onTap: () {
            context.go(Routes.home);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Card(child: ListTile(title: Text('1º Lugar'))),
                  Card(child: ListTile(title: Text('2ª Lugar'))),
                  Card(child: ListTile(title: Text('3ª Lugar'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}