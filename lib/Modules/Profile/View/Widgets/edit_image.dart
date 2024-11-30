import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/profile_cubit.dart';
import 'package:talents/Modules/Home/View/Screens/image_viewer.dart';
import 'package:talents/Modules/Profile/View/Widgets/delete_user_image_dialog.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class EditImage extends StatelessWidget {
  const EditImage({
    super.key,
    required this.profileCubit,
  });

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:
          Alignment.bottomLeft, 
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: 35.w,
          height: 35.w,
          decoration: BoxDecoration(
            boxShadow: blueBoxShadow,
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: profileCubit.userPhotoFile != null
              ? Image.file(
                  fit: BoxFit.cover,
                  File(profileCubit.userPhotoFile!
                      .path)) // to show dialog in this case motier the image
              : profileCubit.userPhotoUrl != null
                  ? InkWell(
                      onTap: () {
                        pushTo(
                            context: context,
                            toPage: ImageViewer(
                                imageUrl:
                                    profileCubit.userPhotoUrl!));
                      },
                      child: CachedImage(
                          isPerson: true,
                          imageUrl: profileCubit.userPhotoUrl),
                    )
                  : IconButton(
                      onPressed: () {
                        profileCubit // to do
                            .showPicker(context);
    
                        profileCubit.editProfile();
                      },
                      icon: Icon(
                        Icons.add_photo_alternate,
                        size: 50.sp,
                        color: AppColors.secondary,
                      )),
        ),
        if (profileCubit.isEdit &&
            (profileCubit.userPhotoUrl != null ||
                profileCubit.userPhotoFile != null))
          ElasticIn(
            child: IconButton(
                style: IconButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(181, 0, 101, 190)),
                onPressed: () {
                  profileCubit.showPicker(context);
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                )),
          ),
        if (profileCubit.isEdit &&
            (profileCubit.userPhotoUrl != null ||
                profileCubit.userPhotoFile != null))
          Positioned(
              right: 0,
              child: ElasticIn(
                child: IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            162, 244, 67, 54)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              DeleteUserImageDialog(
                                  profileCubit: profileCubit));
                    },
                    icon: const Icon(
                      Icons.restore_from_trash,
                      color: Colors.white,
                    )),
              ))
      ],
    );
  }
}
