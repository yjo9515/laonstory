part of 'admin_user_bloc.dart';

abstract class AdminUserEvent extends Equatable {
  const AdminUserEvent();

  @override
  List<Object> get props => [];
}

class Initial extends AdminUserEvent {
  const Initial();
}

class PageChanged extends AdminUserEvent {
  const PageChanged(this.page, this.query);

  final int page;
  final String query;
}

class Search extends AdminUserEvent {
  const Search(this.query, {this.filter = FilterType.createdAt, this.order = OrderType.asc, this.position = PositionEnum.all, this.birthDay});

  final String query;
  final FilterType filter;
  final OrderType order;
  final PositionEnum position;
  final int? birthDay;
}

class ChangeYear extends AdminUserEvent {
  const ChangeYear(this.date);

  final DateTime date;
}

class UploadExcel extends AdminUserEvent {
  const UploadExcel();
}

class DownloadExcel extends AdminUserEvent {
  const DownloadExcel();
}

class Update extends AdminUserEvent {
  const Update();
}
