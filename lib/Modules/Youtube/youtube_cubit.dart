import 'package:bloc/bloc.dart';
import 'package:talents/Modules/Youtube/youtube_state.dart';

class YoutubeCubit extends Cubit<YoutubeState> {
  YoutubeCubit() : super(YoutubeInitialState());
  List<MyVideo> videos = [];

  static String encryptName(String name) {
    String x = name.substring(0, name.length ~/ 2);
    String y = name.substring((name.length ~/ 2), name.length ~/ 2);
    name = y + name + x;
    return name;
  }

  static String convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        return match.group(1).toString();
      }
    }

    return '';
  }
}

enum Quality { medium360, high720 }

class MyVideo {
  String link;
  String quality;
  int value;
  MyVideo({required this.link, required this.value, required this.quality});
}
