 
import 'package:talents/Modules/video/video_cubit.dart';

class VideoState {}

class InitialState extends VideoState{}

class CreateVideoControllerLoadingState extends VideoState{}
class CreateVideoControllerErrorState extends VideoState{}
class CreateVideoControllerSuccessfulState extends VideoState{}

class ChangeVideoQualityLoadingState extends VideoState{}
class ChangeVideoQualityErrorState extends VideoState{}
class ChangeVideoQualitySuccessfulState extends VideoState{}

class VideoUnplayableState extends VideoState{}
class VideoSuccessfulState extends VideoState{}
class VideoLoadingState extends VideoState{}
class VideoErrorState extends VideoState{
  String error;
  VideoErrorState(this.error);
}

class VideoInterruptedState extends VideoState{
  Restriction restriction;
  VideoInterruptedState(this.restriction);
}

