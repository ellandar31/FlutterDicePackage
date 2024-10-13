import 'package:flutter/material.dart';
import 'package:start/guard/profile.dart';
import 'package:start/src/dicelib/dice_roller.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<bool> _isSelected = [false, false, false];
  DiceRoller redDice = DiceRoller(diceColor: Colors.red, displayBtn: true,);
  DiceRoller yellowDice = DiceRoller(diceColor: Colors.yellow, displayBtn: true,);
  DiceRoller purpleDice = DiceRoller(diceColor: Colors.purple, displayBtn: true,);

  void _launchDice() {
    if (_isSelected[0]) {
//      redDice.launchRoll(context);
    }
    if (_isSelected[1]) {
      //yellowDice.launchRoll(context);
    }
    if (_isSelected[2]) {
      //purpleDice.launchRoll(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              signOutMethod(context);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      //TODO change for your content 
      body:  Column(
        children: [
          Row(
            children: [
              SizedBox(height: 20),
              redDice,
              SizedBox(height: 20),
              yellowDice,
              SizedBox(height: 20),
              purpleDice,              
            ],
          ),
         /* ElevatedButton(
            onPressed: _launchDice,
            child: Text("Roll Selected Dice"),
          ),*/
        ],
      ),
    );
  }
}
