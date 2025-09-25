// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../board_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BoardCWProxy {
  Board commentList(List<CommentList>? commentList);

  Board content(String? content);

  Board createdAt(String? createdAt);

  Board fileList(List<FileList>? fileList);

  Board id(int? id);

  Board postType(String? postType);

  Board status(String? status);

  Board title(String? title);

  Board type(String? type);

  Board updatedAt(String? updatedAt);

  Board view(int? view);

  Board writer(String? writer);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Board(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Board(...).copyWith(id: 12, name: "My name")
  /// ````
  Board call({
    List<CommentList>? commentList,
    String? content,
    String? createdAt,
    List<FileList>? fileList,
    int? id,
    String? postType,
    String? status,
    String? title,
    String? type,
    String? updatedAt,
    int? view,
    String? writer,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBoard.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBoard.copyWith.fieldName(...)`
class _$BoardCWProxyImpl implements _$BoardCWProxy {
  const _$BoardCWProxyImpl(this._value);

  final Board _value;

  @override
  Board commentList(List<CommentList>? commentList) =>
      this(commentList: commentList);

  @override
  Board content(String? content) => this(content: content);

  @override
  Board createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  Board fileList(List<FileList>? fileList) => this(fileList: fileList);

  @override
  Board id(int? id) => this(id: id);

  @override
  Board postType(String? postType) => this(postType: postType);

  @override
  Board status(String? status) => this(status: status);

  @override
  Board title(String? title) => this(title: title);

  @override
  Board type(String? type) => this(type: type);

  @override
  Board updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  Board view(int? view) => this(view: view);

  @override
  Board writer(String? writer) => this(writer: writer);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Board(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Board(...).copyWith(id: 12, name: "My name")
  /// ````
  Board call({
    Object? commentList = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? fileList = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? postType = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? view = const $CopyWithPlaceholder(),
    Object? writer = const $CopyWithPlaceholder(),
  }) {
    return Board(
      commentList: commentList == const $CopyWithPlaceholder()
          ? _value.commentList
          // ignore: cast_nullable_to_non_nullable
          : commentList as List<CommentList>?,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      fileList: fileList == const $CopyWithPlaceholder()
          ? _value.fileList
          // ignore: cast_nullable_to_non_nullable
          : fileList as List<FileList>?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      postType: postType == const $CopyWithPlaceholder()
          ? _value.postType
          // ignore: cast_nullable_to_non_nullable
          : postType as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      view: view == const $CopyWithPlaceholder()
          ? _value.view
          // ignore: cast_nullable_to_non_nullable
          : view as int?,
      writer: writer == const $CopyWithPlaceholder()
          ? _value.writer
          // ignore: cast_nullable_to_non_nullable
          : writer as String?,
    );
  }
}

extension $BoardCopyWith on Board {
  /// Returns a callable class that can be used as follows: `instanceOfBoard.copyWith(...)` or like so:`instanceOfBoard.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BoardCWProxy get copyWith => _$BoardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      commentList: (json['commentList'] as List<dynamic>?)
          ?.map((e) => CommentList.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      fileList: (json['fileList'] as List<dynamic>?)
          ?.map((e) => FileList.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      postType: json['postType'] as String?,
      status: json['status'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      updatedAt: json['updatedAt'] as String?,
      view: json['view'] as int?,
      writer: json['writer'] as String?,
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'commentList': instance.commentList,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'fileList': instance.fileList,
      'id': instance.id,
      'postType': instance.postType,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'view': instance.view,
      'writer': instance.writer,
    };

CommentList _$CommentListFromJson(Map<String, dynamic> json) => CommentList(
      childComment: json['childComment'] as List<dynamic>?,
      content: json['content'] as String?,
      createdAt: json['created_at'] as String?,
      depth: json['depth'] as int?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CommentListToJson(CommentList instance) =>
    <String, dynamic>{
      'childComment': instance.childComment,
      'content': instance.content,
      'created_at': instance.createdAt,
      'depth': instance.depth,
      'id': instance.id,
    };

FileList _$FileListFromJson(Map<String, dynamic> json) => FileList(
      id: json['id'] as int?,
      originalFileName: json['originalFileName'] as String?,
      path: json['path'] as String?,
      size: json['size'] as int?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$FileListToJson(FileList instance) => <String, dynamic>{
      'id': instance.id,
      'originalFileName': instance.originalFileName,
      'path': instance.path,
      'size': instance.size,
      'type': instance.type,
    };
