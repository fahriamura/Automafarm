import 'package:autofarm/mainpage/fitness_app/HomeScreenTheme.dart';
import 'package:autofarm/mainpage/fitness_app/models/Activity_List_Data.dart';
import 'package:flutter/material.dart';

import '../../GetColor.dart';

class ActivityListView extends StatefulWidget {
  const ActivityListView({
    Key? key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
    required this.userID,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final int userID;

  @override
  _ActivityListViewState createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _fetchDataFuture = ActivityListData.fetchActivities(widget.userID);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: FutureBuilder<void>(
                future: _fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching activities'));
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, right: 16, left: 16),
                      itemCount: ActivityListData.tabIconsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final int count =
                        ActivityListData.tabIconsList.length > 10
                            ? 10
                            : ActivityListData.tabIconsList.length;
                        final Animation<double> animation = Tween<double>(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(
                          CurvedAnimation(
                            parent: animationController!,
                            curve: Interval(
                              (1 / count) * index,
                              1.0,
                              curve: Curves.fastOutSlowIn,
                            ),
                          ),
                        );
                        animationController?.forward();

                        return ActivityView(
                          activityListData: ActivityListData.tabIconsList[index],
                          animation: animation,
                          animationController: animationController!,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class ActivityView extends StatelessWidget {
  const ActivityView({
    Key? key,
    this.activityListData,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final ActivityListData? activityListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(activityListData!.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(activityListData!.startColor),
                            HexColor(activityListData!.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 54, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              activityListData!.titleTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      activityListData!.Time.replaceFirst(' ', '\n'),
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 0.2,
                                        color: FitnessAppTheme.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            activityListData?.gram != 0
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  activityListData!.gram.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    letterSpacing: 0.2,
                                    color: FitnessAppTheme.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 3),
                                  child: Text(
                                    'gram',
                                    style: TextStyle(
                                      fontFamily:
                                      FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      letterSpacing: 0.2,
                                      color: FitnessAppTheme.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  activityListData!.liter.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    letterSpacing: 0.2,
                                    color: FitnessAppTheme.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 3),
                                  child: Text(
                                    'liter',
                                    style: TextStyle(
                                      fontFamily:
                                      FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      letterSpacing: 0.2,
                                      color: FitnessAppTheme.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
