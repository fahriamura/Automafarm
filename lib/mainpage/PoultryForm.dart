import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PoultryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('Ini adalah halaman selanjutnya setelah menekan Add Activity.'),
      ),
    );
  }
}
