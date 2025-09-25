part of 'main_bloc.dart';

class MainState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const MainState({this.navbarItem = NavbarItem.home, this.index = 0});

  @override
  List<Object?> get props => [navbarItem, index];
}
