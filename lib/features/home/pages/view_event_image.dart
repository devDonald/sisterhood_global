import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_extend/share_extend.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/liveStreaming/pages/video_player.dart';

class ViewAttachedImage extends StatefulWidget {
  static const String id = 'ViewAttachedImage';
  ViewAttachedImage({
    Key? key,
    required this.image,
    required this.url,
    required this.text,
  }) : super(key: key);
  final String text, url;
  final ImageProvider image;
  @override
  _ViewAttachedImageState createState() => _ViewAttachedImageState();
}

class _ViewAttachedImageState extends State<ViewAttachedImage> {
  bool isShowText = true;

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  shareFile() async {
    var dio = Dio();
    String code = '';
    String ext = '.jpg';

    if (mounted) {
      setState(() {
        code = generateRandomString(10);
      });
    }

    final String dir = (await getApplicationDocumentsDirectory()).path;
    String path = '$dir/$code$ext';

    await download2(dio, widget.url, path).then((value) {
      ShareExtend.share(
        path,
        'image',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isShowText = !isShowText;
                  });
                },
                child: PhotoView(
                  imageProvider: widget.image,
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.contained * 2.5,
                  initialScale: PhotoViewComputedScale.contained * 1.0,
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              left: 5.0,
              child: Material(
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.black.withOpacity(0.05),
                child: InkWell(
                  onTap: () {
                    if (widget.url != '') {
                      shareFile();
                    }
                  },
                  child: Container(
                    width: 36.5,
                    height: 36.5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.black.withOpacity(0.05),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36.5,
                    height: 36.5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ),
            isShowText
                ? Positioned(
                    bottom: 0.0,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        right: 10.0,
                        bottom: 15.0,
                        left: 10.0,
                      ),
                      width: deviceWidth,
                      color: Colors.black.withOpacity(0.15),
                      child: SelectableLinkify(
                        text: widget.text,
                        maxLines: 4,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        linkStyle: TextStyle(color: Colors.blue),
                        onOpen: onOpen,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
