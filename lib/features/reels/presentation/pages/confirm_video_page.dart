import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/app_entity.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoPage extends StatefulWidget {
  final AppEntity appEntity;

  ConfirmVideoPage({Key? key, required this.appEntity}) : super(key: key);

  @override
  State<ConfirmVideoPage> createState() => _ConfirmVideoPageState();
}

class _ConfirmVideoPageState extends State<ConfirmVideoPage> {
  VideoPlayerController? _videoPlayerController;
  bool _showIcon = true;
  Timer? _iconTimer;

  @override
  void initState() {
    super.initState();
    if (widget.appEntity.mediaFile != null &&
        widget.appEntity.mediaFile!.path.endsWith('.mp4') &&
        widget.appEntity.selectedGalleryFile == null) {
      print("Video path in ConfirmPage: ${widget.appEntity.mediaFile}");
      _videoPlayerController = VideoPlayerController.file(widget.appEntity.mediaFile!);
      _videoPlayerController!.initialize().then((_) {
        setState(() {});
      });
    } else if (widget.appEntity.selectedGalleryFile != null &&
        widget.appEntity.selectedGalleryFile!.path.endsWith('.mp4') &&
        widget.appEntity.mediaFileUrl == null) {
      print("Video path in ConfirmPage: ${widget.appEntity.selectedGalleryFile!.path}");
      _videoPlayerController = VideoPlayerController.file(widget.appEntity.selectedGalleryFile!);
      _videoPlayerController!.initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _videoPlayerController!.pause();
    _videoPlayerController!.setVolume(0);
    _iconTimer?.cancel();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.width * 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () {
                    _toggleVideoPlayback();
                    _startIconTimer();
                  },
                  child: Stack(
                    children: [
                      if (_videoPlayerController != null)
                        VideoPlayer(_videoPlayerController!)
                      else
                        //TODO
                        Image.file(File(widget.appEntity.mediaFile!.path)),
                      AnimatedOpacity(
                        opacity: _showIcon ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: _videoPlayerController!.value.isPlaying
                                ? Icon(
                                    Icons.play_arrow,
                                    size: 64,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.pause,
                                    size: 64,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios_rounded),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Row(
                              children: [
                                _cameraButtons(
                                  icon: CupertinoIcons.music_note_2,
                                  onTap: () {},
                                ),
                                _cameraButtons(
                                  icon: CupertinoIcons.textformat,
                                  onTap: () {},
                                ),
                                _cameraButtons(
                                  icon: Icons.face,
                                  onTap: () {},
                                ),
                                _cameraButtons(
                                  icon: CupertinoIcons.wand_stars,
                                  onTap: () {},
                                ),
                                _cameraButtons(
                                  icon: Icons.download,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Edit video",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Add clips",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageConsts.uploadReelPage,
                          arguments: AppEntity(
                            currentUser: widget.appEntity.currentUser,
                              mediaFile: widget.appEntity.mediaFile,
                              selectedGalleryFile: widget.appEntity.selectedGalleryFile));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 17,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cameraButtons({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(.4)),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
