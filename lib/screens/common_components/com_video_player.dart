import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LecVideoPlayer extends StatefulWidget {
  final Future<String> youtubeVideoStreamUrl;

  const LecVideoPlayer(this.youtubeVideoStreamUrl, {super.key});

  @override
  State<LecVideoPlayer> createState() => _LecVideoPlayerState();
}

class _LecVideoPlayerState extends State<LecVideoPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    // Initialize flickManager in initState
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(''),),autoPlay: false,
    );
  }

  @override
  void dispose() {
    // Dispose flickManager in dispose
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: widget.youtubeVideoStreamUrl, // Access youtubeVideoStreamUrl from widget
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final videoUrl = snapshot.data;
          if (videoUrl != null) {
            flickManager.handleChangeVideo( // Handle video change when url changes
              VideoPlayerController.networkUrl(
                Uri.parse(videoUrl),
                videoPlayerOptions: VideoPlayerOptions(
                  allowBackgroundPlayback: false,
                  mixWithOthers: false,
                ),
              ),
            );
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: FlickVideoPlayer(
                  wakelockEnabled: true,
                  flickManager: flickManager,

                ),
              ),
            );
          } else {
            return const Text('No streamable video found');
          }
        }
      },
    );
  }
}
