import 'package:app_perguntas_educacionais/config/dependencies.dart';
import 'package:app_perguntas_educacionais/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providersLocal,
      child: MaterialApp.router(
        title: 'App Perguntas Educacionais',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routerConfig: router(),
      ),  
    );
  }
}