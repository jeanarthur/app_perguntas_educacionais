import 'dart:developer';

import 'package:flutter/material.dart';

class RankingPodium extends StatefulWidget {
  const RankingPodium({
    super.key,
  });

  @override
  State<RankingPodium> createState() => _RankingPodiumState();
}

class _RankingPodiumState extends State<RankingPodium> {

  double _baseHeight = 0;
  Color _firstColor = Colors.black;
  Color _secondColor = Colors.black;
  Color _thirdColor = Colors.black;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        log("[ranking_podium] Animation dispatch");
        _baseHeight = 50;

        _firstColor = Colors.amber;
        _secondColor = Colors.grey;
        _thirdColor = Colors.brown;

      });
    });
  }

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
                  TweenAnimationBuilder(
                    tween: IntTween(
                      begin: 0,
                      end: 450
                    ), 
                    duration: Duration(milliseconds: 1500), 
                    builder: (context, value, child) {
                      return Text("$value Pts.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
                    }
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn,
                    color: _secondColor,
                    height: 50 + _baseHeight * 2,
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
                  TweenAnimationBuilder(
                    tween: IntTween(
                      begin: 0,
                      end: 900
                    ), 
                    duration: Duration(milliseconds: 1500), 
                    builder: (context, value, child) {
                      return Text("$value Pts.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
                    }
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn,
                    color: _firstColor,
                    height: 50 + _baseHeight * 3,
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
                  TweenAnimationBuilder(
                    tween: IntTween(
                      begin: 0,
                      end: 300
                    ), 
                    duration: Duration(milliseconds: 1500), 
                    builder: (context, value, child) {
                      return Text("$value Pts.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
                    }
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn,
                    color: _thirdColor,
                    height: 50 + _baseHeight,
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