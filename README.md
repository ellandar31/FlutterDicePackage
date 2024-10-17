<div align="center">
<img src="doc/images/modal_view.png" alt="Mon logo" width="1000"/>
</div>

# FlutterDicePackage 
> Package for Dice display and launch 

[![language](https://img.shields.io/badge/language-flutter-blue)](#)
[![GitHub release](https://img.shields.io/github/v/release/ellandar31/FlutterDicePackage)](#)
[![GitHub release date](https://img.shields.io/github/release-date/ellandar31/FlutterDicePackage)](#)
[![GitHub last commit](https://img.shields.io/github/last-commit/ellandar31/FlutterDicePackage)](#)
[![Free](https://img.shields.io/badge/free_for_non_commercial_use-brightgreen)](#-license)

⭐ Star us on GitHub — it motivates us a lot!

## Table of Contents
- [About](#-about)
- [How to Build](#-how-to-build)
- [License](#-license)


## 🚀 About

The current package allows to include a Widget containing Dice (with given color) and to roll them. 
A specific Widget allow to display the result with a minimal form (number and colored cube). 
![dialog view](doc/images/result_view.png)

Two ways of using the Widget are present : direct inclusion or inclusion with a button oppening a dialog box. 
![Result](doc/images/modal_view.png)

The state is manager by Rivertop. 



## 📝 How to include

After adding the dependency :

```dart
import 'package:FlutterDiceLibrary/dice_package.dart';

   [...]
   Column(
      children: [
        ModalDiceLauncher(diceColors : [Colors.red, Colors.yellow, Colors.purple,  Colors.grey]), //inclusion via modal view
        DicesResult(), // display of result in minimal format 
      ]
   )
   [...]

```

Don't forget to include the riverpod ProviderScope on your App (runApp)

```dart

import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp())); // nécessaire pour l'utilisation de riverpod dans la gestion des états
}
```

## Release History

* 0.0.1
    * Work in progress

## Meta

Ellandar31
[https://github.com/ellandar31/FlutterDicePackage](https://github.com/ellandar31/FlutterDicePackage/)

## Contributing

1. Fork it (<https://github.com/ellandar31/FlutterDicePackage/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

## 📃 License

This product is distributed under an MIT license. See ``LICENSE.md`` for more information.
For non-commercial use, this product is available for free.

[Back to top](#top)