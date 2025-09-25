part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardEvent extends Equatable {
  const AdminDashboardEvent();

  @override
  List<Object> get props => [];
}

class Initial extends AdminDashboardEvent {
  const Initial();
}

class YearChanged extends AdminDashboardEvent {
  const YearChanged({this.userYear, this.pointYear});

  final DateTime? userYear;
  final DateTime? pointYear;
}

class Search extends AdminDashboardEvent {
  const Search(this.query);

  final String query;
}

class AddNotice extends AdminDashboardEvent {
  const AddNotice(this.title, this.content);

  final String title;
  final String content;
}

