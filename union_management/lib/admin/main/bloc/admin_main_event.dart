part of 'admin_main_bloc.dart';

abstract class AdminMainEvent extends Equatable {
  const AdminMainEvent();

  @override
  List<Object> get props => [];
}

class Initial extends AdminMainEvent {
  const Initial();
}

class LogOut extends AdminMainEvent {
  const LogOut();
}
