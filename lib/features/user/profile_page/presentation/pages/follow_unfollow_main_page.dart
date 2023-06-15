import 'package:flutter/material.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/followers_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/followings_page.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/screens/subscription_page.dart';

class FollowUnfollowMainPage extends StatefulWidget {
  final UserEntity user;

  const FollowUnfollowMainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<FollowUnfollowMainPage> createState() => _FollowUnfollowMainPageState();
}

class _FollowUnfollowMainPageState extends State<FollowUnfollowMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        // scrolledUnderElevation: 10,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("${widget.user.username}"),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          controller: _tabController,
          tabs:  [
            Tab(text:"${widget.user.followers!.length} Followers"),
            Tab(text: '${widget.user.followings!.length} Followings'),
            Tab(text: '0 Subscriptions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FollowersPage(user: widget.user),
          FollowingsPage(user: widget.user),
          SubscriptionPage(),
        ],
      ),
    );
  }
}
