import 'package:autofarm/mainpage/fitness_app/MainHomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:autofarm/mainpage/fitness_app/models/Activity_List_Data.dart';
import 'package:intl/intl.dart';

import '../HomeScreenTheme.dart';
import '../my_diary/my_diary_screen.dart';

const _defaultCancelText = 'Cancel';
const _defaultOkText = 'OK';
const _defaultTitle = 'Enter Text';
DateTime now = DateTime.now();

class InputPoultryDialog extends StatefulWidget {
  final String cancelText;
  final String okText;
  final String title;
  final int UserID;
  final String namakandang;
  final Function(int, int) createActivityPoultryListData;

  const InputPoultryDialog({
    Key? key,
    this.cancelText = _defaultCancelText,
    this.okText = _defaultOkText,
    this.title = _defaultTitle,
    required this.namakandang,
    required this.createActivityPoultryListData,
    required this.UserID,
  }) : super(key: key);

  static Future<String?> show({
    required BuildContext context,
    String cancelText = _defaultCancelText,
    String okText = _defaultOkText,
    String title = _defaultTitle,
    required int UserID,
    required String namakandang,
    required VoidCallback onOkPressed,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => InputPoultryDialog(
        cancelText: cancelText,
        okText: okText,
        title: title,
        UserID: UserID,
        namakandang: namakandang,
        createActivityPoultryListData: (foodValue, waterValue) async {
          ActivityListData newData = ActivityListData(
            aktivitasID: UserID,
            titleTxt: 'Poultry',
            gram: foodValue,
            liter: waterValue,
            Time: DateFormat('kk:mm:ss \n EEE d MMM').format(now).toString(),
            startColor: '#FA7D82',
            endColor: '#FFB295',
          );
          await ActivityListData.postFood(namakandang, foodValue.toDouble());
          await ActivityListData.postWater(namakandang, waterValue.toDouble());
          onOkPressed();
        },
      ),
    );
  }

  @override
  State<InputPoultryDialog> createState() => _InputPoultryDialogState();
}

class _InputPoultryDialogState extends State<InputPoultryDialog> {
  final _foodController = TextEditingController();
  final _waterController = TextEditingController();
  AnimationController? animationController;
  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _foodController,
            decoration: InputDecoration(labelText: 'Total Food'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _waterController,
            decoration: InputDecoration(labelText: 'Total Water'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(widget.cancelText),
        ),
        ElevatedButton(
          onPressed: _ok,
          child: Text(widget.okText),
        ),
      ],
    );
  }

  void _ok() {
    int foodValue = int.tryParse(_foodController.text) ?? 0;
    int waterValue = int.tryParse(_waterController.text) ?? 0;
    widget.createActivityPoultryListData(foodValue, waterValue);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainHomeScreen(userID: widget.UserID),
      ),
    );
  }

  @override
  void dispose() {
    _foodController.dispose();
    _waterController.dispose();
    super.dispose();
  }
}
