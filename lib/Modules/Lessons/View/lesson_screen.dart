import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Exams/cubit/exams_cubit.dart';
import 'package:talents/Modules/Exams/cubit/exams_state.dart';
import 'package:talents/Modules/Lessons/Cubit/lesson_cubit.dart';
import 'package:talents/Modules/Lessons/Cubit/lesson_state.dart';
import 'package:talents/Modules/Lessons/View/Widgets/attached_file.dart';
import 'package:talents/Modules/Exams/View/screens/exam_screen.dart';
import 'package:talents/Modules/Lessons/View/Widgets/lesson_shimmer.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';

import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';
import 'package:talents/Modules/video/video_cubit.dart';
import 'package:talents/Modules/video/video_state.dart';
import 'package:talents/Modules/video/video_widget.dart';

class LessonScreen extends StatefulWidget {
  LessonScreen({
    super.key,
    required this.lessonId,
    required this.course,
  });

  int lessonId;
  final Course course;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    widget.course.refreshCourseScreen = false;
    return AppScaffold(
      title: "الجلسة",
      body: BlocProvider(
        create: (context) => LessonCubit()
          ..getLesson(parentId: widget.course.id, lessonId: widget.lessonId),
        child: BlocBuilder<LessonCubit, LessonState>(
          builder: (context, state) {
            final LessonCubit lessonCubit = LessonCubit.get(context);

            if (state is GetLessonLoadingState) {
              return const LessonShimmer();
            }
            if (state is GetLessonErrorState) {
              return TryAgain(
                  message: state.message,
                  onTap: () {
                    lessonCubit.getLesson(
                        parentId: widget.course.id, lessonId: widget.lessonId);
                  });
            }

            return ListView(
              padding: EdgeInsets.only(bottom: 2.h),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),
                    _LessonName(lessonCubit: lessonCubit),
                    SizedBox(height: 1.h),
                    _LessonVideo(
                        course: widget.course, lessonCubit: lessonCubit),
                    SizedBox(height: 2.5.h),
                    _LessonDescription(lessonCubit: lessonCubit),
                    SizedBox(height: 2.h),
                    _AttachedFiles(lessonCubit: lessonCubit),
                    _ExamLayer(lessonCubit: lessonCubit, widget: widget),
                    SizedBox(height: 2.h),
                    _NextLessonLayer(lessonCubit: lessonCubit, widget: widget)
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LessonDescription extends StatelessWidget {
  const _LessonDescription({
    required this.lessonCubit,
  });

  final LessonCubit lessonCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              style: AppTextStyles.explanatoryText,
              lessonCubit.lesson.description),
          SizedBox(
            height: 2.h,
          ),
          if (lessonCubit.lesson.time != null)
            Text(
                style: AppTextStyles.meduimTitle
                    .copyWith(color: AppColors.buttonColor),
                " مدة الدرس: ${lessonCubit.lesson.time!}"),
        ],
      ),
    );
  }
}

class _LessonName extends StatelessWidget {
  const _LessonName({
    required this.lessonCubit,
  });

  final LessonCubit lessonCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        lessonCubit.lesson.name,
        style: AppTextStyles.meduimTitle.copyWith(
            color: AppColors.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _NextLessonLayer extends StatelessWidget {
  const _NextLessonLayer({
    required this.lessonCubit,
    required this.widget,
  });

  final LessonCubit lessonCubit;
  final LessonScreen widget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (((lessonCubit.lesson.nextLessonId != null &&
                  lessonCubit.lesson.nextLessonId != -1) ||
              ((lessonCubit.lesson.nextLessonId == null) &&
                  ((lessonCubit.lesson.exam == null) ||
                      (lessonCubit.lesson.exam?.result?.pass != null)))) &&
          widget.course.subscribed),

      // if unsubscribed in course  dont show neither move-to-next-lesson nor open-next-lesson
      // if next-lesson-id =-1 means there are no lesson still
      // if next-lesson-id =null means the next lesson is closed
      // if exam = null we should open next lesson because this lesson dosent contain exam
      // we open next lesson dosent opened from backed automatically
      // so, if  (lessonCubit.lesson.nextLessonId != null &&lessonCubit.lesson.nextLessonId != -1) we should move to next lesson without use open next lesson api

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: BlocProvider(
          lazy: false,
          create: (context) => ExamsCubit(),
          child: BlocConsumer<ExamsCubit, ExamsState>(
            listener: (context, state) {
              if (state is OpenNextLessonErrorState) {
                customSnackBar(
                    context: context, success: 0, message: state.message);
              }
              if (state is OpenNextLessonSuccessState) {
                widget.course.refreshCourseScreen = true;
                widget.lessonId = state.nextLessonId;
                lessonCubit.getLesson(
                    parentId: widget.course.id, lessonId: widget.lessonId);
              }
            },
            builder: (context, state) {
              final ExamsCubit examsCubit = ExamsCubit.get(context);
              if (state is OpenNextLessonLoadingState) {
                return const AppLoading();
              }
              return CustomButton(
                titlebutton: lessonCubit.lesson.nextLessonId != null &&
                        lessonCubit.lesson.nextLessonId != -1
                    ? "الانتقال إلى الدرس التالي"
                    : "فتح الدرس التالي",
                onPressed: () async {
                  if (lessonCubit.lesson.nextLessonId != null &&
                      lessonCubit.lesson.nextLessonId != -1) {
                    widget.lessonId = lessonCubit.lesson.nextLessonId!;
                    lessonCubit.getLesson(
                        parentId: widget.course.id, lessonId: widget.lessonId);
                  } else {
                    examsCubit.openNextLesson(
                        widget.course.id, widget.lessonId);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ExamLayer extends StatelessWidget {
  const _ExamLayer({
    required this.lessonCubit,
    required this.widget,
  });

  final LessonCubit lessonCubit;
  final LessonScreen widget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: lessonCubit.lesson.exam != null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: CustomButton(
            titlebutton: lessonCubit.lesson.exam?.result?.pass != null
                ? "عرض نتيجة الاختبار"
                : "بدء الاختبار",
            onPressed: () async {
              final Map? map = await pushTo(
                context: context,
                toPage: ExamScreen(
                  course: widget.course,
                  lesson: lessonCubit.lesson,
                ),
              );

              if (map?['id'] != null) {
                print("${map?['id']} new new ");
                // this mean user open next lesson
                widget.course.refreshCourseScreen =
                    true; //so we need to refresh this page with new lesson and open the lesson in coures screen
                widget.lessonId = map!['id']!;
                lessonCubit.getLesson(
                    parentId: widget.course.id, lessonId: widget.lessonId);
                return;
              }

              if (lessonCubit.lesson.refreshLessonScreen) {
                lessonCubit.getLesson(
                    parentId: widget.course.id, lessonId: widget.lessonId);
              }
            }),
      ),
    );
  }
}

class _AttachedFiles extends StatelessWidget {
  const _AttachedFiles({
    required this.lessonCubit,
  });

  final LessonCubit lessonCubit;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: lessonCubit.lesson.files.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'الملفات المرفقة',
              style: AppTextStyles.meduimTitle
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 15.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lessonCubit.lesson.files.length,
              itemBuilder: (context, index) => AttachedFile(
                file: lessonCubit.lesson.files[index],
              ),
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }
}

class _LessonVideo extends StatefulWidget {
  const _LessonVideo({
    required this.course,
    required this.lessonCubit,
  });

  final Course course;
  final LessonCubit lessonCubit;

  @override
  State<_LessonVideo> createState() => _LessonVideoState();
}

class _LessonVideoState extends State<_LessonVideo> {
  VideoCubit videoCubit = VideoCubit();

  @override
  void dispose() {
    videoCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // temp, we wait for issues
      width: 100.w,
      height: 25.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Hero(
          tag: "tag${widget.course}.id",
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BlocProvider(
                lazy: false,
                create: (context) => videoCubit
                  ..setStreams(widget.lessonCubit.lesson.myVideos)
                  ..setAudioStreams([widget.lessonCubit.lesson.audio!])
                  ..initVideoWithAudio(),
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
                          withImage: false,
                          small: true,
                          message: state.error,
                          onTap: () {
                            videoCubit
                              ..setStreams(widget.lessonCubit.lesson.myVideos)
                              ..setAudioStreams(
                                  [widget.lessonCubit.lesson.audio!])
                              ..initVideoWithAudio();
                          },
                        );
                      }

                      return VideoWidget2(
                        videoCubit: context.read<VideoCubit>(),
                      );
                    },
                  ),
                ),
              ))),
    );
  }
}
