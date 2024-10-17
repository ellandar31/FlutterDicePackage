
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:FlutterDiceLibrary/dice_package.dart';


void main() {
  runApp(const ProviderScope(child: MyApp())); // nécessaire pour l'utilisation de riverpod dans la gestion des états
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

/// Exemple d'inclusion en version modale
class Home extends StatelessWidget {
  
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> diceColors = [Colors.red,
                                  Colors.yellow,
                                  Colors.purple, 
                                  Colors.grey];

    return Column(
      children: [
        ModalDiceLauncher(diceColors : diceColors),
        DicesResult(),
      ]);    
  }
}
