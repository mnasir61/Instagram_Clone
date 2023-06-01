
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';


class StoryWidget extends StatelessWidget {
  final String imageUrl;
  final String username;

  const StoryWidget({required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: Styles.colorBlack.withOpacity(.3)),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 3,
                top: 3,
                bottom: 3,
                left: 3,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
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
