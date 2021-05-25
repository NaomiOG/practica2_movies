import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  YoutubePlayerScreen({
    Key key,
    @required this.videoKey,
  }) : super(key: key);

  final String videoKey;

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState(videoKey);
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  
  _YoutubePlayerScreenState(videoKey){
    this.trailerId=videoKey;
  }
 
  bool _isPlayerReady = false;
  String trailerId;
  
  @override
  Widget build(BuildContext context) {
   return YoutubePlayerBuilder(
      player: YoutubePlayer(
          controller: YoutubePlayerController(
          initialVideoId: trailerId, //Add videoID.
          flags: YoutubePlayerFlags(
            hideControls: false,
            controlsVisibleAtStart: true,
            autoPlay: true,
            mute: false,
          ),
        ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      onReady: () {
          _isPlayerReady=true;
      },
  ), 
    builder: (context, player) =>  Container(
      height: 300,
      child: player,
    )
    );
   
  }
}
