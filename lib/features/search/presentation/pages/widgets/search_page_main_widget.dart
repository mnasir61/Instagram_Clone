import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/search/presentation/pages/widgets/search_field_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';

class SearchPageMainWidget extends StatefulWidget {
  const SearchPageMainWidget({Key? key}) : super(key: key);

  @override
  State<SearchPageMainWidget> createState() => _SearchPageMainWidgetState();
}

class _SearchPageMainWidgetState extends State<SearchPageMainWidget> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetUsersCubit>(context).getAllUsers(user: UserEntity());
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Styles.colorWhite,
          body: BlocBuilder<GetUsersCubit, GetUsersState>(
            builder: (context, userState) {
              if (userState is GetUsersLoaded) {
                final filterAllUsers = userState.users
                    .where((user) =>
                user.username!.startsWith(_searchController.text) ||
                    user.username!.toLowerCase().startsWith(_searchController.text.toLowerCase()) ||
                    user.username!.contains(_searchController.text) ||
                    user.username!.toLowerCase().contains(_searchController.text.toLowerCase()))
                    .toList();
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SearchFieldWidget(
                        controller: _searchController,
                      ),
                    ),
                    _searchController.text.isNotEmpty
                        ? Expanded(
                      child: ListView.builder(
                        itemCount: filterAllUsers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, PageConsts.singleUserProfilePage,
                                  arguments: filterAllUsers[index].uid);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: 40,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: profileWidget(imageUrl: filterAllUsers[index].profileUrl),
                                    ),
                                  ),
                                  horizontalSize(10),
                                  Text(
                                    "${filterAllUsers[index].username}",
                                    style: TextStyle(
                                        color: Styles.colorBlack,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                        : Expanded(
                      child: BlocBuilder<PostCubit, PostState>(
                        builder: (context, postState) {
                          if (postState is PostLoaded) {
                            final posts = postState.posts;
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                              itemCount: posts.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, PageConsts.postDetailPage,
                                        arguments: posts[index].postId);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width * 45,
                                    child: profileWidget(imageUrl: posts[index].postImageUrl),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
