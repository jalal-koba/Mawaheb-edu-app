 
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Courses/Util/debouncer.dart';
import 'package:talents/Modules/video/custom_controls.dart';
import 'package:talents/Modules/Youtube/youtube_cubit.dart';
import 'package:talents/Modules/video/video_state.dart';
import 'package:video_player/video_player.dart';

class Restriction {
  Duration duration;
  int index;
  bool pass = false;
  bool show = true;
  Restriction(this.duration, this.index, this.pass, this.show);
}

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(InitialState());

  VideoPlayerController? controller;
  AudioPlayer audioPlayer = AudioPlayer();
  ChewieController? chewieController;
  bool loading = true;
  int selectedQuality = 1;
  double playbackSpeed = 1;
  List<String> audioStreams = [];
  // late Future<void> ?initStream;
  Future<void>? initStream;
  late List<MyVideo> streamsList = [];

  bool init = false;

  final List<Restriction> _seekRestrictions = [];
  List<Restriction> get seekRestrictions => _seekRestrictions;

  void setStreams(List<MyVideo> streamsList) {
    this.streamsList = streamsList;
  }

  void setAudioStreams(List<String> audioStreams) {
    this.audioStreams = audioStreams;
  }

  Future<void> initFromNetwork2(int selected, Duration duration) async {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(streamsList[selected].link),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: true,
      ),
    );

    initStream = controller!.initialize();
    await initStream;
    await controller!.seekTo(duration);

    chewieController = ChewieController(
      videoPlayerController: controller!,
      aspectRatio: 16 / 9,
      customControls: CustomControls(
        videoCubit: this,
      ),
      autoPlay: false,
    );
    return await initStream;
  }

  void changeQuality(int quality) async {
    emit(VideoLoadingState());
    await controller?.pause();
    await audioPlayer.pause();
    Duration cur = controller!.value.position;
    await dispose(keepAudio: true);
    await initFromNetwork2(quality, cur);
    selectedQuality = quality;
    controller!.addListener(listener);
    emit(VideoSuccessfulState());
  }

  void initVideoWithAudio() async {
    emit(VideoLoadingState());
    if (AppSharedPreferences.getQuality != -1) {
      selectedQuality = AppSharedPreferences.getQuality;
    } else {
      selectedQuality = streamsList.length ~/ 2;
    }
    try {
      await Future.wait([
        audioPlayer.setUrl(audioStreams[0]),
        initFromNetwork2(selectedQuality, const Duration(milliseconds: 0))
      ]);
    } catch (error) {
      emit(VideoErrorState(error.toString()));
      return;
    }
    emit(VideoSuccessfulState());
    controller!.addListener(listener);
    audioPlayer.playerStateStream.listen(playerStateStream);
  }

  Future<void> initFromFile(String path) async {
    controller = VideoPlayerController.file(File(path),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: true,
        ));
    initStream = controller!.initialize();
    await initStream;
    chewieController = ChewieController(
      videoPlayerController: controller!,
      aspectRatio: 16 / 9,
      customControls: CustomControls(
        videoCubit: this,
      ),
      autoPlay: false,
    );
    return await initStream;
  }

  bool wasPlaying = false;
  bool isSeeking = false;

  Debouncer debouncer = Debouncer(milliseconds: 500);
  void listener() {
    // print(
    //     'show the two ${controller!.value.position.inMilliseconds - audioPlayer.position.inMilliseconds}');

    if ((controller!.value.position.inMilliseconds -
                audioPlayer.position.inMilliseconds)
            .abs() >
        200) {
      double speed = controller!.value.position.inMilliseconds -
                  audioPlayer.position.inMilliseconds <
              0
          ? 2 * (playbackSpeed)
          : 0.5 * (playbackSpeed);
      controller!.setPlaybackSpeed(speed);
    } else {
      controller!.setPlaybackSpeed(playbackSpeed);
    }

    wasPlaying = controller!.value.isPlaying == true &&
        controller!.value.isBuffering == true;
    if (controller!.value.isPlaying == false ||
        controller!.value.isBuffering == true) {
      if (audioPlayer.playing) {
        audioPlayer.pause();
      }
    } else if (controller!.value.isPlaying == true &&
        controller!.value.isBuffering == false) {
      if (audioPlayer.playing == false) {
        audioPlayer.play();
      }
    }

    debouncer.run(() {
      for (int i = 0; i < _seekRestrictions.length; i++) {
        if (controller!.value.position.inMilliseconds >
                _seekRestrictions[i].duration.inMilliseconds &&
            isSeeking == false &&
            _seekRestrictions[i].show) {
          isSeeking = true;
          seekTo(_seekRestrictions[i].duration, i);
        }
      }
    });
  }

  int time = 0;

  void playerStateStream(PlayerState state) async {
    if (state.playing == false) {
      if (controller!.value.isPlaying == true && wasPlaying == false) {
        await controller!.pause();
        // await controller!.seekTo(Duration(milliseconds:controller!.value.position.inMilliseconds));
      }
    } else if (state.playing == true) {
      if (controller!.value.isPlaying == false) {
        controller!.play();
      }
    }
  }

  void seekTo(Duration duration, int i) async {
    print("show the restriction ${_seekRestrictions[i].pass}");
    if (_seekRestrictions[i].pass == false) {
      await Future.wait([
        controller!.pause(),
        audioPlayer.pause(),
        controller!.seekTo(duration),
        audioPlayer.seek(duration)
      ]);
    } else {
      _seekRestrictions[i].show = false;
      await controller!.pause();
    }

    isSeeking = false;
    emit(VideoInterruptedState(_seekRestrictions[i]));
    // if(interrupt!= null) {
    //   interrupt!(_seekRestrictions[0]);
    // }
  }

  Future<void> dispose({bool keepAudio = false}) async {
    await initStream;

    controller?.dispose();
    if (keepAudio == false) {
      audioPlayer.dispose();
    }
    chewieController?.dispose();
  }

  void initVideo() {
    init = true;
    initFromNetwork2(0, Duration.zero);
    emit(VideoSuccessfulState());
  }
}
