import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Certificate/Model/certificate_order.dart';
import 'package:talents/Modules/Certificate/Model/certificate_response.dart';

part 'certificate_state.dart';

class CertificateCubit extends Cubit<CertificateState> {
  CertificateCubit() : super(CertificateInitialState());
  static CertificateCubit get(context) => BlocProvider.of(context);
  List<CertificateOrder> allOrders = [];
  List<CertificateOrder> acceptedOrders = [];
  List<CertificateOrder> pendingOrders = [];
  List<CertificateOrder> rejectedOrders = [];
  Future<void> getCertificates() async {
    try {
      emit(CertificateLoadingState());
      final Response response =
          await Network.getData(url: Urls.certificateRequests);

      final CertificateResponse certificateResponse =
          CertificateResponse.fromJson(response.data);

      allOrders = certificateResponse.data;
      for (CertificateOrder order in allOrders) {
        switch (order.status) {
          case "accepted":
            acceptedOrders.add(order);
            break;

          case "pending":
            pendingOrders.add(order);
            break;

          case "rejected":
            rejectedOrders.add(order);
            break;
        }
      }
      emit(CertificateSuccessState());
    } on DioException catch (error) {
      emit(CertificateErrorState(message: exceptionsHandle(error: error)));
    }
     catch (error) {
      emit(CertificateErrorState(message: "حدث خطأ ما"));
    }
  }

  Future<void> postCertificateRequest({required int courseId }) async {
    try {
      emit(PostCertificateLoadingState());

      await Network.postData(url: Urls.postCertificateRequest,data:  {"course_id":courseId});

      emit(PostCertificateSuccessState());
    } on DioException catch (error) {
      emit(PostCertificateErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(PostCertificateErrorState(message: "حدث خطأ ما"));
    }
  }


   
}
