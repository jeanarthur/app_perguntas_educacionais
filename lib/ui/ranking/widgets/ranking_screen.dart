import 'dart:developer';

import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/ui/ranking/widgets/ranking_list.dart';
import 'package:app_perguntas_educacionais/ui/ranking/widgets/ranking_podium.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {

  @override
  void dispose() {
    super.dispose();
    log("[ranking_screen] Ranking screen disposed");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, r) {
        if (!didPop) context.go(Routes.home);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown[400]
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.brown,
            title: Text("Classificação", style: TextStyle(color: Colors.grey[200])),
            leading: InkWell(
              onTap: () {
                context.go(Routes.home);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
            )
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RankingPodium(),
                RankingList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}