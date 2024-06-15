import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../GetColor.dart';
import '../HomeScreenTheme.dart';
import '../models/Activity_List_Data.dart';
import '../models/kandang.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserView extends StatefulWidget {
  final int userID;
  const UserView({
    Key? key,
    this.animationController,
    required this.userID,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late List<UserData> userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animationController.forward();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      UserData? user = await AuthApi.getUserById(widget.userID);
      if (user != null) {
        setState(() {
          userData = [user];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Failed to load user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: animationController,
              child: Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  30 * (1.0 - animationController.value),
                  0.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(1.0),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.4),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  userData.isNotEmpty ? userData[0].name : '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
      children: <Widget>[
        getAppBarUI(),
        Expanded(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animationController,
                child: Transform(
                  transform: Matrix4.translationValues(
                    0.0,
                    30 * (1.0 - animationController.value),
                    0.0,
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(userData.length, (index) {
                          final Animation<double> animation = Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / userData.length) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          return UserViews(
                            userData: userData[index],
                            animation: animation,
                            animationController: animationController,
                            userID: widget.userID,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Future<int> jumlahKandang(int userID) async {
  try {
    final response = await http.get(Uri.parse('http://192.168.43.83:8000/api/kandang/$userID'));
    if (response.statusCode == 200) {
      List<dynamic> kandangList = jsonDecode(response.body)['list'];
      return kandangList.length;
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

class UserViews extends StatelessWidget {
  const UserViews({
    Key? key,
    required this.userData,
    required this.userID,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final UserData userData;
  final int userID;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: jumlahKandang(userID),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          final int kandang = snapshot.data ?? 0;
          return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                100 * (1.0 - animation.value),
                0.0,
                0.0,
              ),
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        margin: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: HexColor("#d9bda5").withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0,
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor("#d9bda5"),
                              HexColor("#f6eee3"),
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
                            top: 16,
                            left: 16,
                            right: 16,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              // Profile Picture
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: userData.profilePicture != null
                                    ?
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                userData.profilePicture!,
                                fit: BoxFit.cover,
                                ),
                                )
                                    :
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/sayang.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                ),
                              SizedBox(width: 16), // Spacer

                              // Text Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Water: ${userData.jumlahAir}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Total Food : ${userData.jumlahPakan}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16), // Spacer

                              // Total Poultry Info
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Poultry',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$kandang',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Adjust this value as needed
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Share precious moments here',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    // Grid List
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                      child: Container(
                        height: 400,
                        child: Stack(
                          children: [
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: 10, // Total item count
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black, // Customize container style
                                  ),
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16, bottom: 50),
                                child: FloatingActionButton(
                                  onPressed: () {
                                    // Action when the button is pressed
                                  },
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
