import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:flutter/material.dart';

class HomeCurrentBook extends StatelessWidget {
  const HomeCurrentBook({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Book(title: 'Questionário A'),
      ],
    );
  }
}