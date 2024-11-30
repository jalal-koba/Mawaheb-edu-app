import 'package:chewie/src/chewie_progress_colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

import 'custom_video_progress_bar.dart';

class CustomMaterialVideoProgressBar extends StatelessWidget {
  CustomMaterialVideoProgressBar(
      this.controller,
      {super.key,
        required this.audioPlayer,
        this.height = kToolbarHeight,
        ChewieProgressColors? colors,
        this.onDragEnd,
        this.onDragStart,
        this.onDragUpdate,
      }) : colors = colors ?? ChewieProgressColors();

  final double height;
  final VideoPlayerController controller;
  final AudioPlayer audioPlayer;
  final ChewieProgressColors colors;
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function(Duration?)? onDragUpdate;

  @override
  Widget build(BuildContext context) {
    return CustomVideoProgressBar(
      controller,
      audioPlayer,
      barHeight: 5,
      handleHeight: 6,
      drawShadow: true,
      colors: colors,
      onDragEnd: onDragEnd,
      onDragStart: onDragStart,
      onDragUpdate: onDragUpdate,
    );
  }
}
