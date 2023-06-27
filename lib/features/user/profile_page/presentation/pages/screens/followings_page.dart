import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

import '../../../../domain/use_cases/get_single_user_usecase.dart';

class FollowingsPage extends StatelessWidget {
  final UserEntity user;

  const FollowingsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: user.followings!.isEmpty
                  ? _noFollowersWidget()
                  : ListView.builder(
                      itemCount: user.followings!.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<List<UserEntity>>(
                            stream: di.sl<GetSingleUserUseCase>().call(user.followings![index]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == false) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.data!.isEmpty) {
                                return Container();
                              }
                              final singleUserData = snapshot.data!.first;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, PageConsts.singleUserProfilePage,
                                      arguments: singleUserData.uid);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: 40,
                                      height: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: profileWidget(imageUrl: singleUserData.profileUrl),
                                      ),
                                    ),
                                    horizontalSize(10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${singleUserData.username}",
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "${singleUserData.fullName}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
            )
          ],
        ),
      ),
    );
  }

  _noFollowersWidget() {
    return Center(
      child: Text(
        "No Followings",
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
