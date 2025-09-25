import '../../../core/core.dart';

class ReviewEvent extends CommonEvent {
  const ReviewEvent();
}

class Rating extends ReviewEvent {
  const Rating({required this.score, required this.type});

  final int score;
  final String type;
}

class AddContent extends ReviewEvent {
  const AddContent(this.content,);

  final String content;
}

