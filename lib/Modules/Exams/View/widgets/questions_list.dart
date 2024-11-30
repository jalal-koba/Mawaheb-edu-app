import 'package:flutter/material.dart';

// Models
import '../../models/exam.dart';

// Widgets
import 'question_form.dart';

class QuestionsList extends StatelessWidget {
  final Exam exam;

  const QuestionsList({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) => QuestionForm(
        question: exam.questions[index],
        questionIndex: index,
      ),
      itemCount: exam.questions.length,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
