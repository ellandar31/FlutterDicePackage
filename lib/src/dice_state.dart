import 'package:flutter/material.dart';
import 'svg_dice.dart';

/// DiceState représente l'état individuel de chaque dé
class DiceState {
  bool isSelected; // dé sélectionné
  int number; // résultat du lancé de dé (face du dessus)
  Color curColor; // couleur du dé
  final double currentRotation; // axe de rotation du dé (en 2D)
  final bool rolling; // true si le dé est en train de rouler/lancement en cours

  /// Constructeur du dé
  DiceState({
    required this.isSelected,
    required this.number,
    required this.curColor,
    required this.currentRotation,
    required this.rolling,
  });

  /// État initial d'un dé
  DiceState.initial(Color color)
      : isSelected = false, // par défaut non sélectionné
        number = 1, // valeur par défaut du dé
        curColor = color, // couleur donné à l'initialisation 
        currentRotation = 0, // axe de rotation par défaut
        rolling = true; // dé non stabilisé au démarrage (non pris en compte dans le résultat)

  /// Widget du dé en taille réelle (avec animation dans le cas des lancés)
  Widget getFullDice() {
    return Transform.rotate(
      angle: currentRotation * 180,
      child: SvgDice(curColor, number).getFullDice(),
    );
  }

  /// Widget du dé en miniature (au repos) pour l'affichage des résultats
  Widget getMinDice() {
    return SvgDice(curColor, number).getMinDice();
  }
}

