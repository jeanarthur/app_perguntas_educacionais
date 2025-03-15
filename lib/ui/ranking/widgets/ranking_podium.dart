import 'package:flutter/material.dart';

class RankingPodium extends StatelessWidget {
  const RankingPodium({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.brown[50],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("450 Pts."),
                  Container(
                    color: Colors.grey,
                    height: 150,
                    width: 100,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.brown[50],
                          ),
                          height: 50,
                          width: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.person, size: 40),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("900 Pts."),
                  Container(
                    color: Colors.amber,
                    height: 200,
                    width: 100,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.brown[50],
                          ),
                          height: 50,
                          width: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.person, size: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("300 Pts."),
                  Container(
                    color: Colors.brown,
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.brown[50],
                          ),
                          height: 50,
                          width: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.person, size: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ), 
      ),
    );
  }
}