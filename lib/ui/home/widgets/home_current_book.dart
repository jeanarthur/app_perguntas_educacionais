import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  const Book({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 130,
          height: 165,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Colors.blue[800],
              width: 127,
              height: 15,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 130,
          height: 158,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey[300],
              width: 110,
              height: 8,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          color: Colors.blue,
          width: 130,
          height: 150,
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 130,
          height: 150,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              color: Colors.blue[100],
              width: 100,
              height: 15,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 130,
          height: 150,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              color: Colors.blue[100],
              width: 100,
              height: 80,
            ),
          ),
        ),
      ],
    );
  }
  
}