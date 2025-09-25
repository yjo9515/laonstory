part of 'admin_event_bloc.dart';

abstract class AdminEventEvent extends Equatable {
  const AdminEventEvent();

  @override
  List<Object> get props => [];
}

class Initial extends AdminEventEvent {
  const Initial();
}

class PageChanged extends AdminEventEvent {
  const PageChanged(this.page, this.query);

  final int page;
  final String query;
}

class Search extends AdminEventEvent {
  const Search(this.query);

  final String query;
}

class Update extends AdminEventEvent {
  const Update();
}

class Request extends AdminEventEvent {
  const Request(this.id, this.event);

  final String id;
  final Event event;
}
