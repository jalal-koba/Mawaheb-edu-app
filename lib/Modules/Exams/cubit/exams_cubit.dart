import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Exams/models/exam.dart';

import 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {
  ExamsCubit() : super(ExamsInitState());

  static ExamsCubit get(context) => BlocProvider.of(context);
  List<Map<String, int>> selectedOptions = [];
  late Exam exam;
  num? time;

  bool isSolving = false;

  Future<void> getExam(
      {required int examId, required bool isSubscribed}) async {
    selectedOptions = [];
    emit(GetExamsLoadingState());
    try {
      final Response response =
          await Network.getData(url: Urls.getExam(id: examId));

      exam = Exam.fromJson(response.data['data']);

      if (exam.isSolving) {
        time = exam.remainingTime;
      } else {
        time = exam.minutes * 60;
      }

      for (int index = 0; index < exam.questions.length; index++) {
        selectedOptions.insert(
          index,
          {
            'question_id': exam.questions[index].id,
            'option_id': -1,
          },
        );
      }

      if (exam.result?.pass == null && isSubscribed && !exam.isSolving) {
        startExam(exam.id);
      }
      if (exam.result?.pass != null) {
        showOpenNextLessonButton = true;
      }

      emit(GetExamsSuccessState());
      // startExam(examId);
    } on DioException catch (e) {
      emit(GetExamsErrorState(message: exceptionsHandle(error: e)));
    } catch (e) {
      emit(GetExamsErrorState(message: e.toString()));
    }
  }

  Future<void> startExam(int examId) async {
    isSolving = true;
    emit(StartExamLoadingState());
    try {
      await Network.postData(
        url: '${Urls.studentExams}/$examId/create',
      );
      emit(StartExamSuccessState());
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        emit(StartExamErrorState(
            message: exceptionsHandle(error: e), isSolved: true));
      } else {
        emit(StartExamErrorState(message: exceptionsHandle(error: e)));
      }
    } catch (e) {
      emit(StartExamErrorState(message: e.toString()));
    }
  }

  Future<void> submitExam(int examId) async {
    emit(SubmitExamLoadingState());
    bool allQuestionSolved = true;
    for (var option in selectedOptions) {
      if (option['option_id'] == -1) {
        allQuestionSolved = false;
        break;
      }
    }
    if (!allQuestionSolved) {
      emit(SubmitExamErrorState(message: "يرجى حل جميع الأسئلة"));
      return;
    }
    try {
      final response = await Network.postData(
        url: '${Urls.studentExams}/$examId/store',
        data: {
          'answers': selectedOptions,
        },
      );

      if (response.data['data']['pass'] ?? true) {
        showOpenNextLessonButton = true;
        exam = Exam.fromJson(response.data['data']);

        isSolving = false;
        emit(SubmitExamSuccessState(success: true, exam: exam));
      } else {
        emit(SubmitExamSuccessState(
          success: false,
          message: response.data['data']['message'],
          result: response.data['data']['resault'],
        ));
      }
    } on DioException catch (e) {
      isSolving = false;
      emit(SubmitExamErrorState(message: exceptionsHandle(error: e)));
    }
    //  catch (error) {
    //   isSolving = false;
    //   emit(SubmitExamErrorState(message: "حدث خطأ ما"));
    // }
  }

  //
  bool showOpenNextLessonButton = false;

  Future<void> openNextLesson(int coursseId, int lessonId) async {
    emit(OpenNextLessonLoadingState());
    try {
      final Response response = await Network.postData(
          url: '${Urls.getSections}/$coursseId/lessons/$lessonId/open');
      emit(OpenNextLessonSuccessState(
          nextLessonId: response.data['data']['next_lesson_id']));
    } on DioException catch (error) {
      emit(OpenNextLessonErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(OpenNextLessonErrorState(message: "حدث خطأ ما"));
    }
  }
}
