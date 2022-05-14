import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeLive extends StatelessWidget {
  const YoutubeLive({Key? key}) : super(key: key);

  //String frameVideo = "<html><body>Youtube Live <br> <iframe width=\"400\" height=\"290\" src=\"https://www.youtube.com/embed/live_stream?channel=UCXTMFK4-CSliIT1tXuRXpkg\" frameborder=\"0\" allowfullscreen=\"true\"></iframe></body></html>";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.pink,
        title: const Text('Live Streaming',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: -5.0,
      ),
      body: WebView(
        zoomEnabled: true,
        initialUrl: Uri.dataFromString(
                '<html><body><iframe height="${MediaQuery.of(context).size.height}" width="${MediaQuery.of(context).size.width * 3}" src="https://www.youtube.com/embed/live_stream?channel=UCufutoNQc012L2zF-ITDl8g\"></iframe></body></html>',
                mimeType: 'text/html')
            .toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
