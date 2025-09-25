import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/review/bloc/review_event.dart';
import 'package:jeju_host_app/features/review/bloc/review_state.dart';


import '../../../core/core.dart';


class ReviewBloc extends Bloc<CommonEvent, ReviewState> {
  ReviewBloc() : super(const ReviewState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
    on<Rating>(_onRating);
    on<AddContent>(_onAddContent);
    on<Add>(_onAdd);
  }

  _onInitial(Initial event, Emitter<ReviewState> emit) async {
    // try{
    //   .catchError((e){
    //     add(Error(LogicalException(message: e.message)));
    //   });
    // } on ExceptionModel catch (e){
    //   add(Error(LogicalException(message: e.message)));
    // }
  }

  _onRating(Rating event, Emitter<ReviewState> emit) {
    switch(event.type){
      case 'clean' :
        return emit(state.copyWith(cleanScore: event.score));
      case 'kindness' :
        return emit(state.copyWith(kindnessScore: event.score));
      case 'explain' :
        return emit(state.copyWith(explainScore: event.score));
    }
  }

  _onAddContent(AddContent event, Emitter<ReviewState> emit) {
    emit(state.copyWith(content: event.content));
    logger.d(state.content);
  }

  _onError(Error event, Emitter<ReviewState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }

  _onAdd(Add event, Emitter<ReviewState> emit) {
    // emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
  }

}
