import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Offers/Cubit/offers_state.dart';
import 'package:talents/Modules/Offers/Models/offers_response.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitialState());
  bool showPassword = true;
  List offers = [];

  int page = 1;

  RefreshController refreshController = RefreshController();

  static OffersCubit get(BuildContext context) => BlocProvider.of(context);

  OffersResponse? offersResponse;

  Future<void> getOffers() async {
    Response response;
    try {
      if (page == 1) {
        emit(OffersLoadingState());
      }

      response = await Network.getData(url: "${Urls.offers}?page=$page");
      offersResponse = OffersResponse.fromJson(response.data);

      if (page > 1) {
        offers.addAll(offersResponse!.data);
        if (offersResponse!.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        offers = offersResponse!.data;
      }
      page = offersResponse!.currentPage + 1;

      print(offers.length);

      emit(OffersSuccessState());
    } on DioException catch (error) {
    
        emit(OffersErrorState(message: exceptionsHandle(error: error)));
     
    }

        catch (error) {
        emit(OffersErrorState(message: "حدث خطأ ما"));
      }
  }
}
