
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/dice_state.dart';

/// Widget permettant l'affichage du résultat du lancé
class DicesResult extends ConsumerWidget {
  
  /// constructeur
  const DicesResult({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final diceList = ref.watch(diceProvider); // le watch est nécessaire pour étre prévenu des changements d'états

    //construction du Widget de résulat en ligne 
    return Row(
          children: [
            for (int i = 0; i < diceList.length; i++) ...[
              //affichage uniquement des dés qui sont sélectionné et sont au repos 
              if(!diceList[i].rolling & diceList[i].isSelected)
                diceList[i].getMinDice(),  // affichage en mode minniature        
            ]
          ],
        );
  }
}