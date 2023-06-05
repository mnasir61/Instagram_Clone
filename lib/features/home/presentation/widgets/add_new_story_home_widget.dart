
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';


class AddNewStoryHomeWidget extends StatelessWidget {
  final String imageUrl;
  final String username;

  const AddNewStoryHomeWidget({required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: -1,
              right: -1,
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(width: 1.5,color: Colors.white)
                ),
                child: Icon(
                  Icons.add,
                  size: 16,
                  color: Styles.colorWhite,
                ),
              ),
            ),
          ],
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
