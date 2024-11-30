import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Trainers/Cubit/trainers_state.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart';
import 'package:talents/Modules/Trainers/Model/trainer_info_response.dart';
import 'package:talents/Modules/Trainers/Model/trainer_response.dart';

class TrainersCubit extends Cubit<TrainerState> {
  TrainersCubit() : super(TrainerInitialState());
  static TrainersCubit get(context) => BlocProvider  .of(context);
  late TrainersResponse trainersResponse;
  late List<Trainer> trainers;
  RefreshController refreshController = RefreshController();
  int page = 1;
  late String fullName, description;
  String? imageUrl;
  late List<Course> courses;
  Future<void> getTrainers() async {
    try {
      if (page == 1) {
        emit(TrainerLoadingState());
      }
      Response response = await Network.getData(
        url: "${Urls.trainers}?page=$page",
      );

      trainersResponse = TrainersResponse.fromJson(response.data);

      if (page > 1) {
        trainers.addAll(trainersResponse.data);
        if (trainersResponse.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        trainers = trainersResponse.data;
      }
      page = trainersResponse.currentPage + 1;

      emit(TrainerSuccessState());
      // to doo test
    } on DioException catch (error) {
      emit(TrainerErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(TrainerErrorState(message: "حدث خطأ ما"));
    }
  }

  late TrainerInfoResponse trainerInfoResponse;
  Future<void> getTrainerInfo(int id) async {
    try {
      emit(TrainerLoadingState());

      Response response = await Network.getData(url: "${Urls.trainers}/$id");

      trainerInfoResponse = TrainerInfoResponse.fromJson(response.data);

      fullName = trainerInfoResponse.data.fullName;
      imageUrl = trainerInfoResponse.data.image;
      description = trainerInfoResponse.data.description ?? "";
      courses = trainerInfoResponse.data.courses;
      emit(TrainerSuccessState());
    } on DioException catch (error) {
      emit(TrainerErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(TrainerErrorState(
        message: "حدث خطأ ما",
      ));
    }
  }
}
