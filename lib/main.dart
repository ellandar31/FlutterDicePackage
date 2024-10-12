import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start/guard/profile.dart';
import 'package:start/src/home.dart';
import 'package:start/utilitaires/decorations.dart';

import 'firebase_options.dart';
import 'guard/auth_gate.dart';

final actionCodeSettings = ActionCodeSettings(
  url: 'https://gamingportal-1345c.web.app/',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  String get initialRoute {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return '/';
    }
    return '/home';
  }
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mfaAction = AuthStateChangeAction<MFARequired>(
      (context, state) async {
        final nav = Navigator.of(context);
        await startMFAVerification(
          resolver: state.resolver,
          context: context,
        );
        nav.pushReplacementNamed('/home');
      },
    );

    return ChangeNotifierProvider(
      create: (BuildContext context) {  },
      child: MaterialApp(
          title: 'Gaming Portal',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: initialRoute,
          routes: {
            '/': (context) {
              return AuthGate();
            },
            '/forgot-password': (context) {
              final arguments = ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;

              return ForgotPasswordScreen(
                email: arguments?['email'],
                headerMaxExtent: 200,
                headerBuilder: headerIcon(Icons.lock),
                sideBuilder: sideIcon(Icons.lock),
              );
            },           
            '/profile': (context) {
              return ProfilePage(true);
            },        
            '/home': (context) {
              return HomeScreen();
            },
          }),
    );
  }
}

