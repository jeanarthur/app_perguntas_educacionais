import 'package:app_perguntas_educacionais/ui/core/ui/book.dart';
import 'package:flutter/material.dart';

class BookStack extends StatelessWidget {
  const BookStack({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspectiva
            ..rotateX(-0.1),
          child: Book(),
        )
      ],
    );
  }
  
}