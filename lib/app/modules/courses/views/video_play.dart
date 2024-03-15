import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlay extends StatelessWidget {
  final String url;

  const VideoPlay({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the video ID from the URL
    String? videoId = YoutubePlayer.convertUrlToId(url);

    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          liveUIColor: Colors.amber,
        ),
      ),
    );
  }
}
