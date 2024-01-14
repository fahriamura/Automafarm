import 'dart:developer';

import 'package:intl/intl.dart';

class ActivityListData {
  ActivityListData({

    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.Time='',
    this.gram = 0,
    this.liter=0,
  });


  String titleTxt;
  String startColor;
  String endColor;
  String Time;
  int gram;
  int liter;
  static int getTotalGram() {
    int total = 0;
    for (var item in tabIconsList) {
      total += item.gram;
    }
    return total;
  }

  static int getTotalLiter(){
    int total = 0;
    for (var item in tabIconsList) {
      total += item.liter;
    }
    return total;

  }

  static List<ActivityListData> tabIconsList = <ActivityListData>[
    ActivityListData(

      titleTxt: 'Feeding',
      gram: 525,
      Time:"8.30",
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),

    ActivityListData(

      titleTxt: 'Watering',
      liter: 1225,
      Time:"8.30",
      startColor: '#0000FF',
      endColor: '#1E90FF',
    ),

  ];
}


void createActivityFeedingListData(int gram) {
  DateTime now = DateTime.now();
  // Create a new ActivityListData object using the submitted text
  ActivityListData newData = ActivityListData(
    titleTxt: 'Feeding',
    gram: gram,
    Time: DateFormat('kk:mm:ss \n EEE d MMM').format(now).toString(),
    startColor: '#FA7D82',
    endColor:  '#FFB295',
  );

  ActivityListData.tabIconsList.add(newData);

}

void createActivityWateringListData(int liter) {
  DateTime now = DateTime.now();
  log(DateFormat('kk:mm:ss \n EEE d MMM').format(now).toString());
  ActivityListData newData = ActivityListData(
    titleTxt: 'Watering',
    liter: liter,
    Time: DateFormat('kk:mm:ss \n EEE d MMM').format(now).toString(),
    startColor: '#0000FF',
    endColor:  '#1E90FF',
  );

  ActivityListData.tabIconsList.add(newData);

}