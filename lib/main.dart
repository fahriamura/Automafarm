import 'package:autofarm/SplashScreen.dart';
import 'package:autofarm/mainpage/fitness_app/fitness_app_home_screen.dart';
import 'package:autofarm/mainpage/fitness_app/my_diary/meals_list_view.dart';
import 'package:autofarm/mainpage/fitness_app/my_diary/my_diary_screen.dart';
import 'package:autofarm/mainpage/introduction_animation/introduction_animation_screen.dart';
import 'package:autofarm/mainpage/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'flutter_login.dart';
import 'package:autofarm/mainpage/home_screen.dart';

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
