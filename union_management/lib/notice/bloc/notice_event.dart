part of 'notice_bloc.dart';

class NoticeEvent extends Equatable {
  const NoticeEvent({
    this.initial,
  });

  final Initial? initial;

  @override
  List<Object> get props => [];
}

class Initial extends NoticeEvent {
  const Initial();
}

class Page extends NoticeEvent {
  const Page();

}

class Search extends NoticeEvent {
  const Search(this.query);

  final String query;
}

class Detail extends NoticeEvent {
  const Detail(this.id);

  final String id;
}
