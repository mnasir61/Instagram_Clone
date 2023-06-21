import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_entity/bookmark_entity.dart';
import 'package:instagram_clone/features/bookmark/domain/bookmark_usecases/get_bookmark_usecase.dart';
import 'package:instagram_clone/features/bookmark/presentation/bookmark_cubit/bookmark_cubit.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/user/profile_page/presentation/pages/widgets/profile_widget.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class BookmarkPostsPage extends StatefulWidget {
  final BookmarkEntity bookmark;

  const BookmarkPostsPage({Key? key, required this.bookmark}) : super(key: key);

  @override
  State<BookmarkPostsPage> createState() => _BookmarkPostsPageState();
}

class _BookmarkPostsPageState extends State<BookmarkPostsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text("Saved"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, state) {
              if (state is BookmarkLoaded) {
                final bookmarks = state.bookmarks;
                return bookmarks.isEmpty
                    ? _noBookmarkPostWidget()
                    : BlocProvider<BookmarkCubit>(
                        create: (context) => di.sl<BookmarkCubit>(),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                          itemCount: bookmarks.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            final singleBookmarkPost = bookmarks[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, PageConsts.postDetailPage,
                                    arguments: singleBookmarkPost.postId);
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 45,
                                // color: Colors.grey,
                                child: profileWidget(imageUrl: singleBookmarkPost.postImageUrl),
                              ),
                            );
                          },
                        ),
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  _noBookmarkPostWidget() {
    return Center(child: Text("No Bookmark Posts Yet..."));
  }
}
