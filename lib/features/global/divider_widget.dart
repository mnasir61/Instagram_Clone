


import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .25,
      width: MediaQuery.of(context).size.width,
      color: Styles.colorGray1.withOpacity(.5),
    );
  }
}
