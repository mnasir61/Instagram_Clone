import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/search/presentation/pages/widgets/search_field_widget.dart';

class SearchPageMainWidget extends StatefulWidget {
  const SearchPageMainWidget({Key? key}) : super(key: key);

  @override
  State<SearchPageMainWidget> createState() => _SearchPageMainWidgetState();
}

class _SearchPageMainWidgetState extends State<SearchPageMainWidget> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.colorWhite,
        elevation: 0,
        title: SearchFieldWidget(controller: _searchController),
      ),
      backgroundColor: Styles.colorWhite,
      body: Column(
        children: [
          Expanded(
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
                        onTap: (){
                          Navigator.pushNamed(context, PageConsts.postDetailPage,arguments: posts[index].postId);
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
      ),
    );
  }
}
