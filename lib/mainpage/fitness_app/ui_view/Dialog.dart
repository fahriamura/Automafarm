import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dialogView(BuildContext context, bool isShowDialog) {
  return Scaffold(
    body: Stack(
      children: <Widget>[

        if (isShowDialog)
          Center(
            child: Container(
              width: 300,
              height: 200,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ini adalah kotak dialog'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk submit
                    },
                    child: Text('Submit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                        isShowDialog = false;
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}