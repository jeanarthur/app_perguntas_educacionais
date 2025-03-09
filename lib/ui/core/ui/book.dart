import 'package:app_perguntas_educacionais/domain/models/category/category.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {

  const Book({super.key, required this.category});

  final Category category;
  final double scale = 1.5;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * scale,
          height: 185 * scale,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: category.color[800],
              width: 147 * scale,
              height: 35 * scale,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * scale,
          height: 178 * scale,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey[300],
              width: 130 * scale,
              height: 28 * scale,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          color: category.color,
          width: 150 * scale,
          height: 170 * scale,
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * scale,
          height: 170 * scale,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              // color: Colors.blue[100],
              width: 120 * scale,
              height: 25 * scale,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(category.title, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 150 * scale,
          height: 170 * scale,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 35.0),
              // color: Colors.blue[100],
              width: 120 * scale,
              height: 100 * scale,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(category.imagePath),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
}