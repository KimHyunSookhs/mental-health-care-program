import 'package:flutter/material.dart';
import 'package:mental_health_care/data/model/you_tube.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeCard extends StatefulWidget {
  final YouTube youTube;

  const YouTubeCard({super.key, required this.youTube});

  @override
  State<YouTubeCard> createState() => _YouTubeCardState();
}

class _YouTubeCardState extends State<YouTubeCard> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.youTube.youTubeId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YoutubePlayer(
        controller: _controller,
        // showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },
      ),
    );
  }
}
