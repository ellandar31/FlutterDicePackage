
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dice_controller.dart';

/// Widget permettant l'affichage du résultat du lancé
class DicesResult extends StatelessWidget {
  
  /// constructeur
  const DicesResult({super.key,});

  @override
  Widget build(BuildContext context) {

    // Obtenir le contrôleur de GetX
    final diceController = Get.find<DiceController>();

    //construction du Widget de résulat en ligne 
    return Obx(() => Row(
          children: [
            for (int i = 0; i < diceController.dices.length; i++) ...[
              //affichage uniquement des dés qui sont sélectionné et sont au repos 
              if(!diceController.dices[i].rolling & diceController.dices[i].isSelected)
                diceController.dices[i].getMinDice(),  // affichage en mode miniature        
            ]
          ],
        ));
  }
}