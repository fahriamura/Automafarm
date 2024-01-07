import 'package:autofarm/mainpage/design_course/home_design_course.dart';
import 'package:autofarm/mainpage/fitness_app/fitness_app_home_screen.dart';
import 'package:autofarm/mainpage/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/introduction_animation/introduction_animation.png',
      navigateScreen: IntroductionAnimationScreen(),
    ),

    HomeList(
      imagePath: 'assets/fitness_app/fitness_app.png',
      navigateScreen: FitnessAppHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: DesignCourseHomeScreen(),
    ),
  ];
}
