import 'package:autofarm/mainpage/fitness_app/models/Activity_List_Data.dart';
class ActivityCard {
  ActivityCard({
    this.name = '',
    this.liter=0,
    this.Time='',
    this.gram = 0,
  });
  String name,Time;
  int liter,gram;


  static List<ActivityCard> activity = ActivityListData.tabIconsList.map((data) {
    return ActivityCard(
      name: data.titleTxt,
      gram: data.gram,
      Time: data.Time,
      liter: data.liter,
    );
  }).toList();
}