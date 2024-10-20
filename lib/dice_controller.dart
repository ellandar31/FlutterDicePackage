
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/dice_state.dart';

class DiceController extends GetxController {
  var dices = <DiceState>[].obs; /// Liste observable de dés
  Random random = Random();
  var dealer = RxBool(false); /// indique si le lancé est faite par le joueur courant

  /// Ajouter un dé avec une couleur spécifique
  void addDice(Color color) {
    dices.add(DiceState.initial(color));
  }

  /// Initialiser plusieurs dés avec une liste de couleurs
  void initDices(List<Color> colors) {
    dealer.value = true;
    dices.value = colors.map((color) => DiceState.initial(color)).toList();
  }

  /// Lancer le dé à l'index spécifié
  void launchRoll(int index) {
    if (index < 0 || index >= dices.length) return;

    var dice = dices[index];
    dices[index] = DiceState(
      isSelected: true,
      curColor: dice.curColor,
      number: dice.number,
      currentRotation: dice.currentRotation,
      rolling: true,
    );

    int counter = 1;

    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      counter++;
      dice = dices[index];
      dices[index] = DiceState(
        isSelected: dice.isSelected,
        curColor: dice.curColor,
        number: random.nextInt(6) + 1,
        currentRotation: random.nextDouble(),
        rolling: true,
      );

      if (counter >= 13) {
        timer.cancel();
        dices[index] = DiceState(
          isSelected: dice.isSelected,
          curColor: dice.curColor,
          number: dice.number,
          currentRotation: 0,
          rolling: false,
        );
      }
    });
  }

  /// Lancer tous les dés sélectionnés
  void launchSelectedRoll() {
    for (int i = 0; i < dices.length; i++) {
      if (dices[i].isSelected) {
        launchRoll(i);
      }
    }
  }

  void setResult(List<DiceResult> dicesArg) {
    // Test si la liste des dés d'arguments est plus grande que la liste de dés d'origine
    if (dicesArg.isEmpty || dicesArg.length > dices.length) {
      return; // Erreur d'actualisation ou désynchro
    }
    
    dealer.value = false;

    // Créer une copie de dicesArg pour le parcourir
    List<DiceResult> remainingDiceArgs = List.from(dicesArg);

    for (int index = 0; index < dices.length; index++) {
      // Trouver la première couleur dans diceArgs qui correspond au dé courant
      int matchingIndex = remainingDiceArgs.indexWhere(
        (diceArg) => diceArg.curColor == dices[index].curColor,
      );
      
      if (matchingIndex != -1) {
        // Mettre à jour le dé correspondant
        dices[index] = DiceState(
          isSelected: true,
          curColor: remainingDiceArgs[matchingIndex].curColor,
          number: remainingDiceArgs[matchingIndex].number,
          currentRotation: 0,
          rolling: false,
        );
        // Supprimer cette valeur de la liste restante pour ne pas la réutiliser
        remainingDiceArgs.removeAt(matchingIndex);
      }
    }
  }

  /// retourne le résultat du lancé
  List<DiceResult> getResult(){
    List<DiceResult> result = [];
    for (int index = 0; index < dices.length; index++) {
      if(dices[index].isSelected){
        result.add(DiceResult(curColor: dices[index].curColor, number: dices[index].number));
      }
    }
    return result; 
  }

  /// Sélectionner/Désélectionner un dé
  void toggleSelection(int index) {
    if (index < 0 || index >= dices.length) return;

    var dice = dices[index];
    dices[index] = DiceState(
      isSelected: !dice.isSelected,
      curColor: dice.curColor,
      number: dice.number,
      currentRotation: dice.currentRotation,
      rolling: true,
    );
  }

}

/// classe permettant de manipuler les résultats d'un lancé
class DiceResult {
  final Color curColor; 
  final int number;

  DiceResult({required this.curColor, required this.number});
}