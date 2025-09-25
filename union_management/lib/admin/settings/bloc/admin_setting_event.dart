part of 'admin_setting_bloc.dart';

abstract class AdminSettingEvent extends Equatable {
  const AdminSettingEvent();

  @override
  List<Object> get props => [];
}

class Initial extends AdminSettingEvent {
  const Initial();
}

class PageChanged extends AdminSettingEvent {
  const PageChanged(this.page, this.query);

  final int page;
  final String query;
}

class PageChangedManager extends AdminSettingEvent {
  const PageChangedManager(this.page, this.query);

  final int page;
  final String query;
}

class SearchNotice extends AdminSettingEvent {
  const SearchNotice(this.query);

  final String query;
}


class SearchManager extends AdminSettingEvent {
  const SearchManager(this.query);

  final String query;
}

class Update extends AdminSettingEvent {
  const Update();
}
