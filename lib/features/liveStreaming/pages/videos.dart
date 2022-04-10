import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/features/liveStreaming/data/channel_info.dart';
import 'package:sisterhood_global/features/liveStreaming/data/video_list.dart';
import 'package:sisterhood_global/features/liveStreaming/data/youtube_services.dart';
import 'package:sisterhood_global/features/liveStreaming/pages/video_player.dart';

import '../../../core/themes/theme_colors.dart';

class Videos extends StatefulWidget {
  //final String name, email, photo,uid;

  const Videos({
    Key? key,
  }) : super(key: key);
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  //
  late ChannelInfo _channelInfo;
  late VideosList _videosList;
  late Item _item;
  late bool _loading;
  late String _playListId;
  late String _nextPageToken;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos = [];
    _getChannelInfo();
  }

  _getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items[0];
    _playListId = _item.contentDetails!.relatedPlaylists!.uploads!;
    print('_playListId $_playListId');
    await _loadVideos();
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    //_nextPageToken = tempVideosList.nextPageToken!;
    _videosList.videos!.addAll(tempVideosList.videos!);
    print('videos: ${_videosList.videos!.length}');
    print('_nextPageToken $_nextPageToken');
    //setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Videos',
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
        backgroundColor: ThemeColors.whiteColor,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification) {
                  if (_videosList.videos!.length >=
                      int.parse(_item.statistics!.videoCount!)) {
                    return true;
                  }
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    _loadVideos();
                  }
                  return true;
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount: _videosList.videos!.length,
                  itemBuilder: (context, index) {
                    VideoItem videoItem = _videosList.videos![index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => VideoPlayerScreen(
                              videoID: videoItem.video!.resourceId!.videoId!,
                              videoTitle: videoItem.video!.title!,
                            ));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: videoItem
                                  .video!.thumbnails!.thumbnailsDefault!.url!,
                            ),
                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    videoItem.video!.title!,
                                    maxLines: 4,
                                  ),
                                ),
                                Text(
                                  '${videoItem.video!.publishedAt!.year}-${videoItem.video!.publishedAt!.month}-${videoItem.video!.publishedAt!.day}',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInfoView() {
    return _loading
        ? CircularProgressIndicator()
        : Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        _item.snippet!.thumbnails!.medium!.url!,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        _item.snippet!.title!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(_item.statistics!.videoCount!),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
