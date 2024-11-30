import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Home/Cubit/state/home_state.dart';
import 'package:talents/Modules/Home/Model/home_response.dart';
import 'package:talents/Modules/Offers/Models/offer.dart';
import 'package:talents/Modules/Payments_Orders/Model/section.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Offer> offers = [];
  List<Trainer> trainers = [];
  List<Section> sections = [];
  List<Course> latestCourses = [];

  static String ownerInfo = "";
  bool showTrainerInHome = true;
  late HomeResponse homeResponse;
  final RefreshController refreshController = RefreshController();

  String? libraryDescription = '';
  String? libraryImage = '';

  Future<void> getHomeInfo() async {
    emit(HomeLoadingState());

    try {
      Response response = await Network.getData(
        url: Urls.home,
      );

      homeResponse = HomeResponse.fromJson(response.data);

      offers = homeResponse.data.offers.data;
      trainers = homeResponse.data.instructors.data;
      sections = homeResponse.data.sections.data;
      latestCourses = homeResponse.data.courses.data;

      libraryImage = homeResponse.data.dataLibrary.image;

      libraryDescription = homeResponse.data.dataLibrary.description;

      ownerInfo = homeResponse.data.ownerInfo;
      emit(HomeSuccessState());
    } on DioException catch (error) {
      emit(HomeErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(HomeErrorState(message: "حدث خطأ ما"));
    }
  }
}
