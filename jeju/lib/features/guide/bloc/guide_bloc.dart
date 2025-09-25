import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';
import '../repository/guide_repository.dart';

part 'generated/guide_bloc.g.dart';
part 'guide_event.dart';
part 'guide_state.dart';

class GuideBloc extends Bloc<CommonEvent, GuideState> {
  GuideBloc() : super(const GuideState()) {
    on<Agree>(_onAgree);
    on<RegisterHost>(_onRegisterHost);
    on<Error>(_onError);
  }

  _onAgree(Agree event, Emitter<GuideState> emit) {
    emit(state.copyWith(agree: event.agree));
  }

  _onRegisterHost(RegisterHost event, Emitter<GuideState> emit) async {
    await GuideRepository.to.registerHost().then((value) => emit(state.copyWith(status: CommonStatus.success))).catchError((e) => add(Error(e)));
  }

  _onError(Error event, Emitter<GuideState> emit) {
    emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    emit(state.copyWith(status: CommonStatus.initial));
  }
}
