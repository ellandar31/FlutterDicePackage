
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/dice_state.dart';

class DiceController extends GetxController {
  var dices = <DiceState>[].obs; // Liste observable de dés
  Random random = Random();

  /// Ajouter un dé avec une couleur spécifique
  void addDice(Color color) {
    dices.add(DiceState.initial(color));
  }

  /// Initialiser plusieurs dés avec une liste de couleurs
  void initDices(List<Color> colors) {
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