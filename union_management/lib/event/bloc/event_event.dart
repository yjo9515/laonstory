part of 'event_bloc.dart';

class EventEvent extends Equatable {
  const EventEvent({
    this.initial,
  });

  final Initial? initial;

  @override
  List<Object> get props => [];
}

class Initial extends EventEvent {
  const Initial();
}

class Page extends EventEvent {
  const Page();
}

class Search extends EventEvent {
  const Search(this.query);

  final String query;
}

class Detail extends EventEvent {
  const Detail(this.id);

  final String id;
}

class Request extends EventEvent {
  const Request(this.id);

  final String? id;
}

class CancelRequest extends EventEvent {
  const CancelRequest(this.id);

  final String? id;
}
