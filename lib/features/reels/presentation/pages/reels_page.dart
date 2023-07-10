import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/use_cases/get_all_reels_usecase.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/model_sheets/comments_model_sheet_widget.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/model_sheets/option_model_sheet_widget.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/model_sheets/share_model_sheet_widget.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/video_player_widget.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/user/presentation/cubit/user/get_users_cubit.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  final UserEntity currentUser;

  ReelsPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> with WidgetsBindingObserver {
  VideoPlayerController? _videoPlayerController;
  bool _showIcon = false;
  Timer? _iconTimer;

  // VideoPlayerController _getCachedVideoPlayerController(String videoUrl) {
  //   final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
  //   controller.initialize();
  //   return controller;
  // }

  void _toggleVideoPlayback() {
    if (_videoPlayerController!.value.isPlaying) {
      _videoPlayerController!.pause();
    } else {
      _videoPlayerController!.play();
    }
    setState(() {
      _showIcon = !_showIcon;
    });
    _startIconTimer();
  }

  void _startIconTimer() {
    _iconTimer?.cancel();
    _iconTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _showIcon = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.currentUser.uid!);
    BlocProvider.of<GetUsersCubit>(context).getAllUsers(user: UserEntity());
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserLoaded) {
            final singleUser = singleUserState.singleUser;
            return BlocBuilder<GetUsersCubit, GetUsersState>(
              builder: (context, usersState) {
                if (usersState is GetUsersLoaded) {
                  final allUsers = usersState.users;
                  return StreamBuilder<List<ReelEntity>>(
                    stream: di.sl<GetAllReelsUseCase>().call(ReelEntity()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        final reelData = snapshot.data;
                        int _totalPages() {
                          int reelsLength = reelData!.length;
                          int usersLength = allUsers.length;
                          return usersLength > reelsLength ? usersLength : reelsLength;
                        }

                        final int totalPages = _totalPages();
                        return reelData!.isEmpty
                            ? _uploadFirstReelPage(onPress: () {
                                Navigator.pushNamed(context, PageConsts.cameraPage,
                                    arguments: AppEntity(currentUser: singleUser));
                              })
                            : PageView.builder(
                                itemCount: totalPages,
                                controller: PageController(initialPage: 0, viewportFraction: 1),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final singleUser = allUsers[index % allUsers.length];
                                  final singleReel = reelData[index % reelData.length];
                                  // final videoPlayerController =
                                  // _getCachedVideoPlayerController(singleReel.reelVideoUrl!);
                                  return Stack(
                                    children: [
                                      Container(
                                        width: size.width,
                                        height: size.height,
                                        child: GestureDetector(
                                            onTap: () {
                                              _toggleVideoPlayback();
                                            },
                                            child: VideoPlayerWidget(
                                                videoPath: singleReel.reelVideoUrl!)),
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Reels",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w900, fontSize: 20),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(context, PageConsts.cameraPage,
                                                        arguments: AppEntity(currentUser: singleUser));
                                                  },
                                                  child: Icon(CupertinoIcons.camera),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 100,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                      left: 20,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(20),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius.circular(20),
                                                                child: profileWidget(
                                                                    imageUrl:
                                                                        "${singleUser.profileUrl}"),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            Text(
                                                              "${singleUser.username}",
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 14),
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: 15, vertical: 4),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(8),
                                                                  border: Border.all(
                                                                      width: 1, color: Colors.black)),
                                                              child: Text(
                                                                "Follow",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "${singleReel.description}",
                                                          style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: size.width * .5,
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 5, vertical: 4),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey.withOpacity(.5),
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                CupertinoIcons.music_note_2,
                                                                size: 15,
                                                                color: Colors.black,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                  child: Text(
                                                                    "songName here",
                                                                    maxLines: null,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: const TextStyle(
                                                                      fontSize: 14,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 60,
                                                  margin: EdgeInsets.only(top: size.height / 2.75),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons.favorite_outline,
                                                              size: 25,
                                                              color: Colors.black,
                                                            ),
                                                            const SizedBox(height: 4),
                                                            Text(
                                                              "${singleReel.totalLikes}",
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _showCommentsModalSheet();
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              FontAwesomeIcons.comment,
                                                              size: 22,
                                                              color: Colors.black,
                                                            ),
                                                            const SizedBox(height: 7),
                                                            Text(
                                                              "${singleReel.totalComments}",
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _showShareModalSheet();
                                                        },
                                                        child: Column(
                                                          children: [
                                                            const Icon(
                                                              CupertinoIcons.paperplane,
                                                              size: 25,
                                                              color: Colors.black,
                                                            ),
                                                            const SizedBox(height: 7),
                                                            Text(
                                                              "${singleReel.totalShares}",
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _showOptionsModalSheet();
                                                        },
                                                        child: Column(
                                                          children: [
                                                            const Icon(
                                                              CupertinoIcons.ellipsis_vertical,
                                                              size: 25,
                                                              color: Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                height: 30,
                                                                width: 30,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    border: Border.all(
                                                                        width: 1, color: Colors.black),
                                                                    image: DecorationImage(
                                                                      image: AssetImage(
                                                                          "assets/local/instagram_post.png"),
                                                                      fit: BoxFit.cover,
                                                                    )),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                      }
                      return CircularProgressIndicator();
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  void _showOptionsModalSheet() {
    // Show options modal sheet
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return OptionModelSheetWidget();
      },
    );
  }

  void _showCommentsModalSheet() {
    // Show comments modal sheet
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CommentsModelSheetWidget();
      },
    );
  }

  void _showShareModalSheet() {
    // Show share modal sheet
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ShareModelSheetWidget();
      },
    );
  }

  _uploadFirstReelPage({VoidCallback? onPress}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF833AB4).withOpacity(.4),
            Color(0xFFFD1D1D).withOpacity(.3),
            Color(0xFFFCAF45).withOpacity(.2),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Icon(
                            Icons.announcement_outlined,
                            size: 28,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                          maxLines: 10,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          "We are thrilled to announce the arrival of Reels, a new feature on Instagram that lets you express yourself and discover exciting content like never before. Reels empowers you to create and share short, engaging videos with your friends, followers, and the entire Instagram community."),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                      "Tap on Upload Icon to upload first reel in this application."),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    animationDuration: Duration(milliseconds: 400),
                    overlayColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: onPress,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(.8),
                    ),
                    child: Icon(
                      CupertinoIcons.cloud_upload,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
