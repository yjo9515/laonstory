part of 'detail_bloc.dart';

class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class Initial extends DetailEvent {
  const Initial({required this.id, this.isAdmin = true});

  final String id;
  final bool isAdmin;
}

abstract class Add extends DetailEvent {
  const Add(this.data);

  final Map<String, dynamic> data;
}

abstract class Edit extends DetailEvent {
  const Edit(this.id, this.data);

  final String id;
  final Map<String, dynamic> data;
}

abstract class Delete extends DetailEvent {
  const Delete(this.id);

  final String id;
}

abstract class Paginate extends DetailEvent {
  const Paginate(this.id, this.page, this.query);

  final String? id;
  final int page;
  final String query;
}

abstract class Search extends DetailEvent {
  const Search(this.id, this.query);

  final String id;
  final String query;
}

class AddPoint extends Add {
  const AddPoint(this.id, super.data);

  final String id;

  Map<String, dynamic> get pointData => data;
}

class AddPay extends Add {
  const AddPay(this.id, super.data);

  final String id;

  Map<String, dynamic> get payData => data;
}

class EditPay extends Edit {
  const EditPay(super.id, super.data);

  Map<String, dynamic> get payData => data;
}

class EditPoint extends Edit {
  const EditPoint(super.id, super.data);

  Map<String, dynamic> get pointData => data;
}

class AddUser extends Add {
  const AddUser(super.data);

  Map<String, dynamic> get userData => data;
}

class EditUser extends Edit {
  const EditUser(super.id, super.data);

  Map<String, dynamic> get userData => data;
}

class DeleteUser extends Delete {
  const DeleteUser(super.id);
}

class AddEvent extends Add {
  const AddEvent(super.data);

  Map<String, dynamic> get eventData => data;
}

class EditEvent extends Edit {
  const EditEvent(super.id, super.data);

  Map<String, dynamic> get eventData => data;
}

class DeleteEvent extends Delete {
  const DeleteEvent(super.id);
}

class AddNotice extends Add {
  const AddNotice(super.data);

  Map<String, dynamic> get noticeData => data;
}

class EditNotice extends Edit {
  const EditNotice(super.id, super.data);

  Map<String, dynamic> get noticeData => data;
}

class DeleteNotice extends Delete {
  const DeleteNotice(super.id);
}

class PointPaginate extends Paginate {
  const PointPaginate(super.id, super.page, super.query);
}

class PayPaginate extends Paginate {
  const PayPaginate(super.id, super.page, super.query);
}
class AddManager extends Add {
  const AddManager(super.data);

  Map<String, dynamic> get managerData => data;
}

class EditManager extends Edit {
  const EditManager(super.id, super.data);

  Map<String, dynamic> get managerData => data;
}

class DeleteManager extends Delete {
  const DeleteManager(super.id);
}
