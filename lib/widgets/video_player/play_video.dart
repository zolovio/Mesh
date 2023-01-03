import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mesh/widgets/video_player/multi_manager.dart';
import 'package:mesh/widgets/video_player/multi_player.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayer extends StatefulWidget {
  final String fileId;
  VideoPlayer({Key? key, required this.fileId}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
          "https://mesh.kodagu.today/assets/${widget.fileId}",
          // closedCaptionFile: _loadCaptions(),
        ),
        autoInitialize: true,
        autoPlay: false);
    flickManager.flickVideoManager?.autoInitialize;
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoPause();
        }
      },
      child: GestureDetector(
        onTap: () => flickManager.flickControlManager?.enterFullscreen(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 104,
            width: 103,
            child: FlickVideoPlayer(
              flickManager: flickManager,
              flickVideoWithControls: FlickVideoWithControls(
                willVideoPlayerControllerChange: false,
                closedCaptionTextStyle: const TextStyle(fontSize: 8),
                controls: Stack(
                  children: [
                    FlickAutoHideChild(showIfVideoNotInitialized: false, child: Container(color: Colors.black)),
                    Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: const Color(0xffC9C9C9).withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                            width: 34,
                            height: 16,
                            child: const FlickTotalDuration()))
                  ],
                ),
              ),
              flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                controls: FlickLandscapeControls(),
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeedPlayer extends StatefulWidget {
  const FeedPlayer({Key? key, required this.items}) : super(key: key);
  final Map<String, dynamic> items;

  @override
  _FeedPlayerState createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickMultiManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && mounted) {
          flickMultiManager.pause();
        }
      },
      child: SizedBox(
        height: 254,
        child: FlickMultiPlayer(
          url: widget.items['trailer_url'],
          flickMultiManager: flickMultiManager,
          image: widget.items['image'],
        ),
      ),
    );
  }
}
