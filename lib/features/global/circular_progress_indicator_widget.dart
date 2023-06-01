

import 'package:flutter/material.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final Color? color;
  const CircularProgressIndicatorWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: color),
      ),
    );
  }
}
