import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/message_model.g.dart';

@JsonSerializable()
class Message extends Equatable {
  const Message({this.id, this.content, this.createdAt, this.fromType});

  final int? id;
  final	String? content;
  final DateTime? createdAt;
  final String? fromType;


  @override
  List<Object?> get props => [id, content, createdAt, fromType];

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
