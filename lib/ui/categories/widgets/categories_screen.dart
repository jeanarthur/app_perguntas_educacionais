import 'package:flutter/material.dart';

class Questionaries extends StatelessWidget {
  const Questionaries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionários"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Card(child: ListTile(title: Text('Questionário A'))),
                  Card(child: ListTile(title: Text('Questionário B'))),
                  Card(child: ListTile(title: Text('Questionário C'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}