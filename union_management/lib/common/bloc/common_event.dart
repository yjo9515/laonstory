import 'package:equatable/equatable.dart';

class CommonEvent extends Equatable {
  const CommonEvent({
    this.initial,
  });

  final Initial? initial;

  @override
  List<Object> get props => [];
}

class Initial extends CommonEvent {
  const Initial();
}

class Page extends CommonEvent {
  const Page(this.page, this.query);

  final int page;
  final String query;
}

class Search extends CommonEvent {
  const Search(this.query);

  final String query;
}

class Delete extends CommonEvent {
  const Delete(this.id);

  final String id;
}
