import 'package:autofarm/flutter_login.dart';
import 'package:autofarm/mainpage/PoultryForm.dart';
import 'package:autofarm/mainpage/fitness_app/models/tabIcon_data.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/UserAdapter.dart';
import 'package:autofarm/mainpage/fitness_app/ui_view/nearbyadapter.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'HomeScreenTheme.dart';
import 'my_diary/my_diary_screen.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
  final int userID;
  MainHomeScreen({required this.userID});
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    print(widget.userID);

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController, userID : widget.userID);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PoultryForm(userID: widget.userID,)));
          },
          changeIndex: (int index) {
            if (index == 0 ){
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainHomeScreen(userID: widget.userID,)));
                }
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainHomeScreen(userID: widget.userID,)));
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => PoultryForm(userID: widget.userID,)));
              });
            }
            else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => NearbyAdapter(UserID: widget.userID)));
              });
            }
            else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserAdapter(UserID: widget.userID)));
              });
            }
          },
        ),
      ],
    );
  }
}
