import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UploadReelPage extends StatefulWidget {
  final String mediaFile;

  const UploadReelPage({super.key, required this.mediaFile});

  @override
  State<UploadReelPage> createState() => _UploadReelPageState();
}

class _UploadReelPageState extends State<UploadReelPage> {
  VideoPlayerController? _videoPlayerController;
  TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(File(widget.mediaFile));
    _videoPlayerController!.initialize().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _captionController.dispose();
    _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text("New Reel"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: VideoPlayer(_videoPlayerController!)),
                          ),
                        ),
                        TextFormField(
                          maxLines: null,
                          controller: _captionController,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintText: "Write a caption",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          enabled: true,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(.15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              Icons.slow_motion_video,
                              size: 25,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Share to Reels",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your video my appear in Reels and can be seen on the Reels tab of your profile",
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Also share to Feed",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text("Switch button here"),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(.15),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      _buttonsWidget(icon: Icons.person_pin_outlined, text: "Tag people"),
                      _buttonsWidget(icon: Icons.tag, text: "Add topics"),
                      _buttonsWidget(icon: Icons.music_video_rounded, text: "Rename audio"),
                      _buttonsWidget(icon: Icons.location_on_outlined, text: "Add location"),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.withOpacity(.15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _containerButton(
                    text: "Save draft",
                    backGroundColor: Colors.white,
                    textColor: Colors.black,
                    borderColor: Colors.grey),
                _containerButton(
                    onTap: () {
                      _uploadModelSheet(context);
                    },
                    text: "Next",
                    backGroundColor: Colors.blue,
                    textColor: Colors.white,
                    borderColor: Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _containerButton({
    String? text,
    Color? textColor,
    Color? backGroundColor,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .435,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: backGroundColor,
          border: Border.all(width: 1, color: borderColor!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          "$text",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
        )),
      ),
    );
  }

  _buttonsWidget({String? text, IconData? icon}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text("$text", style: TextStyle(fontSize: 16)),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _uploadModelSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return _uploadModelSheetWidget();
      },
    );
  }

  _uploadModelSheetWidget() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .5),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                "About Reels",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _aboutReels(
                  icon: Icons.slow_motion_video,
                  text: "Your reel will be shared to Reels, where anyone can discover it."),
              _aboutReels(
                  icon: Icons.music_video_outlined,
                  text:
                      "Because you account is public, anyone can create reels with your original audio or remix all or part of your reel."),
              _aboutReels(
                  icon: Icons.download_outlined,
                  text: "If someone remix your reel, they can download it as part of their remix."),
              _aboutReels(
                  icon: Icons.settings_outlined,
                  text:
                      "You can turn off remixing for each reel or change the default in your setting."),
           const SizedBox(height: 10),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Share",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.blue),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5,),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Learn more about Reels.",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  _aboutReels({IconData? icon, String? text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 26,
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              "$text",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
