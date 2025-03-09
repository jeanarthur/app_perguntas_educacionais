import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_current_book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.viewModel});

  final String title;
  
  final dynamic viewModel;
  
  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
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
            ListenableBuilder(
              listenable: widget.viewModel, 
              builder: (context, child) {
                return HomeCurrentBook(viewModel: widget.viewModel);
              }
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.go(Routes.categories);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.list_alt, size: 32)
                    ],
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(width: 20), 
                OutlinedButton(
                  onPressed: () {
                    context.go(Routes.ranking);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.emoji_events, size: 32),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Iniciar", style: TextStyle(fontSize: 24)),
                )
              ],
            )
          ],
        ),
      ), 
    );
  }
}