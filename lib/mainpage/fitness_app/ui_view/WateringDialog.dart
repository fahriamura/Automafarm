import 'package:autofarm/mainpage/fitness_app/MainHomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:autofarm/mainpage/fitness_app/models/Activity_List_Data.dart';
import 'package:intl/intl.dart';

import '../HomeScreenTheme.dart';
import '../my_diary/my_diary_screen.dart';
import 'FeedingDialog.dart';
const _defaultCancelText = 'Cancel';
const _defaultOkText = 'OK';
const _defaultTitle = 'Enter Text';
class InputWateringDialog extends StatefulWidget {

  final String cancelText;


  final String okText;


  final String title;

  final Function(int) createActivityWateringListData;

  const InputWateringDialog({
    Key? key,
    this.cancelText = _defaultCancelText,
    this.okText = _defaultOkText,
    this.title = _defaultTitle,
    required this.createActivityWateringListData,
  }) :  super(key : key);


  static Future<String?> show({
    required BuildContext context,
    String cancelText = _defaultCancelText,
    String okText = _defaultOkText,
    String title = _defaultTitle,
    required VoidCallback onOkPressed


  }) async {
    return showDialog(
      context: context,
      builder: (_) => InputWateringDialog(
        cancelText: cancelText,
        okText: okText,
        title: title,
        createActivityWateringListData: (value) {
          ActivityListData newData = ActivityListData(
            titleTxt: 'Watering',
            liter: value,
            Time: DateFormat('kk:mm:ss \n EEE d MMM').format(now).toString(),
            startColor: '#0000FF',
            endColor: '#1E90FF',
          );
          ActivityListData.tabIconsList.add(newData);
          onOkPressed();
        },

      ),
    );
  }

  @override
  State<InputWateringDialog> createState() => _InputWateringDialogState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('cancelText', cancelText));
    properties.add(StringProperty('okText', okText));
    properties.add(StringProperty('title', title));
  }
}

class _InputWateringDialogState extends State<InputWateringDialog> {
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
            setState(() {
              Navigator.pop(context);
            });
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
    int liter = int.tryParse(_controller.text) ?? 0;
    widget.createActivityWateringListData(liter);
    setState(() {
      tabBody =
          MyDiaryScreen(animationController: animationController);
    });
    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => MainHomeScreen()));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}