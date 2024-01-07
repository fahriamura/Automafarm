class MealsListData {
  MealsListData({

    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });


  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;
  static int getTotalKacl() {
    int total = 0;
    for (var item in tabIconsList) {
      total += item.kacl;
    }
    return total;
  }

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(

      titleTxt: 'Breakfast',
      kacl: 525,
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),

  ];
}
