// To parse this JSON data, do
//
//     final board = boardFromMap(jsonString);

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'generated/board_model.g.dart';

@CopyWith()
@JsonSerializable()
class Board {
  @JsonKey(name: "commentList")
  final List<CommentList>? commentList;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "fileList")
  final List<FileList>? fileList;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "postType")
  final String? postType;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "view")
  final int? view;
  @JsonKey(name: "writer")
  final String? writer;

  Board({
    this.commentList,
    this.content,
    this.createdAt,
    this.fileList,
    this.id,
    this.postType,
    this.status,
    this.title,
    this.type,
    this.updatedAt,
    this.view,
    this.writer,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  Map<String, dynamic> toJson() => _$BoardToJson(this);
}

@JsonSerializable()
class CommentList {
  @JsonKey(name: "childComment")
  final List<dynamic>? childComment;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "depth")
  final int? depth;
  @JsonKey(name: "id")
  final int? id;

  CommentList({
    this.childComment,
    this.content,
    this.createdAt,
    this.depth,
    this.id,
  });

  factory CommentList.fromJson(Map<String, dynamic> json) => _$CommentListFromJson(json);

  Map<String, dynamic> toJson() => _$CommentListToJson(this);
}

@JsonSerializable()
class FileList {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "originalFileName")
  final String? originalFileName;
  @JsonKey(name: "path")
  final String? path;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "type")
  final String? type;

  FileList({
    this.id,
    this.originalFileName,
    this.path,
    this.size,
    this.type,
  });

  factory FileList.fromJson(Map<String, dynamic> json) => _$FileListFromJson(json);

  Map<String, dynamic> toJson() => _$FileListToJson(this);
}
