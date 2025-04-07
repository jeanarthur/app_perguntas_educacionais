import 'dart:typed_data';

import 'package:app_perguntas_educacionais/routing/routes.dart';
import 'package:app_perguntas_educacionais/utils/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool refreshImage = false;

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
            title: Text("Perfil", style: TextStyle(color: Colors.grey[200])),
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
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
                        )
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () => {
                      ProfilePicture.changeProfilePicture(),
                      setState(() {
                        refreshImage = true;
                      })
                    }, 
                    child: Text("Trocar")
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}