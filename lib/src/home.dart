import 'package:flutter/material.dart';
import 'dicelib/multi_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller App'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Lancer les dés'),
          onPressed: () => _showMultiDiceDialog(context),
        ),
      ),
    );
  }

  void _showMultiDiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // 80% de la largeur de l'écran
            height: MediaQuery.of(context).size.height *
                0.8, // 80% de la hauteur de l'écran
            child: MultiDice(
              diceColors: [
                Colors.red,
                Colors.yellow,
                Colors.green,
                Colors.purple,
                Colors.grey.shade300,
                Colors.grey.shade300,
                Colors.grey.shade300,
                Colors.grey.shade300
              ],
            ),
          ),
        );
      },
    );
  }
}
