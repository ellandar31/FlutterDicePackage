import 'package:flutter/material.dart';
import 'dice_roller.dart';

class MultiDice extends StatefulWidget {
  final List<Color> diceColors;

  const MultiDice({super.key, required this.diceColors});

  @override
  State<MultiDice> createState() => _MultiDiceState();
}

class _MultiDiceState extends State<MultiDice> {
  late List<GlobalKey<DiceRollerState>> dicesKey;
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    dicesKey = List.generate(
        widget.diceColors.length, (index) => GlobalKey<DiceRollerState>());
    _isSelected = List.generate(widget.diceColors.length, (index) => false);
  }

  void _launchDice() {
    _isSelected.asMap().forEach((index, isSelected) {
      if (isSelected) {
        dicesKey[index].currentState?.launchRoll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Nombre de colonnes
                childAspectRatio:
                    1, // Rapport entre la largeur et la hauteur des éléments
                crossAxisSpacing: 1.0, // Espace horizontal entre les éléments
                mainAxisSpacing: 5.0, // Espace vertical entre les lignes
              ),
              itemCount: widget.diceColors.length,
              itemBuilder: (context, index) {
                return checkboxAndDice(index, widget.diceColors[index]);
              }),
        ),
        ElevatedButton(
          onPressed: _launchDice,
          child: Text("Lancer les dès sélectionnés"),
        ),
      ],
    );
  }

  Column checkboxAndDice(int index, Color couleur) {
    return Column(
      children: [
        Checkbox(
          value: _isSelected[index],
          onChanged: (bool? value) {
            setState(() {
              _isSelected[index] = value ?? false;
            });
          },
        ),
        DiceRoller(
          key: dicesKey[index],
          diceColor: couleur,
          displayBtn: false,
        ),
      ],
    );
  }
}
