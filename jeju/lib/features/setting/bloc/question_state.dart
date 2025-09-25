import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';
import '../../../core/domain/model/board_model.dart';
part 'generated/question_state.g.dart';

@CopyWith()
class QuestionState extends CommonState {
  const QuestionState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.questionList = const [],

  });

  final List<Board> questionList;


  @override
  List<Object?> get props => [...super.props, questionList];
}

@CopyWith()
class QuestionWriteState extends QuestionState {
  const QuestionWriteState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.title,
    this.comment

  });

  final String? title;
  final String? comment;


  @override
  List<Object?> get props => [...super.props, title, comment];
}