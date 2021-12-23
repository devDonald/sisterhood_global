import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/features/liveStreaming/data/channel_info.dart';
import 'package:sisterhood_global/features/liveStreaming/data/video_list.dart';

class Services {
  //
  static const CHANNEL_ID = 'UCufutoNQc012L2zF-ITDl8g';
  static const _baseUrl = 'www.googleapis.com';

  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': APIKEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  static Future<VideosList> getVideosList(
      {required String playListId, required String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '1000',
      'pageToken': pageToken,
      'key': APIKEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
