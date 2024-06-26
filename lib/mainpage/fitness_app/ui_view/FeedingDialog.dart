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

class InputFeedingDialog extends StatefulWidget {
  final String cancelText;
  final String okText;
  final String title;
  final int UserID;
  final String namakandang;
  final Function(int) createActivityFeedingListData;

  const InputFeedingDialog({
    Key? key,
    this.cancelText = _defaultCancelText,
    this.okText = _defaultOkText,
    this.title = _defaultTitle,
    required this.namakandang,
    required this.createActivityFeedingListData,
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
      builder: (_) => InputFeedingDialog(
        cancelText: cancelText,
        okText: okText,
        title: title,
        UserID: UserID,
        namakandang: namakandang,
        createActivityFeedingListData: (value) async {
          ActivityListData newData = ActivityListData(
            aktivitasID: UserID,
            titleTxt: 'Feeding',
            gram: value,
            Time: DateFormat('kk:mm:ss \n EEE d MMM').format(now).toString(),
            startColor: '#FA7D82',
            endColor: '#FFB295',
          );
          await ActivityListData.subFood(namakandang, value.toDouble());
          onOkPressed();
        },
      ),
    );
  }

  @override
  State<InputFeedingDialog> createState() => _InputFeedingDialogState();
}

class _InputFeedingDialogState extends State<InputFeedingDialog> {
  final _controller = TextEditingController();
  AnimationController? animationController;
  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        onSubmitted: (_) => _ok(),
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
    int gram = int.tryParse(_controller.text) ?? 0;
    widget.createActivityFeedingListData(gram);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainHomeScreen(userID: widget.UserID),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
