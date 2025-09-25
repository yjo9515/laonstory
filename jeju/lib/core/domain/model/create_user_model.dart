class CreateUserModel {
  String? email;
  String? fcm;
  String? deviceId;
  String? type;
  String? userId;

  CreateUserModel({this.email, this.fcm, this.deviceId, this.type, this.userId});

  CreateUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fcm = json['fcm'];
    deviceId = json['deviceId'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['fcm'] = fcm;
    data['deviceId'] = deviceId;
    data['type'] = type;
    data['userId'] = userId;
    return data;
  }
}
