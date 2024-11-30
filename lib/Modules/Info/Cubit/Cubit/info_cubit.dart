import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Info/Cubit/states/contact_us_state.dart';
import 'package:talents/Modules/Info/Model/contact.dart';
import 'package:talents/Modules/Info/Model/info_response.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoInitialState());
  static InfoCubit get(context) => BlocProvider.of(context);

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  TextEditingController message = TextEditingController();

  FocusNode userNamefocusNode = FocusNode();
  FocusNode emailfocusNode = FocusNode();
  FocusNode phoneNumberfocusNode = FocusNode();
  FocusNode messagefocusNode = FocusNode();
  GlobalKey<FormState> formState = GlobalKey();

  bool loadingScial = false;

  Future<void> sendMessage() async {
    if (formState.currentState!.validate()) {
      emit(SendMessageLoadingState());
      FormData formData = FormData.fromMap({
        "name": userName.text,
        if (email.text.trim().isNotEmpty) "email": email.text,
        "phone": phoneNumber.text,
        "message": message.text,
      });

      try {
        await Network.postData(url: Urls.contactMessages, data: formData);
         emit(SendMessageSuccessState());
      } on DioException catch (error) {
        emit(SendMessageErrorState(message: exceptionsHandle(error: error)));
      } catch (error) {
        emit(SendMessageErrorState(message: "حدث خطأ ما"));
      }
    }
  }

  late Contact contact;
  late String info;
  late String? whoUsDescription;
  late String? whoUsImage;
  late InfoResponse infoResponse;
  Future<void> getInfo() async {
    // to do remove bool
    try {
      loadingScial = true;

      emit(InfoLoadingState());
      Response response = await Network.getData(url: Urls.infos);
      infoResponse = InfoResponse.fromJson(response.data);

      contact = infoResponse.contact;

      info = infoResponse.cash.info;

      whoUsDescription = infoResponse.whoUsDescription;
      whoUsImage = infoResponse.whoUsImage;
      loadingScial = false;
      emit(InfoSuccessState());
    } on DioException catch (error) {
      loadingScial = false;

      emit(InfoErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(InfoErrorState(message: "حدث خطأ ما"));
    }
  }
}
