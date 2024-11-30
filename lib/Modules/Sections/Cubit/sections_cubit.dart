import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Payments_Orders/Model/section.dart';
import 'package:talents/Modules/Sections/Cubit/sections_state.dart';
import 'package:talents/Modules/Sections/Model/one_section_response.dart';
import 'package:talents/Modules/Sections/Model/sections_response.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit() : super(SectionsInitialState());
  static SectionsCubit get(context) => BlocProvider.of(context);
    List<Section> sections=[];
  late List<Course> course;
  late String description;
  int page = 1;
  late OneSectionResponse oneSectionResponse;

  RefreshController refreshController = RefreshController();
  late SectionsResponse sectionsResponse;
  Future<void> getSections() async {
    if (page == 1) {
      emit(SectionsLoadingState());
    }
    try {
      Response response = await Network.getData(
        url: "${Urls.sections}?type=super&page=$page",
      );
      sectionsResponse = SectionsResponse.fromJson(response.data);

      if (page > 1) {
        sections.addAll(sectionsResponse.data.data);

        if (sectionsResponse.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        sections = sectionsResponse.data.data;
      }
      page = sectionsResponse.data.currentPage + 1;

      emit(SectionsSuccessState());
    } on DioException catch (error) {
      
        emit(SectionsErrorState(message: exceptionsHandle(error: error)));
       
    }

       catch (error) {
        emit(SectionsErrorState(message: "حدث خطأ ما"));
      }
  }

  Future<void> getOneSectionInfo({required int perantId}) async {
    if (page == 1) {
      emit(OneSectionLoadingState());
    }
    try {
      Response response = await Network.getData(
        url: "${Urls.sections}/$perantId?page=$page&type=courses",
      );
      oneSectionResponse = OneSectionResponse.fromJson(response.data);

      if (page > 1) {
        course.addAll(oneSectionResponse.data.data);

        if (oneSectionResponse.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        description = oneSectionResponse.parentSection.description;
        course = oneSectionResponse.data.data;
      }
      page = oneSectionResponse.data.currentPage + 1;

      emit(OneSectionSuccessState());
    } on DioException catch (error) {
    
        emit(SectionsErrorState(message: exceptionsHandle(error: error)));
      }
         catch (error) {
        emit(SectionsErrorState(message: "حدث خطأ ما"));
      }
   
  }
}
