import 'package:autofarm/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'flutter_login.dart';


void main() {
  runApp(const MyApp());
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

      home: SplashScreen(),
      routes: {
        '/SplashScreen':(context) =>SplashScreen(),
        '/login': (context) => LoginScreen(),
      },



    );
  }
}
