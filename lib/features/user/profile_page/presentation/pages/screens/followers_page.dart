
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

import '../../../../domain/use_cases/get_single_user_usecase.dart';
import '../widgets/profile_widget.dart';

class FollowersPage extends StatelessWidget {
  final UserEntity user;
  const FollowersPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Followers"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: user.followers!.isEmpty? _noFollowersWidget() : ListView.builder(itemCount: user.followers!.length,itemBuilder: (context, index) {

                return StreamBuilder<List<UserEntity>>(
                    stream: di.sl<GetSingleUserUseCase>().call(user.followers![index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final singleUserData = snapshot.data!.first;
                      return  GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageConsts.singleUserProfilePage, arguments: singleUserData.uid);

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
                            Text("${singleUserData.username}", style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w600),)
                          ],
                        ),
                      );
                    }
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  _noFollowersWidget() {
    return Center(
      child: Text("No Followers", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
    );
  }
}