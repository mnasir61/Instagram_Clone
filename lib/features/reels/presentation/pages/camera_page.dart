import 'dart:async';
import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/global/const/page_const.dart';
import 'package:instagram_clone/features/reels/presentation/pages/confirm_video_page.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;
  bool _isRecording = false;
  double _progress = 0.0;
  Timer? _timer;
  XFile? _galleryMedia;
  GlobalKey<_CameraPageState> _cameraPageKey = GlobalKey<_CameraPageState>();

  @override
  void initState() {
    super.initState();

    // Initialize camera controller
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get available cameras
    List<CameraDescription> cameras = await availableCameras();

    // Initialize the first camera from the list
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);

    // Initialize the camera controller
    _initializeControllerFuture = _cameraController!.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (_cameraController!.value.isInitialized && !_cameraController!.value.isRecordingVideo) {
      try {
        await _cameraController!.startVideoRecording();
        _startTimer();
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        // Handle the error
        print('Error starting video recording: $e');
      }
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController!.value.isRecordingVideo) {
      try {
        XFile? videoFile = await _cameraController!.stopVideoRecording();
        _timer?.cancel();
        setState(() {
          _isRecording = false;
          _progress = 0.0;
        });

        if (videoFile != null) {
          Navigator.pushReplacementNamed(context, PageConsts.confirmVideoPage,arguments: videoFile.path);
        }
      } catch (e) {
        // Handle the error
        print('Error stopping video recording: $e');
      }
    }
  }

  void _startTimer() {
    const duration = Duration(seconds: 30);
    double step = 1.0 / (duration.inMilliseconds / 100);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += step;
      });
      if (_progress >= 1.0) {
        _stopRecording();
      }
    });
  }

  Future<void> _switchCamera() async {
    final cameras = await availableCameras();
    final lensDirection = _cameraController!.description.lensDirection;
    final newCamera = cameras.firstWhere((camera) => camera.lensDirection != lensDirection);

    await _cameraController!.dispose();
    _cameraController = CameraController(newCamera, ResolutionPreset.high);
    await _cameraController!.initialize();

    setState(() {});
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    final pickedMedia = await picker.pickImage(source: ImageSource.gallery);

    if (pickedMedia != null) {
      setState(() {
        _galleryMedia = pickedMedia;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmVideoPage(mediaFile: pickedMedia.path),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _cameraPageKey,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _galleryMedia != null
                            ? Image.file(
                                File(_galleryMedia!.path),
                                fit: BoxFit.cover,
                              )
                            : CameraPreview(_cameraController!),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Icon(
                        Icons.flash_off,
                        color: Colors.white,
                        size: 30,
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 140),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4,
                      right: MediaQuery.of(context).size.height / 2.75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        CupertinoIcons.music_note_2,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 15),
                      Icon(
                        CupertinoIcons.wand_stars,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 15),
                      Icon(
                        CupertinoIcons.person_crop_square,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 15),
                      Icon(
                        CupertinoIcons.arrow_turn_up_left,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 15),
                      Icon(
                        CupertinoIcons.speedometer,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 15),
                      Icon(
                        FluentIcons.slide_layout_20_regular,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 15),
                      Icon(
                        CupertinoIcons.timer,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_isRecording) {
                          _stopRecording();
                        } else {
                          _startRecording();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                        ),
                        child: CircularProgressIndicator(
                          value: _progress,
                          strokeWidth: 5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _openGallery,
                  icon: Container(
                    height: 30,
                    width: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(Icons.photo_library),
                    ),
                  ),
                ),
                Text(
                  "REEL",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: _switchCamera,
                  icon: Icon(Icons.flip_camera_android),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
