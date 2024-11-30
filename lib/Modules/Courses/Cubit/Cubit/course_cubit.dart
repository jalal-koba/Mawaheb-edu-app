import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Courses/Cubit/States/course_state.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Courses/Model/course_response.dart';
import 'package:talents/Modules/Courses/Model/discount_response.dart';
import 'package:talents/Modules/Courses/Model/parent_section.dart';
import 'package:talents/Modules/Courses/Model/courses_response.dart';
import 'package:talents/Modules/Courses/Util/debouncer.dart';
import 'package:talents/Modules/Courses/View/Widgets/pick_image_sheet.dart';
import 'package:talents/Modules/Lessons/Models/lesson.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitialState());

  static CourseCubit get(context) => BlocProvider.of(context);

  TextEditingController discountCont = TextEditingController();

  late CourseInfoResponse oneCourseResponse;

  late List<Lesson> freeLessons;
  late List<Lesson> paidLessons;
  late List<Lesson> lessons;
  late List<Trainer> trainers;
  late int courseId;
  RefreshController refreshController = RefreshController();
  XFile? transactionImage;
  String? introVideo;
  Future<void> showPicker(BuildContext context) async {
    pickImageSheet(
        context: context,
        onTapGallery: () {
          _pickImage(ImageSource.gallery);
          Navigator.of(context).pop();
        },
        onTapCamera: () {
          _pickImage(ImageSource.camera);
          Navigator.of(context).pop();
        });

    emit(AddImageState());
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      transactionImage = pickedFile;
    }
    emit(AddImageState());
  }

  void removeImage() {
    transactionImage = null;
    emit(RemoveImageState());
  }

  Future<void> buyCourse() async {
    emit(BuyCourseLoadingState());

    try {
      FormData formData = FormData.fromMap({
        if (!isFree &&
            parentSection.discount != null &&
            parentSection.discount?.toInt() != 100)
          "image":
              await MultipartFile.fromFile(File(transactionImage!.path).path),
        "section_id": courseId,
        if (discountCont.text.isNotEmpty) "coupon": discountCont.text
      });

      await Network.postData(url: Urls.payCourse, data: formData);
      emit(BuyCourseSuccessState());
    } on DioException catch (error) {
      emit(BuyCourseErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(BuyCourseErrorState(message: "حدث خطأ ما"));
    }
  }

  late ParentSection parentSection;
  Future<void> getCourseInfo(
      {required int perantId, required String additional}) async {
    emit(CourseLoadingState());
    try {
      Response response = await Network.getData(
        url: Urls.oneCourseInfo(id: perantId, additional: additional),
      );

      oneCourseResponse = CourseInfoResponse.fromJson(response.data);

      freeLessons = oneCourseResponse.data?.freeLessons ?? [];

      paidLessons = oneCourseResponse.data?.paidLessons ?? [];
      lessons = oneCourseResponse.lessons;
      parentSection = oneCourseResponse.parentSection;
      courseId = parentSection.id;
      trainers = parentSection.teachers;
      introVideo = parentSection.introVideo;

      emit(CourseSuccessState());
    } on DioException catch (error) {
      emit(CourseErrorState(message: exceptionsHandle(error: error)));
    }
     catch (error) {
      emit(CourseErrorState(message: "حدث خطأ ما"));
    }
  }






  List<Course> courses = [];
  int page = 1;
  late CoursesResponse searchCoursessResponse;
  final TextEditingController searchFieldController = TextEditingController();
  Future<void> searchForCourse({String text = ""}) async {
    if (text.trim().isNotEmpty || text == "") {
      debouncer.run(() async {
        Response response;
        try {
          if (page == 1) {
            emit(SearchCourseLoading());
          }

          response = await Network.getData(
              url: "${Urls.courses}&page=$page&search=$text");
          searchCoursessResponse = CoursesResponse.fromJson(response.data);

          if (page > 1) {
            courses.addAll(searchCoursessResponse.data.data);
            if (searchCoursessResponse.data.data.isEmpty) {
              refreshController.loadNoData();
            } else {
              refreshController.loadComplete();
            }
          } else {
            courses = searchCoursessResponse.data.data;
          }
          page = searchCoursessResponse.data.currentPage + 1;

          emit(SearchCourseSuccess());
        } on DioException catch (error) {
          emit(SearchCourseError(message: exceptionsHandle(error: error)));
        } catch (error) {
          emit(SearchCourseError(message: "حدث خطأ ما"));
        }
      });
    }
  }

///// subscribed course

  List<Course> subscribedCourses = [];
  final Debouncer debouncer = Debouncer(milliseconds: 400);
  Future<void> getSubscribedCourses() async {
    try {
      if (page == 1) {
        emit(SubscribedCourseLoadingState());
      }

      Response response =
          await Network.getData(url: Urls.subscribedCourses(page: page));
      final CoursesResponse subscribedCourseResponse =
          CoursesResponse.fromJson(response.data);

      if (page > 1) {
        subscribedCourses.addAll(subscribedCourseResponse.data.data);

        if (subscribedCourseResponse.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        subscribedCourses = subscribedCourseResponse.data.data;
      }
      page = subscribedCourseResponse.data.currentPage + 1;

      emit(SubscribedCourseSuccessState());
    } on DioException catch (error) {
      emit(SubscribedCourseErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(SubscribedCourseErrorState(message: "حدث خطأ ما"));
    }
  }

  // subscribe in free course for free courses

  Future<void> subscribeInCourse({required int id}) async {
    try {
      emit(SubscribeInCourseLoadingState());
      await Network.postData(
          url: Urls.subscribeInFreeCourse, data: {"section_id": id});

      emit(SubscribeInCourseSuccessState());
    } on DioException catch (error) {
      emit(
          SubscribeInCourseErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(SubscribeInCourseErrorState(message: "حدث خطأ ما"));
    }
  }

  // latest courses
  List<Course> latestCourses = [];

  Future<void> getLatestCourses() async {
    try {
      if (page == 1) {
        emit(LatestCoursesLoadingState());
      }

      Response response =
          await Network.getData(url: "${Urls.courses}&latest=1&page=$page");
      final CoursesResponse latestCoursesResponse =
          CoursesResponse.fromJson(response.data);

      if (page > 1) {
        latestCourses.addAll(latestCoursesResponse.data.data);

        if (latestCoursesResponse.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        latestCourses = latestCoursesResponse.data.data;
      }
      page = latestCoursesResponse.data.currentPage + 1;

      emit(LatestCoursesSuccessState());
    } on DioException catch (error) {
      emit(LatestCoursesErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(LatestCoursesErrorState(message: "حدث خطأ ما"));
    }
  }

  //
  late DiscountResponse discountResponse;
  bool isFree = false;
  Future<void> checkCupon() async {
    emit(CheckCuponLoadingState());
    try {
      FormData formData = FormData.fromMap(
          {"coupon": discountCont.text.trim(), "section_id": courseId});
      final Response response =
          await Network.postData(url: Urls.checkCopun, data: formData);

      discountResponse = DiscountResponse.fromJson(response.data);

      if (discountResponse.errorMessage == null) {
        if (discountResponse.afterDiscount != null &&
            discountResponse.afterDiscount! == 100) {
          isFree = true;
        }
        emit(CheckCuponSuccessState(discountSuccess: true));
      } else {
        emit(CheckCuponSuccessState(
            discountSuccess: false,
            errorMessage: discountResponse.errorMessage));
      }
    } on DioException catch (error) {
      emit(CheckCuponErrorState(message: exceptionsHandle(error: error)));
    }
  }
}
