
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';


class ViewStoryWidget extends StatelessWidget {
  final String imageUrl;
  final String username;

  const ViewStoryWidget({required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.5, color: Colors.transparent),
            gradient: LinearGradient(
              colors: [
                Color(0xFF405DE6),
                Color(0xFF5851DB),
                Color(0xFF833AB4),
                Color(0xFFC13584),
                Color(0xFFE1306C),
                Color(0xFFFF6D00),
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(3),
              child: Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.colorWhite,
                ),
                child: ClipOval(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          username.length > 12 ? username.substring(0, 12) + "..." : username,
          style: Styles.titleLine2.copyWith(
            color: Styles.colorBlack,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
