import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/res/colours.dart';
import 'package:ttd_firebase_educational/core/res/fonts.dart';
import 'package:ttd_firebase_educational/core/services/injection_container.dart';
import 'package:ttd_firebase_educational/core/services/router.dart';
import 'package:ttd_firebase_educational/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: Fonts.poppins,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          color: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
