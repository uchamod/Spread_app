import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:spread/util/constants.dart';
import 'package:video_player/video_player.dart';

//video player
class CoustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CoustomVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CoustomVideoPlayer> createState() => _CoustomVideoPlayerState();
}

class _CoustomVideoPlayerState extends State<CoustomVideoPlayer> {
  late VideoPlayerController _playerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    //initilize and set up layer with properties
    _playerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then(
            (_) {
              setState(() {});
            },
          );
    _chewieController = ChewieController(
      videoPlayerController: _playerController,
      aspectRatio: _playerController.value.aspectRatio,
      allowFullScreen: true,
      allowMuting: true,
      autoInitialize: true,
      autoPlay: true,
      allowPlaybackSpeedChanging: true,
      draggableProgressBar: true,
      looping: false,
      showControlsOnInitialize: false,
      materialProgressColors: ChewieProgressColors(
          backgroundColor: secondorywhite,
          playedColor: errorColor,
          bufferedColor: secondoryBlack,
          handleColor: cardBlue),
      placeholder: Placeholder(
        
        child: Container(
          color: secondoryBlack,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _playerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _playerController.value.isInitialized
            ? Chewie(controller: _chewieController)
            : const Center(
                child: CircularProgressIndicator(
                  color: secondorywhite,
                ),
              )

        // Positioned(
        //     bottom: 10,
        //     left: 5,
        //     child: IconButton(
        //       onPressed: () {
        //         _togglePlayPause();
        //       },
        //       icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        //     ))
        ;
  }
}
