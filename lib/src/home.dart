import 'package:flutter/material.dart';
import 'package:start/guard/profile.dart';

import 'default_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //TODO add your actions here 
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              signOutMethod(context);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      //TODO change for your content 
      body: const Content(),
    );
  }
}
