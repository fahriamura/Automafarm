import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabIconData {
  TabIconData({
    this.iconData = FontAwesomeIcons.home,
    this.selectedIconData = FontAwesomeIcons.home,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  IconData iconData;
  IconData selectedIconData;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      iconData: FontAwesomeIcons.arrowLeft,
      selectedIconData: FontAwesomeIcons.arrowLeft,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      iconData: FontAwesomeIcons.search,
      selectedIconData: FontAwesomeIcons.search,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: FontAwesomeIcons.circle,
      selectedIconData: FontAwesomeIcons.circle,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: FontAwesomeIcons.user,
      selectedIconData: FontAwesomeIcons.user,
      index: 3,
      isSelected: false,
      animationController: null,
    ),

  ];
}
