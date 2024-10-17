import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

/// Fournisseur qui gère une liste de dés
final diceProvider = StateNotifierProvider<DiceNotifier, List<DiceState>>((ref) {
  return DiceNotifier();
});

/// Notifier pour gérer une liste de dés, permet de gérer les fonctions d'initalisation, lancé, résultat
class DiceNotifier extends StateNotifier<List<DiceState>> {

  DiceNotifier() : super([]);

  Random random = Random();

  /// Ajouter un nouveau dé avec une couleur spécifique
  void addDice(Color color) {
    state = [...state, DiceState.initial(color)];
  }
  
  /// Initialiser plusieurs dés avec une liste de couleurs
  void initDices(List<Color> colors) {
    // Ajouter chaque dé à l'état
    state = [
      ...colors.map((color) => DiceState.initial(color)).toList()
    ];
  }
  
  /// Lancer le dé à l'index spécifié
  void launchRoll(int index) {
    if (index < 0 || index >= state.length) return;

    // Créer une copie du dé actuel avec l'état de roulement
    final dice = state[index];
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          DiceState(
            isSelected: true, // on force la sélection du dés (cas d'un lancé unique sans checkbox)
            curColor: dice.curColor,
            number: dice.number,
            currentRotation: dice.currentRotation,
            rolling: true, // Positionne le flag de roulement en cours
          )
        else //on ne touche pas aux autres dés
          state[i]
    ];

    int counter = 1;

    // Débuter le lancer de dé avec un timer
    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      counter++;
      final newDice = state[index];
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            DiceState(
              isSelected: newDice.isSelected,
              curColor: newDice.curColor,
              number: random.nextInt(6) + 1, // Générer un numéro de dé aléatoire
              currentRotation: random.nextDouble(), // Générer un degré de rotation du dé pendant le lancé
              rolling: true, 
            )
          else //on ne touche pas aux autres dés
            state[i]
      ];

      // Arrêter le lancer après un certain nombre de tours (13)
      if (counter >= 13) {
        timer.cancel();
        state = [
          for (int i = 0; i < state.length; i++)
            if (i == index)
              DiceState(
                isSelected: newDice.isSelected,
                curColor: newDice.curColor,
                number: newDice.number,
                currentRotation: 0, // Positionne la rotation à 0° pour avoir la face du dessus en haut
                rolling: false,
              )
            else
              state[i]
        ];
      }
    });
  }

  /// Lancer tous les dés sélectionnés
  void launchSelectedRoll() {
    for (int i = 0; i < state.length; i++) {
      if (state[i].isSelected) {
        launchRoll(i); // Lancer chaque dé sélectionné
      }
    }
  }

  /// Sélectionner/Désélectionner un dé
  void toggleSelection(int index) {
    if (index < 0 || index >= state.length) return;

    final dice = state[index];
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          DiceState(
            isSelected: !dice.isSelected, // Inverse l'état de sélection du dé
            //récupération des autres valeurs de l'état
            curColor: dice.curColor, 
            number: dice.number,
            currentRotation: dice.currentRotation,
            rolling: true,
          )
        else // on ne touche pas aux autres dés        
          state[i]
    ];
  }
}
