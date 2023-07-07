import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoPage extends StatefulWidget {
  final String? mediaFile;

  ConfirmVideoPage({required this.mediaFile});

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
    if (widget.mediaFile != null && widget.mediaFile!.endsWith('.mp4')) {
      _videoPlayerController = VideoPlayerController.file(File(widget.mediaFile!));
      _videoPlayerController!.initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_videoPlayerController != null &&
        widget.mediaFile != null &&
        widget.mediaFile! != _videoPlayerController!.dataSource) {
      _videoPlayerController!.dispose();
      _videoPlayerController = VideoPlayerController.file(File(widget.mediaFile!));
      _videoPlayerController!.initialize().then((_) {
        setState(() {});
      });
    }
  }

  void _startIconTimer() {
    _iconTimer!.cancel();
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
            if (widget.mediaFile != null && widget.mediaFile!.endsWith('.mp4'))
              Container(
                width: screenSize.width,
                height: screenSize.width * 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      VideoPlayer(_videoPlayerController!),
                      GestureDetector(
                        onTap: () {
                          _toggleVideoPlayback();
                          _startIconTimer();
                        },
                        child: AnimatedOpacity(
                          opacity: _showIcon ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: _videoPlayerController!.value.isPlaying
                                  ? Icon(
                                      CupertinoIcons.play_arrow_solid,
                                      size: 70,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      CupertinoIcons.stop_fill,
                                      size: 70,
                                      color: Colors.white,
                                    ),
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
                            _cameraButtons(
                                icon: Icons.arrow_back_ios_rounded,
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                            Row(
                              children: [
                                _cameraButtons(icon: CupertinoIcons.music_note_2, onTap: () {}),
                                _cameraButtons(icon: CupertinoIcons.textformat, onTap: () {}),
                                _cameraButtons(icon: Icons.face, onTap: () {}),
                                _cameraButtons(icon: CupertinoIcons.wand_stars, onTap: () {}),
                                _cameraButtons(icon: Icons.download, onTap: () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Image.file(File(widget.mediaFile!)),
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
                          arguments: widget.mediaFile);
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

  _cameraButtons({
    VoidCallback? onTap,
    IconData? icon,
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
