import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/dice_state.dart'; 

/// Widget contenant la liste des dés (selon la liste de couleurs donnée en entré) ainsi que les boutons pour lancer/sélectionner les dés
class MultiDice extends ConsumerStatefulWidget {
  /// Liste de couleur utilisé pour initialisé les dés 
  final List<Color> myColors;
  /// constructeur
  const MultiDice(this.myColors, {super.key,});

  @override
  _MultiDiceState createState() => _MultiDiceState();
}

/// Gestion du state du widget MultiDice
class _MultiDiceState extends ConsumerState<MultiDice> {
  bool _initialized = false;

  @override
  /// initialise le state avec la liste des couleurs en entré (uniquement si l'instance n'est pas déjà initialisée)
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ajoute les dés une seule fois après la construction initiale du widget
      if (!_initialized) {
        ref.read(diceProvider.notifier).initDices(widget.myColors);
        _initialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final diceList = ref.watch(diceProvider); // Récupérer la liste des dés

    return Column(
      children: [
        DicesDisplay(diceList: diceList, ref: ref,),
      ],
    );
  }
}

/// Affichage des dés et des boutons permettant de lancer les dés (un ou plusieurs)
class DicesDisplay extends StatelessWidget {
  /// constructeur
  const DicesDisplay({
    super.key,
    required this.diceList,
    required this.ref,
  });

  /// Liste des dés 
  final List<DiceState> diceList;
  /// Widget de référence
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // bouton permettant de lancer tous les dés sélectionnés (uniquement si =>2 dés)
        if(diceList.length>1) ElevatedButton(
          onPressed: () => ref.read(diceProvider.notifier).launchSelectedRoll(),
          child: const Text('Lancer tous les dés sélectionnés'),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (int i = 0; i < diceList.length; i++) ...[
              GestureDetector(
                // un clic ou une touche sur le dé permet de le sélectionné
                onTap: () => ref.read(diceProvider.notifier).toggleSelection(i),
                child: Column(
                  children: [
                    // Checkbox de sélection d'un dé
                    if(diceList.length>1) Checkbox(
                      value: diceList[i].isSelected,
                      onChanged: (bool? value) => ref.read(diceProvider.notifier).toggleSelection(i),
                      
                    ),
                    // bouton de lancement d'un dé (uniquement s'il est seul dans la liste)
                    if(diceList.length==1) ElevatedButton(
                      onPressed: () => ref.read(diceProvider.notifier).launchRoll(i),
                      child: const Text('Lancer'),
                    ),
                    const SizedBox(height: 10),
                    diceList[i].getFullDice(),
                  ],
                ),
              ),
            ]
          ],
        )
      ]
    );
  }
}
