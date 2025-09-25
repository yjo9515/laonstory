import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../../../core/core.dart';

part 'generated/splash_bloc.g.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<CommonEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<Initial>(_onInitial);
  }

  _onInitial(Initial event, Emitter<SplashState> emit) async {
    if (true) {
      emit(state.copyWith(status: CommonStatus.loading));
      await Future.delayed(const Duration(seconds: 4)).then((_) => emit(state.copyWith(done: true)));
      await Future.delayed(const Duration(seconds: 1)).then((_) => emit(state.copyWith(status: CommonStatus.success, tokenStatus: event.data)));
    }
  }
}
