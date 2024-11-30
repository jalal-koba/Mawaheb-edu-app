import 'package:talents/Modules/Exams/models/exam.dart';
import 'package:talents/Modules/Lessons/Models/file_model.dart';
import 'package:talents/Modules/Utils/bool_converter.dart';
// import 'package:talents/Modules/Youtube/youtube_cubit.dart'; this folder is private

class Lesson {
  final int id;
  final int? sectionId;
  final String name;
  final String description;
  final String videoUrl;
  final String coverImage;
  final String? time;
  final int? examId;
   
   
   
  final int? nextLessonId;
  final List<FileModel> files;
  Exam? exam;

  bool refreshLessonScreen;
  late bool isOpen;
  late bool isFree;

  // List<MyVideo> myVideos = []; private
  // String? audio;

  Lesson({
    required this.nextLessonId,
    required this.isOpen,
    required this.files,
    required this.exam,
    this.refreshLessonScreen = false,
    required this.id,
    required this.name,
    required this.description,
    required this.sectionId,
    required this.videoUrl,
    required this.coverImage,
    required this.isFree,
    required this.time,
    required this.examId, 
    // required this.myVideos,  private
    // required this.audio,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    final bool? isOpen =
        json['is_open'] != null ? boolConverter(json["is_open"]) : null;

    final bool isFree = boolConverter(json["is_free"]);
    bool temp;
    if (isOpen == null) {
      temp = isFree;
    } else {
      temp = isOpen;
    }
    return Lesson(
        isOpen: temp,
        isFree: isFree,
        exam: json["exam"] != null ? Exam.fromJson(json["exam"]) : null,
        files: json['files'] != null
            ? List<FileModel>.from(
                json["files"].map((x) => FileModel.fromJson(x)))
            : [],
        nextLessonId: json["next_lesson_id"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        videoUrl:
            "https://youtu.be/dkwYPVw5fkA?si=vWg8CPlugvWlhvQP", //json["video_url"],
        sectionId: json["section_id"],
        coverImage: json["cover_image"],
        time: json["time"],
        examId: json["exam_id"], 
        // audio:
        //     "https://rr4---sn-hgn7rnls.googlevideo.com/videoplayback?expire=1731249740&ei=7HEwZ7GZNsGBp-oP64On6Qc&ip=185.216.135.132&id=o-ANPijhGprZeGF5Dsdd1DoreZ1rkHiMjjgq4OpGskvQgF&itag=251&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1731228140%2C&mh=JE&mm=31%2C26&mn=sn-hgn7rnls%2Csn-5hne6n6l&ms=au%2Conr&mv=m&mvi=4&pl=22&rms=au%2Cau&initcwndbps=97500&vprv=1&svpuc=1&mime=audio%2Fwebm&rqh=1&gir=yes&clen=46602729&dur=3920.201&lmt=1724779276989582&mt=1731227579&fvip=4&keepalive=yes&fexp=51312688%2C51326932&c=IOS&txp=6208224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRAIgW-Vd31V-EewmG4g-kscAjr379E6IMbc-T1phQjiwLAYCIEkfAYwNY4jstyfow54tMxeJGhhx9sMadbB9Cer2L8D3&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=ACJ0pHgwRQIgI6Zw7tuV5KK2PPY-0y1PAXlmqFGfvFeuWYxZ0OMZPvQCIQD6_Ea2lS6P4_DHjLt8ngWUF2nSu1DLsxy1v_oGm1cPgA%3D%3D",
        // myVideos: [
        //   MyVideo(
        //       link:
        //           "https://rr4---sn-hgn7rnls.googlevideo.com/videoplayback?expire=1731249740&ei=7HEwZ7GZNsGBp-oP64On6Qc&ip=185.216.135.132&id=o-ANPijhGprZeGF5Dsdd1DoreZ1rkHiMjjgq4OpGskvQgF&itag=134&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1731228140%2C&mh=JE&mm=31%2C26&mn=sn-hgn7rnls%2Csn-5hne6n6l&ms=au%2Conr&mv=m&mvi=4&pl=22&rms=au%2Cau&initcwndbps=97500&vprv=1&svpuc=1&mime=video%2Fmp4&rqh=1&gir=yes&clen=116301212&dur=3920.182&lmt=1724779015664750&mt=1731227579&fvip=4&keepalive=yes&fexp=51312688%2C51326932&c=IOS&txp=6209224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRAIgX22iGunO6tMkGFPuP9o7VfJbZTe_BhDt056kw8qYa64CIAYYsQOWENCIsVjWBzy7mibMEuQFrLxtlnGjBGiB8Wbh&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=ACJ0pHgwRQIgI6Zw7tuV5KK2PPY-0y1PAXlmqFGfvFeuWYxZ0OMZPvQCIQD6_Ea2lS6P4_DHjLt8ngWUF2nSu1DLsxy1v_oGm1cPgA%3D%3D",
        //       value: 0,
        //       quality: '360')
        // ]
        );
  }
}
