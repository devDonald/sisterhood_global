import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sisterhood_global/features/liveStreaming/data/video_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/widgets/linkify_widgets.dart';

class VideoPlayerScreen extends StatefulWidget {
  //
  VideoPlayerScreen({required this.videoItem});
  final VideoItem videoItem;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  //
  late YoutubePlayerController _controller;
  late bool _isPlayerReady;
  int progress = 0;

  @override
  void initState() {
    print('videoLink ${widget.videoItem}');
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoItem.video!.resourceId!.videoId!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      //
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.videoItem.video!.title!),
      ),
      body: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print('Player is ready.');
                    _isPlayerReady = true;
                  },
                ),
                // IconButton(
                //   icon: Icon(
                //     Icons.download_rounded,
                //     size: 40,
                //     color: Colors.green,
                //   ),
                //   onPressed: () async {
                //     final status = await Permission.storage.request();
                //
                //     if (status.isGranted) {
                //       final externalDir = await getExternalStorageDirectory();
                //
                //       String id = await FlutterDownloader.enqueue(
                //         url:
                //             "https://firebasestorage.googleapis.com/v0/b/jangu-98ad9.appspot.com/o/icons%2F2019?alt=media&token=988199c1-3e18-42be-a155-0d3ba4a5e54e",
                //         savedDir: externalDir.path,
                //         fileName: "${widget.videoItem.video.title}",
                //         showNotification: true,
                //         openFileFromNotification: true,
                //       );
                //     } else {
                //       print("Permission deined");
                //     }
                //   },
                // )
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: buildTextWithLinks(widget.videoItem.video!.title!),
            ),
          ],
        ),
      ),
    );
  }
}
