import 'package:autofarm/mainpage/fitness_app/HomeScreenTheme.dart';
import 'package:autofarm/mainpage/fitness_app/models/Activity_List_Data.dart';
import 'package:flutter/material.dart';

class foodMeasuerementView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int UserID;

  const foodMeasuerementView({
    Key? key,
    this.animationController,
    this.animation,
    required this.UserID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ActivityListData.fetchActivities(UserID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching activities'));
        } else if (ActivityListData.tabIconsList.isEmpty) {
          return Center(child: Text('No activities available'));
        } else {
          int FoodTotal = ActivityListData.getTotalGram(ActivityListData.tabIconsList);
          int maxFood = 2000;
          int FoodLeft = maxFood - FoodTotal;
          ActivityListData lastFeedingActivity = ActivityListData.tabIconsList
              .where((activity) => activity.titleTxt == 'Feeding')
              .last;
          String lastFeedingTime = lastFeedingActivity.Time;

          return AnimatedBuilder(
            animation: animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                    0.0,
                    30 * (1.0 - animation!.value),
                    0.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: FitnessAppTheme.grey.withOpacity(0.2),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, bottom: 8, top: 16),
                                  child: Text(
                                    'Food Used',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.1,
                                      color: FitnessAppTheme.darkText,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4, bottom: 3),
                                          child: Text(
                                            '$FoodTotal',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 32,
                                              color: FitnessAppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                                          child: Text(
                                            'Gram',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              letterSpacing: -0.2,
                                              color: FitnessAppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              color: FitnessAppTheme.grey.withOpacity(0.5),
                                              size: 16,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                'Last Feeding $lastFeedingTime',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 8,
                                                  letterSpacing: 0.0,
                                                  color: FitnessAppTheme.grey.withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4, bottom: 14),
                                          child: Text(
                                            '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.nearlyDarkBlue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: FitnessAppTheme.background,
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '$maxFood gram',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.darkText,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'Max Food',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: FitnessAppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '$FoodLeft gram',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.2,
                                              color: FitnessAppTheme.darkText,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: Text(
                                              'Food Left',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: FitnessAppTheme.grey.withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            '${((FoodTotal / 2000) * 100).toInt()}%',
                                            style: TextStyle(
                                              fontFamily: FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.2,
                                              color: FitnessAppTheme.darkText,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6),
                                            child: Text(
                                              'Food Used',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: FitnessAppTheme.grey.withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
