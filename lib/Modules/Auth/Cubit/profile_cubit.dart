import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Auth/Cubit/profile_state.dart';
import 'package:talents/Modules/Profile/Model/profile_response.dart';
import 'package:talents/Modules/Profile/Model/update_profile_response.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());
  bool isEdit = false;
  bool removeImage = false;
  ProfileResponse? profileResponse;
  static ProfileCubit get(context) => BlocProvider.of(context);
  File? userPhotoFile;
  String? userPhotoUrl;
  final TextEditingController userNamseCont = TextEditingController();
  final TextEditingController residencePlace = TextEditingController();
  final TextEditingController birthdayDate = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController phoneNumberCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController()
    ..text = "**********";

  final FocusNode emailContFocusNode = FocusNode();
  final FocusNode residencePlaceFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void editProfile() {
    isEdit = true;
    emit(ProfileEditingStart());
  }

  UpdateProfileResponse? updateProfileResponse; // to do move to auth folder

  Future<void> showPicker(BuildContext context) async {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'اختر من المعرض',
                    style: AppTextStyles.meduimTitle
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    await _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: AppColors.primary,
                  ),
                  title: Text('التقط صورة',
                      style: AppTextStyles.meduimTitle
                          .copyWith(fontWeight: FontWeight.w500)),
                  onTap: () async {
                    await _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      userPhotoFile = File(pickedFile.path);
      emit(ProfileEditingStart());
      print("image taken ");
    }
  }

  Future<void> getProfileInfo() async {
    emit(ProfileLoadingState());

    try {
      final response = await Network.getData(url: Urls.profileInfo);

      profileResponse = ProfileResponse.fromJson(response.data);

      print(profileResponse!.data.username);
      print(profileResponse!.data.email);
      userNamseCont.text = profileResponse!.data.username;
      fullName.text = profileResponse!.data.fullName;
      birthdayDate.text = profileResponse!.data.birthdayDate;
      residencePlace.text = profileResponse!.data.residencePlace;

      emailCont.text = profileResponse!.data.email;
      phoneNumberCont.text = profileResponse!.data.phoneNumber;
      userPhotoUrl = profileResponse!.data.image;
      emit(ProfileSucscssState());
    } on DioException catch (error) {
      print(error.response?.statusCode);
      if (error.response?.statusCode == 401) {
        emit(UnAuthenticatedState());
      }

      emit(ProfileErrorState(message: exceptionsHandle(error: error)));
    }
  }

  Future<void> updateProfile() async {
    try {
      emit(ProfileEditingLoadingState());

      FormData formData = FormData.fromMap({
        if (userPhotoFile != null)
          "image": await MultipartFile.fromFile(
            userPhotoFile!.path,
          ),
        if (removeImage) "image": null,
        "username": userNamseCont.text,
        "full_name": fullName.text,
        "location": residencePlace.text,
        "birth_date": birthdayDate.text,
        "phone_number": phoneNumberCont.text,
        "_method": "PUT"
      });

      Response response =
          await Network.postData(url: Urls.updateProfile, data: formData);

      updateProfileResponse = UpdateProfileResponse.fromJson(response.data);

      residencePlace.text = updateProfileResponse!.data.residencePlace;

      userNamseCont.text = updateProfileResponse!.data.username;
      fullName.text = updateProfileResponse!.data.fullName;
      birthdayDate.text = updateProfileResponse!.data.birthdayDate;
      emailCont.text = updateProfileResponse!.data.email;
      phoneNumberCont.text = updateProfileResponse!.data.phoneNumber;
      userPhotoUrl = updateProfileResponse!.data.image;

      isEdit = false;
      removeImage = false;
      userPhotoFile = null;
      emit(ProfileEditingSuccessState());
    } on DioException catch (e) {
      emit(ProfileEditingErrorState(message: exceptionsHandle(error: e)));
    }
    catch (error) {
      emit(ProfileErrorState(message: "حدث خطأ ما"));
    }
  }
}
