part of 'admin_pay_bloc.dart';

abstract class AdminPayEvent extends Equatable {
  const AdminPayEvent();

  @override
  List<Object> get props => [];
}

class Initial extends AdminPayEvent {
  const Initial();
}

class PageChanged extends AdminPayEvent {
  const PageChanged(this.page, this.query);
  final int page;
  final String query;
}

class Search extends AdminPayEvent {
  const Search(this.query,
      {this.filter = FilterType.payTime, this.order = OrderType.asc});
  final String query;
  final FilterType filter;
  final OrderType order;
}

class ChangeYear extends AdminPayEvent {
  const ChangeYear(this.date);
  final DateTime date;
}

class EditUser extends AdminPayEvent {
  const EditUser(this.id, this.userData);
  final String id;
  final User userData;
}

class DeleteUser extends AdminPayEvent {
  const DeleteUser(this.id);
  final String id;
}

class AddPay extends AdminPayEvent {
  const AddPay(this.id, this.data);
  final String id;
  final Map<String, dynamic> data;
}
