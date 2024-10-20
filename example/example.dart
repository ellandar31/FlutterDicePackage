import 'package:flutter/material.dart';
import '../lib/dice_package.dart';

import 'package:get/get.dart';


void main() {
  Get.put(DiceController());//obligatoire pour initialiser le controller
  // Utiliser GetMaterialApp à la place de MaterialApp pour GetX
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( //obligatoire dans le cas d'une application avec GetX
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

// Exemple d'inclusion en version modale
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> diceColors = [
      Colors.red,
      Colors.yellow,
      Colors.purple,
      Colors.grey,
    ];

    return Column(
      children: [
        ModalDiceLauncher(diceColors: diceColors), // Widget modifié pour GetX
        const DicesResult(), // Affichage des résultats
      ],
    );
  }
}