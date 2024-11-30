import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Exams/View/widgets/exam_screen.dart';
import 'package:talents/Modules/Exams/View/widgets/questions_list.dart';
import 'package:talents/Modules/Exams/View/widgets/timer_widget.dart';
import 'package:talents/Modules/Exams/cubit/exams_cubit.dart';
import 'package:talents/Modules/Exams/cubit/exams_state.dart';
import 'package:talents/Modules/Tests/View/Widgets/get_certificate_dialog.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/app_pop_scope.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

class FinalExamScreen extends StatelessWidget {
  const FinalExamScreen({
    super.key,
    required this.examId,
    required this.course,
  });

  final int examId;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "الاختبار النهائي",
      body: BlocProvider(
        lazy: false,
        create: (context) =>
            ExamsCubit()..getExam(examId: examId, isSubscribed: true),
        child: BlocConsumer<ExamsCubit, ExamsState>(
          listener: (context, state) {
            if (state is SubmitExamSuccessState) {
              if (state.success) {
                showDialog(
                    context: context,
                    builder: (context) => GetCertificateDialog(
                          result: state.exam!.result!,
                          courseId: course.id,
                        ));
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

            if (state is GetExamsLoadingState ||
                state is StartExamLoadingState) {
              return const AppLoading();
            }

            if (state is GetExamsErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  examsCubit.getExam(examId: examId, isSubscribed: true);
                },
              );
            }

            if (state is StartExamErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  examsCubit.startExam(examId);
                },
              );
            }

            if (state is SubmitExamSuccessState) {
              if (!state.success) {
                return FailureWidget(
                  examsCubit: examsCubit,
                  onTryAgain: () {
                    examsCubit.getExam(examId: examId, isSubscribed: true);
                  },
                  state: state,
                );
              }
            }
            return AppPopScope(
              canPop: examsCubit.exam.result?.pass != null,
              child: Column(
                children: [
                  if (examsCubit.exam.result?.pass == null)
                    TimerWidget(
                      seconds: examsCubit.time!.ceil(),
                    ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        QuestionsList(exam: examsCubit.exam),
                        SliverToBoxAdapter(
                          child: Column(children: [
                            SizedBox(height: 2.h),
                            Builder(builder: (context) {
                              if (state is SubmitExamLoadingState) {
                                return const AppLoading();
                              }

                              return CustomButton(
                                  background:
                                      !examsCubit.showOpenNextLessonButton
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
                            SizedBox(height: 3.h)
                          ]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
