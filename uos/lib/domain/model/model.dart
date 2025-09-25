import 'package:isus_members/domain/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generated/model.g.dart';

@JsonSerializable()
class BaseModel {
  final int? statusCode;
  final String? message;

  const BaseModel({this.statusCode, this.message});

  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);
}

@JsonSerializable()
class Model<T> extends BaseModel {
  @JsonKey(toJson: _dataToJson, fromJson: _dataFromJson)
  final T? data;

  const Model({this.data, super.statusCode, super.message});

  static T? _dataFromJson<T>(dynamic data) {
    if (data == null) return null;
    return switch (T) {
      User => User.fromJson(data),
      bool || int || String => data,
      _ => null,
    } as T;
  }

  static Map<String, dynamic>? _dataToJson<T>(T? data) {
    return switch (T) {
      bool || int || String => <String, dynamic>{'data': data},
      _ => null,
    };
  }

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson<T>(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}

@JsonSerializable()
class ListModel<T> extends BaseModel {
  final Items<T>? data;


  const ListModel({this.data, super.statusCode, super.message});

  factory ListModel.fromJson(Map<String, dynamic> json) => _$ListModelFromJson<T>(json);
}

@JsonSerializable()
class Items<T> {
  @JsonKey(toJson: _listToJson, fromJson: _listFromJson)
  final List<T>? items;

  const Items({this.items});

  static T? _listFromJson<T>(List<dynamic> json) {
    if (json.isEmpty) return null;
    if (T == List<User>) return json.map((e) => User.fromJson(e)).toList() as T;
    return [] as T;
  }

  static List<Map<String, dynamic>?>? _listToJson<T>(T? items) {
    return (items as List)
        .map((element) => switch (element.runtimeType) {
      User => (element as User).toJson(),
      _ => null,
    })
        .toList();
  }

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson<T>(json);
}
