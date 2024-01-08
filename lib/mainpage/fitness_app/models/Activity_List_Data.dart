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

  ];
}
