import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesh/widgets/video_player/multi_manager.dart';
import 'package:provider/provider.dart';

class FeedPlayerPortraitControls extends StatelessWidget {
  const FeedPlayerPortraitControls(
      {Key? key, this.flickMultiManager, this.flickManager})
      : super(key: key);

  final FlickMultiManager? flickMultiManager;
  final FlickManager? flickManager;

  @override
  Widget build(BuildContext context) {
    FlickDisplayManager displayManager =
        Provider.of<FlickDisplayManager>(context);
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: FlickAutoHideChild(
              autoHide: false,
              showIfVideoNotInitialized: false,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const FlickLeftDuration(),
                ),
              ),
            ),
          ),
          Expanded(
            child: FlickToggleSoundAction(
              toggleMute: () {
                flickMultiManager?.togglePlay(flickManager as FlickManager);
                displayManager.handleShowPlayerControls();
              },
              child: const FlickSeekVideoAction(
                child: Center(child: FlickVideoBuffer()),
              ),
            ),
          ),
          FlickAutoHideChild(
            autoHide: false,
            showIfVideoNotInitialized: false,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
                    child: FlickPlayToggle(
                      size: 14,
                      togglePlay: () => flickMultiManager
                          ?.togglePlay(flickManager as FlickManager),
                      color: Colors.white,
                    ),
                  ),
                  // Container(
                  //   // padding: const EdgeInsets.all(2),
                  //   decoration: BoxDecoration(
                  //     color: Colors.black38,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: FlickSoundToggle(
                  //     toggleMute: () => flickMultiManager?.toggleMute(),
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // FlickFullScreenToggle(),
                  const SizedBox(width: 5),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: FlickVideoProgressBar()),
                  const Spacer(),
                  FlickFullScreenToggle(
                      enterFullScreenChild:
                          SvgPicture.asset("assets/icons/expand.svg"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
