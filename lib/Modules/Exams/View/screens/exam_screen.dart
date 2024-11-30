import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Exams/View/widgets/exam_screen.dart';
import 'package:talents/Modules/Exams/View/widgets/questions_list.dart';
import 'package:talents/Modules/Exams/View/widgets/success_exam_dialog.dart';
import 'package:talents/Modules/Exams/View/widgets/timer_widget.dart';
import 'package:talents/Modules/Exams/cubit/exams_cubit.dart';
import 'package:talents/Modules/Exams/cubit/exams_state.dart';
import 'package:talents/Modules/Lessons/Models/lesson.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/app_pop_scope.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({
    super.key,
    required this.lesson,
    required this.course,
  });

  final Lesson lesson;
  final Course course;
  @override
  State<ExamScreen> createState() => _TestState();
}

class _TestState extends State<ExamScreen> {
  final ExamsCubit examsCubit = ExamsCubit();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.lesson.name,
      body: BlocProvider(
          lazy: false,
          create: (context) {
            return examsCubit
              ..getExam(
                  examId: widget.lesson.examId!,
                  isSubscribed: widget.course.subscribed);
          },
          child: BlocConsumer<ExamsCubit, ExamsState>(
            listener: (context, state) {
              if (state is OpenNextLessonSuccessState) {
                Navigator.of(context).pop({"id": state.nextLessonId});
              }

              if (state is OpenNextLessonErrorState) {
                customSnackBar(
                    context: context, success: 0, message: state.message);
              } else if (state is SubmitExamSuccessState) {
                if (state.success) {
                  widget.lesson.refreshLessonScreen = true;
                  showDialog(
                      context: context,
                      builder: (context) =>
                          SuccessExamDialog(result: state.exam!.result!));
                } else {
                  customSnackBar(
                      context: context, success: 0, message: state.message!);
                }
              } else if (state is SubmitExamErrorState) {
                customSnackBar(
                    context: context, success: 0, message: state.message);
              }
            },
            builder: (context, state) {
              final ExamsCubit examsCubit = ExamsCubit.get(context);

              if (state is GetExamsLoadingState) {
                return const AppLoading();
              }
              if (state is StartExamLoadingState) {
                return const AppLoading();
              }
              if (state is StartExamErrorState) {
                return TryAgain(
                  message: state.message,
                  onTap: () {
                    examsCubit.startExam(examsCubit.exam.id);
                  },
                );
              }

              if (state is SubmitExamSuccessState) {
                if (!state.success) {
                  return FailureWidget(
                    examsCubit: examsCubit,
                    onTryAgain: () {
                      examsCubit.getExam(
                          examId: examsCubit.exam.id,
                          isSubscribed: widget.course.subscribed);
                    },
                    state: state,
                  );
                }
              }
              bool canPop = (examsCubit.exam.result?.pass != null);
              return AppPopScope(
                canPop: canPop,
                child: Column(
                  children: [
                    if (examsCubit.exam.result?.pass ==
                        null) // this means that user is solving the exam
                      TimerWidget(
                        seconds: examsCubit.time!.ceil(),
                      )
                    else
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text(
                            'لقد حققت   ${examsCubit.exam.result!.studentPercentage!.toStringAsFixed(0)} / 100',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.meduimTitle.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w500)),
                      ),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          QuestionsList(exam: examsCubit.exam),
                          PageButtons(examsCubit: examsCubit, widget: widget)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}

class PageButtons extends StatelessWidget {
  const PageButtons({
    super.key,
    required this.examsCubit,
    required this.widget,
  });

  final ExamsCubit examsCubit;
  final ExamScreen widget;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        SizedBox(height: 2.h),
        Builder(builder: (context) {
          if (examsCubit.state is SubmitExamLoadingState) {
            return const AppLoading();
          }

          return CustomButton(
              background: !examsCubit.showOpenNextLessonButton
                  ? null
                  : Colors.grey[400],
              width: 90,
              titlebutton: "تأكيد",
              onPressed: () {
                if (!examsCubit.showOpenNextLessonButton) {
                  examsCubit.submitExam(examsCubit.exam.id);
                }
              });
        }),
        SizedBox(height: 1.h),
        Builder(builder: (context) {
          if (!widget.course.subscribed || widget.lesson.nextLessonId == -1) {
            return const SizedBox();
          }

          if (examsCubit.state is OpenNextLessonLoadingState) {
            return const AppLoading();
          }

          return CustomButton(
            width: 90,
            fontSize: 12,
            background:
                examsCubit.showOpenNextLessonButton ? null : Colors.grey[400],
            titlebutton: widget.lesson.nextLessonId != null &&
                    widget.lesson.nextLessonId != -1
                ? "الانتقال إلى الدرس التالي"
                : "فتح الدرس التالي",
            onPressed: () {
              if (examsCubit.showOpenNextLessonButton) {
                if (widget.lesson.nextLessonId == null) {
                  examsCubit.openNextLesson(
                      widget.lesson.sectionId!, widget.lesson.id);
                } else {
                  Navigator.of(context).pop({"id": widget.lesson.nextLessonId});
                }
              } else {
                customSnackBar(
                    context: context,
                    success: -1,
                    message: "يرجى حل الاختبار أولاً");
              }
            },
          );
        }),
        SizedBox(height: 2.h)
      ]),
    );
  }
}
