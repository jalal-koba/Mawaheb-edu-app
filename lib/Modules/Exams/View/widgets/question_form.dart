import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Constant/app_colors.dart';

// Model
import '../../models/question.dart';

// Cubit
import '../../cubit/exams_cubit.dart';

class QuestionForm extends StatefulWidget {
  final int questionIndex;
  final Question question;

  const QuestionForm({super.key, required this.question, required this.questionIndex});

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.h,
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: HtmlWidget(
            widget.question.text,
            renderMode: RenderMode.column,
          ),
        ),

        Align(
          alignment: AlignmentDirectional.topEnd,
          child: IconButton(
            onPressed: () {

              
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  ExplainDialog(widget: widget));
            },
            icon: const Icon(Icons.question_mark_rounded,
                color: AppColors.primary), // colo align
            style: ButtonStyle(
                iconSize: const WidgetStatePropertyAll(15),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(100)))),
          ),
        ),
        // Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
        //     child: RichText(
        //         text: TextSpan(children: [
        //       TextSpan(
        //         text: widget.question.text,
        //         style: AppTextStyles.meduimTitle.copyWith(
        //             color: Colors.black,
        //             fontSize: 13.sp,
        //             fontWeight: FontWeight.bold),
        //       ),
        //       widget.question.note != null
        //           ? TextSpan(
        //               text: '  (توضيح)',
        //               style: AppTextStyles.secondTitle.copyWith(
        //                 color: AppColors.primary,fontWeight: FontWeight.bold
        //               ),
        //               recognizer: TapGestureRecognizer()
        //                 ..onTap = () {
        //                   showDialog(
        //                       context: context,
        //                       builder: (context) =>
        //                           ExplainDialog(widget: widget));
        //                 },
        //             )
        //           : const TextSpan(),
        //     ]))),
        Column(
          children: List.generate(
            widget.question.options.length,
            (index) {
              final options = widget.question.options;
              final isChosen = options[index].isChosen;
              final isTrue = options[index].isTrue;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: RadioListTile(
                  overlayColor: const WidgetStatePropertyAll(Colors.blue),
                  hoverColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  selectedTileColor: (isTrue != null &&
                          isTrue &&
                          isChosen != null &&
                          !isChosen)
                      ? Colors.green[200]
                      : null,
                  selected: (isChosen != null && isChosen) ||
                      (isTrue != null && isTrue),
                  activeColor: isTrue != null && isChosen != null
                      ? isChosen && isTrue
                          ? Colors.green
                          : isChosen && !isTrue
                              ? Colors.red
                              : !isChosen && isTrue
                                  ? Colors.green
                                  : null
                      : AppColors.primary,
                  title: 

                  HtmlWidget(options[index].name),
                  // Text(
                  //   options[index].name,
                  //   style: AppTextStyles.questionsText
                  //       .copyWith(fontWeight: FontWeight.w600),
                  // ),
                  value: index,
                  groupValue:
                      isChosen != null && isChosen ? index : selectedOption,
                  onChanged: (newOption) => setState(
                    () {
                      if (isChosen == null) {
                        selectedOption = newOption!;
                        context
                                .read<ExamsCubit>()
                                .selectedOptions[widget.questionIndex]
                            ['option_id'] = options[newOption].id;
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ExplainDialog extends StatelessWidget {
  const ExplainDialog({
    super.key,
    required this.widget,
  });

  final QuestionForm widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppColors.primary, width: 1),
      ),
      child: SizedBox(
        height: 50.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.clear,
                  color: AppColors.primary,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
                child: HtmlWidget(
                  widget.question.note!,
                  renderMode: RenderMode.listView,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
