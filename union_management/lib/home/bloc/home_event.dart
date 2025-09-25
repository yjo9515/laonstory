part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}
class Initial extends HomeEvent {
  const Initial();
}

class Page extends HomeEvent {
  const Page(this.page, this.query);

  final int page;
  final String query;
}

class Search extends HomeEvent {
  const Search(this.query);

  final String query;
}

class Delete extends HomeEvent {
  const Delete(this.id);

  final String id;
}



