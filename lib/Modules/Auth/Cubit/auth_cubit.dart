import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Auth/Model/confirm_otp.dart';
import 'package:talents/Modules/Auth/Model/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthCubitInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  bool isVerified = false;
  bool showOtpField = false;
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  UserModel? userModel;
  final TextEditingController emailORrhoneOrNameCont = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();

  final FocusNode emailORrhoneOrNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  Future<void> login() async {
    if (formState.currentState!.validate()) {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      emit(LoginLoadingState());
      try {
        Response response = await Network.postData(url: Urls.login, data: {
          "username": emailORrhoneOrNameCont.text,
          "password": passwordCont.text,
          'fcm_token': fcmToken,
        });

        userModel = UserModel.fromJson(response.data);

        AppSharedPreferences.saveToken("${userModel?.data?.user?.token}");
        // AppSharedPreferences.removeIsGuest();

        emit(LoginSuccessState());
      } on DioException catch (error) {
        emit(LoginErrorState(message: exceptionsHandle(error: error)));
      } catch (error) {
        emit(LoginErrorState(message: "حدث خطأ ما"));
      }
    }
  }

  //

  final TextEditingController userNamseCont = TextEditingController();
  final TextEditingController residencePlace = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController birthdayDate = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController phoneNumberCont = TextEditingController();

  final TextEditingController confirmPasswordCont = TextEditingController();

  final FocusNode userNamseContFocusNode = FocusNode();
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode residencePlaceFocusNode = FocusNode();
  final FocusNode emailContFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode passwordContFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  Future<void> createAccount() async {
    String? email;
    if (emailCont.text.isNotEmpty) {
      if (isVerified) {
        email = emailCont.text;
      } else {
        emit(SiginUpErrorState(
            message: "يرجى التحقق من البريد الإلكتروني أو عدم إدخاله"));
        return;
      }
    }

    if (formState.currentState!.validate()) {
      emit(SiginUpLoadingState());
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      try {
        Response response = await Network.postData(url: Urls.siginUp, data: {
          "username": userNamseCont.text.toString().trim(),
          "full_name": fullName.text.toString().trim(),
          if (email != null) "email": email,
          if (email != null) "verification_code": otpCode.text,
          "location": residencePlace.text.toString().trim(),
          "birth_date": birthdayDate.text.toString().trim(),
          "password": passwordCont.text.toString().trim(),
          "phone_number": phoneNumberCont.text.toString().trim(),
          'fcm_token': fcmToken,
        });
        emit(SiginUpSuccessState());

        userModel = UserModel.fromJson(response.data);
        print(userModel?.data?.user?.token);
        AppSharedPreferences.saveToken("${userModel?.data?.user?.token}");
        // AppSharedPreferences.removeIsGuest();
      } on DioException catch (e) {
        emit(SiginUpErrorState(message: exceptionsHandle(error: e)));
      } catch (error) {
        emit(SiginUpErrorState(message: "حدث خطأ ما"));
      }
    }
  }

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  final TextEditingController otpCode = TextEditingController();
  final GlobalKey<FormState> formStateRestPass = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFieldValidate = GlobalKey<FormState>();

  Future<void> getVerificationCode({String? email, required String  param}) async {
    emit(GetCodeLoadingState());
    try {
      await Network.postData(url: "${Urls.sendVerificationCode}?$param", data: {
        "email": email ?? emailCont.text,
      });

      emit(GetCodeSuccessState());
    } on DioException catch (error) {
      emit(GetCodeErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(GetCodeErrorState(message: "حدث خطأ ما"));
    }
  }

  void verifyEmail(Map? params) {
    isVerified = params?['isVerified'] ?? false;
    otpCode.text = params?['code'] ?? "";

    emit(EmailVerifiedState());
  }


  ConfirmOTP? confirmOTPmodel;

  Future<void> checkCode({required String email, required String param}) async {
    emit(CheckCodeLoadingState());
    try {
      Response response = await Network.postData(
          url: "${Urls.checkVerificationCode}?$param",
          data: {"email": email, "verification_code": otpCode.text});
      confirmOTPmodel = ConfirmOTP.fromJson(response.data);

      emit(CheckCodeSuccessState(isValid: confirmOTPmodel!.data!.isValid!));
    } on DioException catch (error) {
      emit(CheckCodeErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(CheckCodeErrorState(message: "حدث خطأ ما"));
    }
  }

//
  Future<void> restPassword(
      {required String email, required String verificationCode}) async {
    if (formStateRestPass.currentState!.validate()) {
      emit(ResetPasswordLoadingState());
      try {
        await Network.postData(url: Urls.restPassword, data: {
          "email": email,
          "verification_code": verificationCode,
          "password": newPassword.text,
          "password_confirmation": confirmNewPassword.text
        });

        emit(ResetPasswordSuccessState());
      } on DioException catch (error) {
        emit(RestPasswordErrorState(message: exceptionsHandle(error: error)));
      } catch (error) {
        emit(RestPasswordErrorState(message: "حدث خطأ ما"));
      }
    }
  }

//
  Future<void> logout() async {
    emit(LogoutLoadingState());
    try {
      await Network.postData(
        url: Urls.logout,
      );

      emit(LogoutSuccessState());

      AppSharedPreferences.removeToken;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        emit(LogoutErrorState(
            message: error.response?.data['message'], code: 401));
      } else {
        emit(LogoutErrorState(message: exceptionsHandle(error: error)));
      }
    } catch (error) {
      emit(LogoutErrorState(message: "حدث خطأ ما"));
    }
  }

  final TextEditingController oldPassword = TextEditingController();

  final GlobalKey<FormState> changeFormKey = GlobalKey<FormState>();

  Future<void> changePassword() async {
    if (changeFormKey.currentState!.validate()) {
      emit(ChangePasswordLoadingState());
      FormData formData = FormData.fromMap({
        "_method": "PUT",
        "old_password": oldPassword.text,
        "password": newPassword.text,
        "password_confirmation": confirmNewPassword.text,
      });
      try {
        await Network.postData(url: Urls.changePassword, data: formData);
        oldPassword.text = "";
        newPassword.text = "";
        confirmNewPassword.text = "";
        emit(ChangePasswordSuccessState());
      } on DioException catch (e) {
        emit(ChangePasswordErrorState(message: exceptionsHandle(error: e)));
      } catch (error) {
        emit(ChangePasswordErrorState(message: "حدث خطأ ما"));
      }
    }
  }

  void changeVerifiedEmail() {
    emailCont.text = "";
    otpCode.text = "";
    isVerified = false;
    emit(ChangeVerifiedEmailState());
  }

  Future<void> changeEmail({required ProfileCubit profileCubit}) async {
    emit(ChangeEmailLoadingState());
    try {
      await Network.postData(url: Urls.changeEmail, data: {
        "email": emailCont.text.trim(),
        "verification_code": otpCode.text
      });

      emit(ChangeEmailSuccessState());
    } on DioException catch (e) {
      emit(ChangeEmailErrorState(message: exceptionsHandle(error: e)));
    }
  }
}
