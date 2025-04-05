import 'package:app_perguntas_educacionais/domain/models/quiz_book/quiz_book.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {

  const Book({super.key, required this.quizBook, this.scale = 1.5});

  final QuizBook quizBook;
  final double scale;

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
              color: Color.lerp(quizBook.color, Colors.black, 0.4),
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
          color: quizBook.color,
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
              margin: EdgeInsets.only(top: 12.0 * scale),
              // color: Colors.blue[100],
              width: 120 * scale,
              height: 25 * scale,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(quizBook.title, style: TextStyle(fontSize: 13 * scale, color: Colors.white, fontWeight: FontWeight.bold),),
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
              margin: EdgeInsets.only(top: 20.0 * scale),
              // color: Colors.blue[100],
              width: 120 * scale,
              height: 100 * scale,
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      color: Color.lerp(quizBook.color, Colors.white, 0.6),
                    ),
                    Center(
                      child: Icon(
                        quizBook.icon, 
                        size: 100 * scale,
                        color: Color.lerp(quizBook.color, Colors.black, 0.3)
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
}