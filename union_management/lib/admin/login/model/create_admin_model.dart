import 'package:intl/intl.dart';

class CreateAdminModel {
  final String? email;
  final String? code;
  final String? password;
  final String? registration;
  final String? name;
  final String? ceo;
  final DateTime? date;
  final String? fileName;

  const CreateAdminModel(this.email, this.code, this.password, this.registration, this.name, this.ceo, this.date, this.fileName);

  factory CreateAdminModel.fromJson(Map<String, dynamic> json) {
    return CreateAdminModel(
      json['email'],
      json['code'],
      json['password'],
      json['registration'],
      json['name'],
      json['ceo'],
      json['date'],
      json['fileName'],
    );
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['email'] = email ?? "";
    data['code'] = code ?? "";
    data['password'] = password ?? "";
    data['registration'] = registration ?? "";
    data['name'] = name ?? "";
    data['ceo'] = ceo ?? "";
    data['date'] = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
    data['fileName'] = fileName ?? "";
    return data;
  }
}
