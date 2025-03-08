import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classificação"),
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