part of 'main_bloc.dart';

class MainState extends Equatable {

  final NavbarItem navbarItem;
  final int index;

  const MainState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}

