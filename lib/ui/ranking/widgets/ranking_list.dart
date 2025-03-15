import 'package:flutter/material.dart';

class RankingList extends StatelessWidget {
  const RankingList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
          children: List.generate(10, (index) {
              return Card(
                color: Colors.brown[50], 
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${index + 4}º Lugar'),
                      Text('${290 - index * 20} Pts.')
                    ],
                  )
                )
              );
            }),
        ),
      ),
    );
  }
}