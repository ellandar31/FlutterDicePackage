import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './svg_dices.dart';

class DiceRoller extends StatefulWidget {
  final Color diceColor;
  final bool displayBtn;
  const DiceRoller(
      {super.key, required this.diceColor, this.displayBtn = true});

  @override
  State<DiceRoller> createState() => DiceRollerState();
}

class DiceRollerState extends State<DiceRoller> {
  Random random = Random();
  int currentImageIndex = 0;
  double currentRotation = 0;
  int counter = 1;
  bool displayBtn = true;
  List<String> imagesTxt = [];
  Color buttonBGColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    displayBtn = widget.displayBtn;
    imagesTxt = [
      SvgDice(widget.diceColor, 1).createSVGString(),
      SvgDice(widget.diceColor, 2).createSVGString(),
      SvgDice(widget.diceColor, 3).createSVGString(),
      SvgDice(widget.diceColor, 4).createSVGString(),
      SvgDice(widget.diceColor, 5).createSVGString(),
      SvgDice(widget.diceColor, 6).createSVGString(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: currentRotation * 180,
            child: SvgPicture.string(
              imagesTxt[currentImageIndex],
              height: 60,
            ),
          ),
          const SizedBox(height: 10),
          if (displayBtn) rollButton(),
        ],
      ),
    );
  }

  ElevatedButton rollButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: buttonBGColor),
      onPressed: () async {
        // Rolling the dice
        launchRoll();
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Roll',
          style: TextStyle(fontSize: 26, color: Colors.black),
        ),
      ),
    );
  }

  void launchRoll() async {
    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      counter++;
      setState(() {
        currentImageIndex = random.nextInt(6);
        currentRotation = random.nextDouble();
      });

      if (counter >= 13) {
        timer.cancel();

        setState(() {
          currentRotation = 0;
          counter = 1;
        });
      }
    });
  }
}
