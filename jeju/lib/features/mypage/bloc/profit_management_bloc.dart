
import 'package:bloc/bloc.dart';
import 'package:jeju_host_app/features/mypage/bloc/profit_management_state.dart';


import '../../../core/core.dart';
import '../repository/host_repository.dart';
part 'profit_management_event.dart';

class ProfitManagementBloc extends Bloc<CommonEvent, ProfitManagementState> {
  ProfitManagementBloc() : super(const ProfitManagementState()) {
    on<Initial>(_onInitial);
    on<Error>(_onError);
  }

  _onInitial(Initial event, Emitter<ProfitManagementState> emit) async {

    await HostRepository.to.getCalculateData().then((value) {
      emit(state.copyWith(
          profit: Profit.fromJson(value['data']), status: CommonStatus.loading));
    });

  }

  _onError(Error event, Emitter<ProfitManagementState> emit) {
    // emit(state.copyWith(status: CommonStatus.failure, errorMessage: event.exception.toString()));
    // emit(state.copyWith(status: CommonStatus.initial));
  }
}
