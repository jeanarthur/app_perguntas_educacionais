import 'package:app_perguntas_educacionais/ui/categories/widgets/categories_screen.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_book_stack.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_current_book.dart';
import 'package:app_perguntas_educacionais/ui/ranking/widgets/ranking_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: Text('Questionário A', style: TextStyle(fontSize: 24)),
            ),
            Book(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Questionaries())
                    );
                  },
                  child: BookStack(),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, 
                  ),
                  child: Text("Iniciar", style: TextStyle(fontSize: 16)),
                ),
                SizedBox(width: 20), 
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Ranking())
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.emoji_events, size: 24),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ), 
    );
  }
}