import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';
part 'generated/review_state.g.dart';

@CopyWith()
class ReviewState extends CommonState {
  const ReviewState({
    super.status,
    super.errorMessage,
    super.filterType,
    super.hasReachedMax,
    super.orderType,
    super.page,
    super.query,
    this.cleanScore = 0,
    this.explainScore = 0,
    this.kindnessScore = 0,
    this.content
  });

  final int cleanScore;
  final int explainScore;
  final int kindnessScore;
  final String? content;

  @override
  List<Object?> get props => [...super.props, cleanScore, explainScore, kindnessScore, content];
}