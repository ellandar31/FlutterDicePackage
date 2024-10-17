import 'package:flutter/material.dart';

import 'multi_dice.dart';

/// Widget permettant l'inclusion d'un bouton dans la page appelante avec affichage d'un dialog modal contenant le widget MultiDice de lancement des dés
class ModalDiceLauncher extends StatelessWidget {
  /// Liste des couleurs de dés
  final List<Color> diceColors;

  /// Constructeur
  ModalDiceLauncher({super.key, required this.diceColors,});

  @override
  Widget build(BuildContext context) {
    //Limiter à un bouton sur la page appelante 
    return ElevatedButton(
        child: Text('Lancer les dés'),
        onPressed: () => _showMultiDiceDialog(context),      
    );
  }

  /// fonction permettant d'afficher la modale de lancement de dés 
  void _showMultiDiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9, // 90% de la largeur de l'écran
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Utilisation de la taille minimum requise
                  children: [
                    const SizedBox(height: 10),
                    MultiDice(this.diceColors), // Affichage du composant permettant de lancé les dés 
                    const SizedBox(height: 20),
                  ]
                )
              ),
              // Bouton de fermeture en haut à droite
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer la modale
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
