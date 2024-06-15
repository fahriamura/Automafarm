import 'dart:convert';
import 'package:autofarm/mainpage/fitness_app/ui_view/EditDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:autofarm/ActivityList/ActivityList.dart';
import 'package:autofarm/mainpage/PoultryForm.dart';
import 'package:autofarm/mainpage/fitness_app/models/kandang.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/FeedingDialog.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/WateringDialog.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/foodMeasurement.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/glass_view.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/mediterranean_diet_view.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/title_view.dart';
import 'package:autofarm/mainpage/fitness_app/HomeScreenTheme.dart';
import 'package:autofarm/mainpage/fitness_app/my_diary/ActivityListView.dart';
import 'package:autofarm/mainpage/fitness_app/my_diary/water_view.dart';

import '../../../appConfig.dart';
import '../MainHomeScreen.dart';
import '../models/Activity_List_Data.dart';
import '../ui_view/CardList.dart';
import 'cardview.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({Key? key, this.animationController, required this.userID}) : super(key: key);
  final int userID;
  final AnimationController? animationController;

  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? topBarAnimation;
  List<Widget> listViews = <Widget>[];
  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  int currentPoultryIndex = 0;
  late Future<List<PoultryData>> poultryDataList;
  List<PoultryData> poultryList = [];

  @override
  void initState() {
    super.initState();

    animationController = widget.animationController;
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
    poultryDataList = PoultryData.fetchPoultryData(context,widget.userID);
    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 && scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
  }


  void addAllListData() {
    const int count = 9;

    listViews = [
      TitleView(
        titleTxt: 'Poultry Farm Statistic',
        subTxt: 'Edit Poultry',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        onTap: () async {
          await InputPoultryDialog.show(
            context: context,
            title: 'Add Update',
            okText: 'OK',
            UserID: widget.userID,
            namakandang: poultryList[currentPoultryIndex].namaKandang,
            cancelText: 'Cancel',
            onOkPressed: () {
              setState(() {
                tabBody = MyDiaryScreen(animationController: animationController, userID: widget.userID);
              });
            },
          );
        },
      ),
      MediterranesnDietView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,

      ),
      TitleView(
        titleTxt: 'Activity History',
        subTxt: 'More History',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardList(userID: widget.userID)),
          );
        },
      ),
      ActivityListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        userID: widget.userID,
      ),
      TitleView(
        titleTxt: 'Food Detail',
        subTxt: 'Give Food',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        onTap: () async {
          await InputFeedingDialog.show(
            context: context,
            title: 'How Much Gram?',
            okText: 'OK',
            UserID: widget.userID,
            namakandang: poultryList[currentPoultryIndex].namaKandang,
            cancelText: 'Cancel',
            onOkPressed: () {
              setState(() {
                tabBody = MyDiaryScreen(animationController: animationController, userID: widget.userID);
              });
            },
          );
        },
      ),
      foodMeasuerementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        UserID: widget.userID,
      ),
      TitleView(
        titleTxt: 'Water Detail',
        subTxt: 'Give Water',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        onTap: () async {
          await InputWateringDialog.show(
            context: context,
            title: 'How Much Liter?',
            okText: 'OK',
            UserID: widget.userID,
            namakandang: poultryList[currentPoultryIndex].namaKandang,
            cancelText: 'Cancel',
            onOkPressed: () {
              setState(() {
                tabBody = MyDiaryScreen(animationController: animationController, userID: widget.userID);
              });
            },
          );
        },
      ),
      WaterView(
        UserID: widget.userID,
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 7, 1.0, curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
      ),
      GlassView(
        animation: Tween<double>(begin: 0.0,
            end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 8, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    addAllListData();
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
      body: FutureBuilder<List<PoultryData>>(
        future: poultryDataList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            poultryList = snapshot.data!;
            return Stack(
              children: <Widget>[
                getMainListViewUI(),
                getAppBarUI(poultryList[currentPoultryIndex]),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget getMainListViewUI() {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController?.forward();
        return listViews[index];
      },
    );
  }

  Widget getAppBarUI(PoultryData poultry) {
    print('ayam 10 ${poultryList[0].kandangID}');
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.4 * topBarOpacity),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16 - 8.0 * topBarOpacity,
                          bottom: 12 - 8.0 * topBarOpacity,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                if (currentPoultryIndex > 0) {
                                  setState(() {
                                    currentPoultryIndex--;
                                    addAllListData(); // Refresh the list data
                                  });
                                } else {
// Handle case where pressing arrow back is not allowed
                                }
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      poultry.namaKandang,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22 + 6 - 6 * topBarOpacity,
                                        letterSpacing: 1.2,
                                        color: FitnessAppTheme.darkerText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                if (currentPoultryIndex < poultryList.length - 1) {
                                  setState(() {
                                    currentPoultryIndex++;
                                    addAllListData(); // Refresh the list data
                                  });
                                } else {
// Handle case where pressing arrow forward is not allowed
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
