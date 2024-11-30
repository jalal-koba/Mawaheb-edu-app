import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Certificate/Cubit/cubit/certificate_cubit.dart';
import 'package:talents/Modules/Courses/Cubit/Cubit/course_cubit.dart';
import 'package:talents/Modules/Courses/Cubit/States/course_state.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Courses/Model/course_response.dart';
import 'package:talents/Modules/Lessons/Models/lesson.dart';
import 'package:talents/Modules/Lessons/View/Widgets/lesson_card.dart';
import 'package:talents/Modules/Lessons/View/lesson_screen.dart';
import 'package:talents/Modules/Exams/View/screens/final_exam_screen.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';
import 'package:talents/Modules/video/video_cubit.dart';
import 'package:talents/Modules/video/video_state.dart';
import 'package:talents/Modules/video/video_widget.dart';
import 'package:talents/Modules/Youtube/youtube_cubit.dart';
import '../Widgets/Payment_Dialogs/discount_dialog.dart';
import '../../../Trainers/View/Widgets/trainer_in_course.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({
    super.key,
    required this.tag,
    required this.course,
  });
  final String tag;
  final Course course;
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late CourseCubit oneCourseCubitProvider;
  @override
  void initState() {
    oneCourseCubitProvider = CourseCubit()
      ..getCourseInfo(
          perantId: widget.course.id,
          additional: widget.course.subscribed ? "" : "separated=1");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: widget.course.name,
        body: BlocProvider(
          create: (context) => oneCourseCubitProvider,
          child: BlocConsumer<CourseCubit, CourseState>(
            listener: (context, state) {
              if (state is SubscribeInCourseErrorState) {
                customSnackBar(
                    context: context, success: 0, message: state.message);
              } else if (state is SubscribeInCourseSuccessState) {
                customSnackBar(
                    context: context, success: 1, message: "تم الاشتراك بنجاح");

                widget.course.subscribed = true;
                oneCourseCubitProvider.getCourseInfo(
                    additional: widget.course.subscribed ? "" : "separated=1",
                    perantId: widget.course.id);
              }
            },
            builder: (context, state) {
              final CourseCubit oneCourseCubit = CourseCubit.get(context);

              if (state is CourseErrorState) {
                return TryAgain(
                  message: state.message,
                  onTap: () {
                    oneCourseCubit.getCourseInfo(
                        additional:
                            widget.course.subscribed ? "" : "separated=1",
                        perantId: widget.course.id);
                  },
                );
              }

              if (state is CourseLoadingState) {
                return const AppLoading();
              }

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    child: CustomScrollView(slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            _IntroVideo(
                                oneCourseCubit: oneCourseCubit,
                                courseScreen: widget),
                            _CourseInfo(
                                widget: widget, oneCourseCubit: oneCourseCubit),
                          ],
                        ),
                      ),
                      _SliverTitle(
                        showTitle: oneCourseCubit.trainers.isNotEmpty,
                        lessonsTitle: 'المدربين',
                      ),
                      _TrainersInCourse(oneCourseCubit: oneCourseCubit),
                      _SliverTitle(
                        showTitle: oneCourseCubit.lessons.isNotEmpty,
                        lessonsTitle: 'الجلسات',
                      ),
                      _LessonsList(
                        oneCourseCubit: oneCourseCubit,
                        course: widget.course,
                        lessons: oneCourseCubit.lessons,
                      ),
                      _SliverTitle(
                        showTitle: oneCourseCubit.freeLessons.isNotEmpty,
                        lessonsTitle: 'الجلسات المجانية',
                      ),
                      _LessonsList(
                        oneCourseCubit: oneCourseCubit,
                        course: widget.course,
                        lessons: oneCourseCubit.freeLessons,
                      ),
                      _SliverTitle(
                        showTitle: oneCourseCubit.paidLessons.isNotEmpty,
                        lessonsTitle: 'الجلسات المغلقة',
                      ),
                      _LessonsList(
                        oneCourseCubit: oneCourseCubit,
                        course: widget.course,
                        lessons: oneCourseCubit.paidLessons,
                      ),
                      if (widget.course.subscribed)
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.h),
                              _FinalExamButton(
                                  oneCourseCubit: oneCourseCubit,
                                  course: widget.course),
                              SizedBox(height: 2.h),
                              _ApplyToCertificateButton(
                                  oneCourseCubit: oneCourseCubit,
                                  onSuccessApplyToCertificate: () {
                                    oneCourseCubit.getCourseInfo(
                                        additional: widget.course.subscribed
                                            ? ""
                                            : "separated=1",
                                        perantId: widget.course.id);
                                  },
                                  course: widget.course),
                            ],
                          ),
                        ),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 2.h + (!widget.course.subscribed ? 10.h : 0),
                      ))
                    ]),
                  ),
                  _BuyCourseButton(
                    oneCourseCubit: oneCourseCubit,
                    course: widget.course,
                    state: state,
                  ),
                ],
              );
            },
          ),
        ));
  }
}

class _BuyCourseButton extends StatelessWidget {
  const _BuyCourseButton({
    required this.oneCourseCubit,
    required this.course,
    required this.state,
  });

  final CourseCubit oneCourseCubit;
  final Course course;
  final CourseState state;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !course.subscribed,
      child: Positioned(
          bottom: 3.h,
          child: Builder(builder: (context) {
            if (state is SubscribeInCourseLoadingState) {
              return const AppLoading();
            }
            return CustomButton(
                width: 90,
                titlebutton:
                    oneCourseCubit.parentSection.isFree ? "اشتراك" : "شراء",
                onPressed: () {
                  if (AppSharedPreferences.hasToken) {
                    if (oneCourseCubit.parentSection.isFree) {
                      oneCourseCubit.subscribeInCourse(
                          id: oneCourseCubit.parentSection.id);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => SlideInDown(
                          duration: const Duration(milliseconds: 400),
                          child: DiscountDialog(
                            oneCourseCubit: oneCourseCubit,
                          ),
                        ),
                      );
                    }
                  } else {
                    customSnackBar(
                        context: context,
                        success: -1,
                        message: "يرجى تسجيل الدخول إلى التطبيق");
                  }
                });
          })),
    );
  }
}

class _ApplyToCertificateButton extends StatelessWidget {
  const _ApplyToCertificateButton({
    required this.oneCourseCubit,
    required this.course,
    required this.onSuccessApplyToCertificate,
  });

  final CourseCubit oneCourseCubit;
  final Course course;
  final Function() onSuccessApplyToCertificate;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CertificateCubit(),
      child: BlocConsumer<CertificateCubit, CertificateState>(
        listener: (context, state) {
          if (state is PostCertificateErrorState) {
            customSnackBar(
                context: context, success: 0, message: state.message);
          }

          if (state is PostCertificateSuccessState) {
            Course.refreshPrevScreen = true;
            customSnackBar(
                context: context, success: 1, message: "تم تسجيل طلبك بنجاح");
            onSuccessApplyToCertificate();
          }
        },
        builder: (context, state) {
          final Certificate? certificate =
              oneCourseCubit.oneCourseResponse.certificate;
          if (state is PostCertificateLoadingState) {
            return const AppLoading();
          }
          if (certificate?.status == "pending") {
            return const CustomButton(
              titlebutton: "بانتظار الشهادة",
              onPressed: null,
              background: AppColors.secondary,
            );
          }
          if (certificate?.status == "rejected") {
            return CustomButton(
              titlebutton: "تم رفض الشهادة",
              onPressed: () {
                customSnackBar(
                  context: context,
                  success: 2,
                  message: "${certificate?.note}",
                );
              },
              background:  Colors.red[600],
            );
          }

          if (certificate?.status == "accepted") {
            return CustomButton(
              titlebutton: "تحميل الشهادة",
              onPressed: () async {
                await EasyLauncher.url(
                    url: "${Urls.storageBaseUrl}${certificate?.file}");
              },
            );
          }

          return CustomButton(
            background: oneCourseCubit.oneCourseResponse.canApplyForCertificate
                ? null
                : Colors.grey[400],
            titlebutton: "الحصول على الشهادة",
            onPressed: () {
              if (oneCourseCubit.oneCourseResponse.canApplyForCertificate) {
                context
                    .read<CertificateCubit>()
                    .postCertificateRequest(courseId: course.id);
              }
            },
          );
        },
      ),
    );
  }
}

class _FinalExamButton extends StatelessWidget {
  const _FinalExamButton({
    required this.oneCourseCubit,
    required this.course,
  });

  final CourseCubit oneCourseCubit;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: oneCourseCubit.oneCourseResponse.finalExamId != null,
      child: CustomButton(
        background: oneCourseCubit.oneCourseResponse.canSolveFinalExam
            ? null
            : Colors.grey[400],
        titlebutton: "الاختبار النهائي",
        onPressed: () async {
          if (oneCourseCubit.oneCourseResponse.canSolveFinalExam) {
            await pushTo(
                context: context,
                toPage: FinalExamScreen(
                    course: course,
                    examId: oneCourseCubit.oneCourseResponse.finalExamId!));
            if (course.refreshCourseScreen) {
              oneCourseCubit.getCourseInfo(
                  additional: course.subscribed ? "" : "separated=1",
                  perantId: course.id);
            }
          } else {
            customSnackBar(
                context: context,
                success: 2,
                message: "يرجى الانتهاء من دراسة الكورس أولاً");
          }
        },
      ),
    );
  }
}

class _LessonsList extends StatelessWidget {
  const _LessonsList({
    required this.oneCourseCubit,
    required this.course,
    required this.lessons,
  });

  final CourseCubit oneCourseCubit;

  final Course course;
  final List<Lesson> lessons;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 0.6.w),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 1.2.h, crossAxisSpacing: 2.4.w),
        itemBuilder: (context, index) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              if (lessons[index].isOpen) {
                await pushTo(
                  context: context,
                  toPage: LessonScreen(
                    course: course,
                    lessonId: lessons[index].id,
                  ),
                );

                // if happen chagees in lesson screen (open lesson from lesson-screen, so we should refresh this screen )
                if (course.refreshCourseScreen) {
                  oneCourseCubit.getCourseInfo(
                      additional: course.subscribed ? "" : "separated=1",
                      perantId: course.id);
                }
              }
            },
            child: Hero(
              tag: "tag${lessons[index].id}",
              child: LessonCard(lesson: lessons[index]),
            ),
          );
        },
        itemCount: lessons.length,
      ),
    );
  }
}

class _SliverTitle extends StatelessWidget {
  const _SliverTitle({
    required this.showTitle,
    required this.lessonsTitle,
  });

  final bool showTitle;
  final String lessonsTitle;
  @override
  Widget build(BuildContext context) {
    if (showTitle) {
      return SliverPadding(
        padding: EdgeInsets.only(top: 2.h, bottom: 1.5),
        sliver: SliverToBoxAdapter(
          child: Text(
            lessonsTitle,
            style:
                AppTextStyles.meduimTitle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox());
  }
}

class _IntroVideo extends StatefulWidget {
  const _IntroVideo({
    required this.oneCourseCubit,
    required this.courseScreen,
  });

  final CourseCubit oneCourseCubit;
  final CourseScreen courseScreen;

  @override
  State<_IntroVideo> createState() => _IntroVideoState();
}

class _IntroVideoState extends State<_IntroVideo> {
  VideoCubit videoCubit = VideoCubit();

  @override
  void dispose() {
    videoCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.oneCourseCubit.introVideo == null) {
      return const SizedBox();
    }

    return Hero(
        tag: widget.courseScreen.tag,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BlocProvider(
              lazy: false,
              create: (context) => videoCubit
                ..setStreams([
                  MyVideo(
                      link:
                          "${Urls.storageBaseUrl}${widget.oneCourseCubit.introVideo!}",
                      value: 0,
                      quality: "")
                ])
                ..initFromNetwork2(0, Duration.zero),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: BlocBuilder<VideoCubit, VideoState>(
                  builder: (context, state) {
                    if (state is VideoLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }
                    if (state is VideoErrorState) {
                      return TryAgain(
                        message: state.error,
                        onTap: () {
                          videoCubit
                            ..setStreams([
                              MyVideo(
                                  link:
                                      "${Urls.storageBaseUrl}${widget.oneCourseCubit.introVideo!}",
                                  value: 0,
                                  quality: "")
                            ])
                            ..initFromNetwork2(0, Duration.zero);
                        },
                      );
                    }

                    return VideoWidget2(
                      videoCubit: context.read<VideoCubit>(),
                    );
                  },
                ),
              ),
            )));
  }
}

///////////
class _CourseInfo extends StatelessWidget {
  const _CourseInfo({
    required this.widget,
    required this.oneCourseCubit,
  });

  final CourseScreen widget;
  final CourseCubit oneCourseCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          widget.course.isFree ? "مجاناً" : "${widget.course.price}  ل.س",
          style: AppTextStyles.meduimTitle
              .copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          children: <Widget>[
            Text(
              'شرح الكورس',
              style: AppTextStyles.largeTitle
                  .copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              '${oneCourseCubit.parentSection.totalLessonsTime}',
              style: AppTextStyles.largeTitle
                  .copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(height: 1.5.h),
        Text(
            style: AppTextStyles.explanatoryText,
            oneCourseCubit.parentSection.description),
        SizedBox(height: 1.h),
      ],
    );
  }
}

//
class _TrainersInCourse extends StatelessWidget {
  const _TrainersInCourse({
    required this.oneCourseCubit,
  });

  final CourseCubit oneCourseCubit;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) => Align(
        alignment: Alignment.center,
        child: TrainerInCourse(
          trainer: oneCourseCubit.trainers[index],
        ),
      ),
      itemCount: oneCourseCubit.trainers.length,
    );
  }
}
