// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_way/core/widgets/my_scaffold.dart';
// import 'package:my_way/feature/Video/video_cubit.dart';
// import 'package:my_way/feature/video/video_state.dart';
// import 'package:my_way/feature/video/video_widget.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// import '../../core/widgets/custom_button.dart';
// import '../web_view/web_view.dart';
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen({Key? key,required this.url}) : super(key: key);
//   final String url;
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//
//   VideoCubit videoCubit = VideoCubit();
//   @override
//   void initState() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
//     videoCubit.setStreams([widget.url]);
//     videoCubit.initForIframe();
//     super.initState();
//   }
//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
//     videoCubit.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  YoutubeVideoWidget(
//         controller: videoCubit.youtubePlayerController!,
//
//     );
//   }
// }
