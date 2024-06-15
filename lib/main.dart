import 'package:autofarm/SplashScreen.dart';
import 'package:autofarm/mainpage/fitness_app/MainHomeScreen.dart';
import 'package:autofarm/mainpage/fitness_app/my_diary/my_diary_screen.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/CardList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flutter_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'mainpage/fitness_app/my_diary/cardview.dart';
import 'appConfig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppConfig()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Automafarm',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.blue,
        useMaterial3: true,
      ),

      home: LoginScreen(),
      routes: {
        '/SplashScreen':(context) =>SplashScreen(),
        '/login': (context) => LoginScreen(),
      },



    );
  }
}
