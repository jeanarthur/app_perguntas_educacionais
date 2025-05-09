import 'dart:typed_data';

import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/home/view-models/home_view_model.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_current_book.dart';
import 'package:app_perguntas_educacionais/ui/home/widgets/home_undefined_book.dart';
import 'package:app_perguntas_educacionais/utils/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.viewModel});

  final String title;
  
  final HomeViewModel viewModel;
  
  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        if (!didPop) context.go(Routes.home);
      },
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bookshelf_background.png'),
              fit: BoxFit.cover,
              opacity: 0.5
            )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.brown[300],
              indicatorColor: Colors.brown[100],
              selectedIndex: 1,
              destinations: const <Widget>[
                NavigationDestination(
                  icon: Icon(Icons.menu_book, color: Colors.black),
                  label: 'Temas'
                ),
                NavigationDestination(
                  icon: Icon(Icons.home, color: Colors.black), 
                  label: 'Inicio'
                ),
                NavigationDestination(
                  icon: Icon(Icons.emoji_events, color: Colors.black),
                  label: 'Classificação',
                ),
              ],
              onDestinationSelected: (index) => {
                context.go(<String>[Routes.quizBookList, Routes.home, Routes.ranking][index])
              },
            ),
            appBar: AppBar(
              backgroundColor: Colors.brown,
              title: Text(widget.title, style: TextStyle(color: Colors.white),),
              actions: [
                InkWell(
                  onTap: () => {
                    context.go(Routes.profile)
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.brown[50],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: FutureBuilder<Uint8List>(
                          future: ProfilePicture.getProfilePicture(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Image.memory(snapshot.data!);
                            }
                          },
                        ),
                    ),
                  ),
                )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListenableBuilder(
                    listenable: widget.viewModel, 
                    builder: (context, child) {
                      if (widget.viewModel.isLoading) {
                        return const HomeUndefinedBook();
                      }
      
                      return child!;
                    },
                    child: HomeCurrentBook(viewModel: widget.viewModel),
                  ),
                ],
              ),
            ), 
          ),
      ),
    );
  }
}