import 'package:dio/dio.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Lessons/Cubit/lesson_state.dart';
import 'package:talents/Modules/Lessons/Models/lesson.dart';
import 'package:talents/Modules/Lessons/Models/lesson_response.dart'; 

class LessonCubit extends Cubit<LessonState> {
  LessonCubit() : super(LessonInitialState());
  bool showTestResult = false;

  static LessonCubit get(context) => BlocProvider.of(context);
 

  void showingTestResult(bool show) {
    showTestResult = show;
    emit(ShowingTestResultState());
  }

  late Lesson lesson;
 
  Future<void> getLesson({required int parentId, required int lessonId}) async {
    try {
      emit(GetLessonLoadingState());
      Response response = await Network.getData(
        url: Urls.lesson(parentId: parentId, lessonId: lessonId),
      );
      LessonResponse lessonResponse = LessonResponse.fromJson(response.data);

      lesson = lessonResponse.data;
 
      print("${lesson.videoUrl}aaaa ");
    

      emit(GetLessonSuccessState());
    } on DioException catch (e) {
      emit(GetLessonErrorState(message: exceptionsHandle(error: e)));
    }

      catch (error) {
      emit(GetLessonErrorState(message: "حدث خطأ ما"));
    }
  }
}
