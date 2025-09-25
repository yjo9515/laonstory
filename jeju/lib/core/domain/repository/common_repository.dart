import 'dart:convert';
import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../main.dart';
import '../../core.dart';

mixin CommonRepository {
  final defaultHeader = {'Connection': 'Keep-Alive'};

  static (StatusCode, dynamic) _checkResult(http.StreamedResponse response, dynamic body, url, {bool? loginRequest}) {
    logger.d('$url \n===============================================================\n ${jsonEncode(body)}');
    try {
      switch (response.statusCode) {
        case 200:
        case 201:
          return (StatusCode.success, body);
        case 300:
          throw ServiceException(code: ExceptionModel.fromJson(body).exceptionErrorCode, message: ExceptionModel.fromJson(body).message);
        case 400:
          throw ServiceException(code: ExceptionModel.fromJson(body).exceptionErrorCode, message: ExceptionModel.fromJson(body).message);
        case 404:
          throw ServiceException(code: ExceptionModel.fromJson(body).exceptionErrorCode, message: ExceptionModel.fromJson(body).message);
        case 403:
        case 401:
          if (loginRequest ?? true && navigatorKey.currentContext != null) {
            navigatorKey.currentContext!.push('/login/false');
          }
          throw ServiceException(code: ExceptionModel.fromJson(body).exceptionErrorCode, message: ExceptionModel.fromJson(body).message);
        default:
          throw ServiceException(code: ExceptionModel.fromJson(body).exceptionErrorCode, message: ExceptionModel.fromJson(body).message);
      }
    } catch (e) {
      throw ExceptionModel(false, message: e.toString());
    }
  }

  static Uri _getUrl(String url, {String? param, String? query}) {
    final paramUrl = param != null ? '$url/$param' : url;
    return Uri.parse(query != null ? "$paramUrl?$query" : paramUrl);
  }

  static http.MultipartRequest _jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {

    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }

    return request;
  }

  static http.MultipartRequest _jsonToRequestFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    // request.files.add(http.MultipartFile.fromString("request", jsonEncode(data), contentType: MediaType.parse('application/json')));
    // request.fields["request"] = jsonEncode(data);
    request.files.add(
        http.MultipartFile.fromBytes(
        'request',
        utf8.encode(json.encode(data)),
    contentType: MediaType(
    'application',
    'json',
    {'charset': 'utf-8'},),),);
    return request;
  }

  static Future<TokenData> _getTokenData() async {
    var secureString = await AppConfig.to.storage.read(key: 'secureInfo');
    if (secureString != null) {
      return SecureModel.fromJson(jsonDecode(secureString)).tokenData;
    } else {
      return TokenData(authToken: "", refreshToken: "");
    }
  }

  Future<(StatusCode, dynamic)> get(String url, {Map<String, String>? header, TokenType token = TokenType.none, String? param, String? query, Map<String, dynamic>? body}) async {
    final request = http.Request('GET', _getUrl(url, param: param, query: query));
    request.headers.addAll(header ?? {});
    request.headers.addAll(defaultHeader);
    switch (token) {
      case TokenType.none:
      case TokenType.refreshToken:
      case TokenType.customToken:
        break;
      case TokenType.authToken:
        request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
        break;
    }
    if (body != null) request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
        .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }

  Future<(StatusCode, dynamic)> post(String url, {TokenType token = TokenType.none, String? param, String? query, String? customToken, Map<String, dynamic>? body, bool loginRequest = true}) async {
    final request = http.Request('POST', _getUrl(url, param: param, query: query));
    request.headers.addAll(defaultHeader);
    request.headers.addAll({'Content-Type': 'application/json'});
    switch (token) {
      case TokenType.none:
        break;
      case TokenType.refreshToken:
        request.headers.addAll({'Authorization': (await _getTokenData()).refreshToken});
        request.body = jsonEncode({'token': (await _getTokenData()).authToken});
        break;
      case TokenType.customToken:
        request.headers.addAll({'Authorization': '$customToken'});
        break;
      case TokenType.authToken:
        request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
        break;
    }
    if (body != null) request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
        .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }

  Future<(StatusCode, dynamic)> postWithImage(String url,
      {TokenType token = TokenType.none,bool profile = false,String? param, String? query, Map<String, dynamic> body = const {}, List<int>? imageByte, List<XFile>? images}) async {
    final request = _jsonToRequestFormData(http.MultipartRequest('POST', _getUrl(url, param: param, query: query)), body);
    if (token == TokenType.authToken) request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
    if (imageByte != null && imageByte.isNotEmpty) request.files.add(http.MultipartFile.fromBytes('file', imageByte));
    if (images != null && images.isNotEmpty && profile) {
      for (XFile image in images) {
        request.files.add(
          http.MultipartFile.fromBytes('profile', await image.readAsBytes(), filename: image.name),
        );
      }
    }else if (images != null && images.isNotEmpty && profile == false){
      for (XFile image in images) {
        request.files.add(
          http.MultipartFile.fromBytes('imageList', await image.readAsBytes(), filename: image.name),
        );
      }
    }
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    return await request
        .send()
        .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
        .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }

  Future<(StatusCode, dynamic)> postWithFile(String url,
      {TokenType token = TokenType.none, String? param, String? query, Map<String, dynamic> body = const {}, List<int>? fileByte, List<File>? files}) async {
    final request = _jsonToRequestFormData(http.MultipartRequest('POST', _getUrl(url, param: param, query: query)), body);
    if (token == TokenType.authToken) request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
    if (fileByte != null && fileByte.isNotEmpty) request.files.add(http.MultipartFile.fromBytes('file', fileByte));
    if (files != null && files.isNotEmpty) {
      for (File file in files) {
        request.files.add(
          http.MultipartFile.fromBytes('businessLicense', await file.readAsBytes(), filename: file.path),
        );
      }
    }
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    return await request
        .send()
        .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
        .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }

  Future<(StatusCode, dynamic)> patch(String url, {TokenType token = TokenType.none, String? param, String? query, String? customToken, Map<String, dynamic>? body, bool loginRequest = true}) async {
    var request = http.Request('PATCH', _getUrl(url, param: param, query: query));
    request.headers.addAll({'Content-Type': 'application/json'});
    if (token == TokenType.authToken) request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
    request.headers.addAll(defaultHeader);
    request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
        .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }

  // Future<(StatusCode, dynamic)> patchWithImage(String url,
  //     {TokenType token = TokenType.none, String? param, String? query, Map<String, dynamic> body = const {}, List<int>? imageByte,
  //       // List<http.MultipartFile>? images
  //       List<XFile>? images
  //     }) async {
  //   var request = http.MultipartRequest('PATCH', _getUrl(url, param: param, query: query));
  //   // final request = _jsonToRequestFormData(http.MultipartRequest('POST', _getUrl(url, param: param, query: query)), body);
  //   request.headers.addAll(defaultHeader);
  //   if (token == TokenType.authToken) request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
  //   if (imageByte != null && imageByte.isNotEmpty) request.files.add(http.MultipartFile.fromBytes('file', imageByte, filename: 'image.jpg', contentType: MediaType('file', 'brandImage')));
  //   // if (images != null && images.isNotEmpty) request.files.addAll(images);
  //   request.fields.addAll({ 'Content-Type': 'application/json'});
  //   if (images != null && images.isNotEmpty) {
  //     for (XFile image in images) {
  //       request.files.add(
  //         http.MultipartFile.fromBytes('imageList', await image.readAsBytes(), filename: image.name),
  //       );
  //     }
  //   }
  //   request.headers.addAll({'Content-Type': 'multipart/form-data'});
  //   return await request
  //       .send()
  //       .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
  //       .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  // }

  Future<(StatusCode, dynamic)> patchWithImage(String url,
      {TokenType token = TokenType.none, String? param, String? query, Map<String, dynamic> body = const {}, List<int>? imageByte, List<XFile> images = const []}) async {
    final request = _jsonToRequestFormData(http.MultipartRequest('PATCH', _getUrl(url, param: param, query: query)), body);
    if (token == TokenType.authToken) request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
    if (imageByte != null && imageByte.isNotEmpty) request.files.add(http.MultipartFile.fromBytes('file', imageByte));
    if (images != null && images.isNotEmpty) {
      for (XFile image in images) {
        request.files.add(
          http.MultipartFile.fromBytes('imageList', await image.readAsBytes(), filename: image.name),
        );
      }
    }
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    return await request
        .send()
        .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
        .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }

  Future<(StatusCode, dynamic)> patchWithFile(String url,
      {TokenType token = TokenType.none, String? param, String? query, Map<String, dynamic> body = const {}, List<int>? fileByte, List<File>? files}) async {
    // var request = http.MultipartRequest('PATCH', _getUrl(url, param: param, query: query));

      var request = _jsonToRequestFormData(http.MultipartRequest(
          'PATCH', _getUrl(url, param: param, query: query)), body);
      request.headers.addAll(defaultHeader);

      if (token == TokenType.authToken) {
        request.headers.addAll(
          {'Authorization': (await _getTokenData()).authToken});
      }
      // if (fileByte != null && fileByte.isNotEmpty) request.files.add(files.single.path));
      // if (files != null && files.isNotEmpty) request.files.addAll(files);
      for (var file in files!) {
        request.files.add(http.MultipartFile.fromBytes(
          'businessLicense',
          await file.readAsBytes(),
          filename: file.path.split('/').last,
          // contentType: MediaType('image', 'png')
        )
        );
        // request.files.add(await http.MultipartFile.fromPath(
        //     'file',
        //     file.path,
        //     // filename: file.path.split('/').last,
        //     contentType: MediaType('multipart', 'form-data')
        //   // contentType: MediaType('image', 'png')
        // )
        // );
      }
      // request.fields.addAll({'Content-Type': 'application/json'});
      request.headers.addAll({'Content-Type': 'multipart/form-data'});
      return await request
          .send()
          .then((response) async =>
          _checkResult(
              response, await jsonDecode(await response.stream.bytesToString()),
              request.url))
          .timeout(const Duration(seconds: 5), onTimeout: () =>
      throw const ExceptionModel(
          false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }

  Future<(StatusCode, dynamic)> delete(String url, {TokenType token = TokenType.none, String? param, String? query, Map<String, dynamic>? body}) async {
    final request = http.Request('DELETE', _getUrl(url, param: param, query: query));
    request.headers.addAll(defaultHeader);
    if (token == TokenType.authToken) request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
    if (body != null) request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(response, await jsonDecode(await response.stream.bytesToString()), request.url))
        .timeout(const Duration(seconds: 5), onTimeout: () => throw const ExceptionModel(false, message: '서비스가 응답하지 않습니다. 불편을 드려 죄송합니다.', status: 503));
  }
}
