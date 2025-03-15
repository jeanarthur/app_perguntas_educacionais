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
          children: [
            Card(color: Colors.brown[50], child: ListTile(title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('4º Lugar'),
                Text('200 Pts.')
              ],
            ))),
            Card(color: Colors.brown[50], child: ListTile(title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('5º Lugar'),
                Text('200 Pts.')
              ],
            ))),
            Card(color: Colors.brown[50], child: ListTile(title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('6º Lugar'),
                Text('190 Pts.')
              ],
            ))),
            Card(color: Colors.brown[50], child: ListTile(title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('7º Lugar'),
                Text('188 Pts.')
              ],
            ))),
            Card(color: Colors.brown[50], child: ListTile(title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('8º Lugar'),
                Text('150 Pts.')
              ],
            ))),
            Card(color: Colors.brown[50], child: ListTile(title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('9º Lugar'),
                Text('140 Pts.')
              ],
            ))),
          ],
        ),
      ),
    );
  }
}