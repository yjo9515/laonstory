part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

class IndexChanged extends MainEvent {
  const IndexChanged({required this.pageController, required this.index});

  final int index;
  final PageController pageController;
}

class PageChanged extends MainEvent {
  const PageChanged({required this.index});

  final int index;
}
