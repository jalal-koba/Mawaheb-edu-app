import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:talents/Modules/video/custom_controls.dart';
import 'package:talents/Modules/video/video_cubit.dart';

// class VideoWidget extends StatelessWidget {
//   final PodPlayerController controller;
//   const VideoWidget({Key? key, required this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     print('the height is ${100.w}');
//
//     return PodVideoPlayer(
//       controller: controller,
//       podProgressBarConfig: PodProgressBarConfig(
//         circleHandlerColor: AppColors.primaryColor,
//         playingBarColor: AppColors.primaryColor,
//         padding: EdgeInsets.symmetric(vertical: 0.5.h),
//       ),
//     );
//   }
// }
final UniqueKey key = UniqueKey();

class VideoWidget2 extends StatefulWidget {
  final VideoCubit videoCubit;

  const VideoWidget2({super.key, required this.videoCubit});

  @override
  State<VideoWidget2> createState() => _VideoWidget2State();
}

class _VideoWidget2State extends State<VideoWidget2> {
  late ChewieController chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: widget.videoCubit.controller!,
      aspectRatio: 16 / 9,
      customControls: CustomControls(
        videoCubit: widget.videoCubit,
      ),
      autoPlay: false,
    );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Chewie(
        key: key,
        controller: chewieController,
      ),
    );
  }
}

// class YoutubeVideoWidget extends StatelessWidget {
//   const YoutubeVideoWidget({Key? key, required this.controller}) : super(key: key);
//   final YoutubePlayerController controller;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Stack(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: YoutubePlayer(
//               controller: controller,
//               enableFullScreenOnVerticalDrag: false,
//               gestureRecognizers:const {}, 

//             ),
//           ),
//           Container(
//             height: 10.w,
//             width: double.infinity,
//             color: Colors.black,
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 12.w ,
//               width: double.infinity,
//               color: Colors.black,
//               margin: EdgeInsets.only(bottom: 15.5.w),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }




