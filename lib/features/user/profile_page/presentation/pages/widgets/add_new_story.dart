

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class AddNewStory extends StatelessWidget {
  const AddNewStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1),
          ),
          child: Icon(FontAwesomeIcons.plus),

        ),
        verticalSize(10),
        Text(
          "New",
          style: Styles.titleLine2.copyWith(
            color: Styles.colorBlack,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
