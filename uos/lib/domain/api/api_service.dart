import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../type/emuns.dart';
import '../../type/exception.dart';
import '../model/exception_model.dart';

mixin ApiService {
  final defaultHeader = {
    'Connection': 'Keep-Alive',
    'Content-Type': 'application/json;charset=UTF-8',
    "Charset": "utf-8"
  };

  static (StatusCode, dynamic) _checkResult(
      http.StreamedResponse response, dynamic body, url) {
    log('$url \n===============================================================\n ${jsonEncode(body)}');

    try {
      switch (response.statusCode) {
        case 200:
        case 201:
          return (StatusCode.success, body);
        case 300:
          throw ServiceException(
              exceptionErrorCode:
                  ExceptionModel.fromJson(body).exceptionErrorCode,
              resultMsg: ExceptionModel.fromJson(body).resultMsg);
        case 400:
          throw ServiceException(
              exceptionErrorCode:
                  ExceptionModel.fromJson(body).exceptionErrorCode,
              resultMsg: ExceptionModel.fromJson(body).resultMsg);
        case 404:
          throw ServiceException(
              exceptionErrorCode:
                  ExceptionModel.fromJson(body).exceptionErrorCode,
              resultMsg: ExceptionModel.fromJson(body).resultMsg);
        case 403:
        case 401:
          throw ServiceException(
              exceptionErrorCode:
                  ExceptionModel.fromJson(body).exceptionErrorCode,
              resultMsg: ExceptionModel.fromJson(body).resultMsg);
        default:
          throw ServiceException(
              exceptionErrorCode:
                  ExceptionModel.fromJson(body).exceptionErrorCode,
              resultMsg: ExceptionModel.fromJson(body).resultMsg);
      }
    } catch (e) {
      throw ExceptionModel(false, resultMsg: e.toString() ?? '');
    }
  }

  static Uri _getUrl(String url, {String? param, String? query}) {
    final paramUrl = param != null ? '$url/$param' : url;
    return Uri.parse(query != null ? "$paramUrl?$query" : paramUrl);
  }

  Future<(StatusCode, dynamic)> get(String url,
      {Map<String, String>? header,
      TokenType token = TokenType.none,
      String? param,
      String? query,
      Map<String, dynamic>? body}) async {
    final request =
        http.Request('GET', _getUrl(url, param: param, query: query));
    request.headers.addAll(header ?? {});
    request.headers.addAll(defaultHeader);
    switch (token) {
      case TokenType.none:
      case TokenType.refreshToken:
      case TokenType.customToken:
        break;
      case TokenType.authToken:
        request.headers.addAll({
          'x-access-id':
              (await SharedPreferences.getInstance()).getString('id') ?? '',
          'x-access-token':
              (await SharedPreferences.getInstance()).getString('token') ?? '',
        });
        break;
    }
    if (body != null) request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(
            response,
            await json.decode(await response.stream.bytesToString()),
            request.url))
        .timeout(const Duration(seconds: 5),
            onTimeout: () => throw ExceptionModel(false,
                resultMsg: tr('netErr'), result: 503));
  }

  Future<(StatusCode, dynamic)> post(String url,
      {Map<String, String>? header,
      TokenType token = TokenType.none,
      String? param,
      String? query,
      Map<String, dynamic>? body}) async {
    final request =
        http.Request('POST', _getUrl(url, param: param, query: query));
    request.headers.addAll(header ?? {});
    request.headers.addAll(defaultHeader);
    switch (token) {
      case TokenType.none:
      case TokenType.refreshToken:
      case TokenType.customToken:
        break;
      case TokenType.authToken:
        request.headers.addAll({
          'x-access-id':
              (await SharedPreferences.getInstance()).getString('id') ?? '',
          'x-access-token':
              (await SharedPreferences.getInstance()).getString('token') ?? '',
        });
        break;
    }
    if (body != null) request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(
            response,
            await jsonDecode(await response.stream.bytesToString()),
            request.url))
        .timeout(const Duration(seconds: 5),
            onTimeout: () => throw ExceptionModel(false,
                resultMsg: tr('netErr'), result: 503));
  }

  Future<(StatusCode, dynamic)> patch(String url,
      {TokenType token = TokenType.none,
      String? param,
      String? query,
      String? customToken,
      Map<String, dynamic>? body,
      bool loginRequest = true}) async {
    var request =
        http.Request('PATCH', _getUrl(url, param: param, query: query));
    request.headers.addAll({'Content-Type': 'application/json'});
    if (token == TokenType.authToken)
      request.headers.addAll({
        'x-access-id':
            (await SharedPreferences.getInstance()).getString('id') ?? '',
        'x-access-token':
            (await SharedPreferences.getInstance()).getString('token') ?? '',
      });
    request.headers.addAll(defaultHeader);
    request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(
            response,
            await jsonDecode(await response.stream.bytesToString()),
            request.url))
        .timeout(const Duration(seconds: 5),
            onTimeout: () => throw ExceptionModel(false,
                resultMsg: tr('netErr'), result: 503));
  }

  Future<(StatusCode, dynamic)> delete(String url,
      {TokenType token = TokenType.none,
      String? param,
      String? query,
      Map<String, dynamic>? body}) async {
    final request =
        http.Request('DELETE', _getUrl(url, param: param, query: query));
    request.headers.addAll(defaultHeader);
    if (token == TokenType.authToken)
      request.headers.addAll({
        'x-access-id':
            (await SharedPreferences.getInstance()).getString('id') ?? '',
        'x-access-token':
            (await SharedPreferences.getInstance()).getString('token') ?? '',
      });
    if (body != null) request.body = jsonEncode(body);
    return await request
        .send()
        .then((response) async => _checkResult(
            response,
            await jsonDecode(await response.stream.bytesToString()),
            request.url))
        .timeout(const Duration(seconds: 5),
            onTimeout: () => throw ExceptionModel(false,
                resultMsg: tr('netErr'), result: 503));
  }

  Future<(StatusCode, dynamic)> postWithImage(String url,
      {TokenType token = TokenType.none,
      bool profile = false,
      String? param,
      String? query,
      Map<String, dynamic> body = const {},
      List<int>? imageByte,
      List<XFile>? images}) async {
    final request = _jsonToRequestFormData(
        http.MultipartRequest('POST', _getUrl(url, param: param, query: query)),
        body);
    if (token == TokenType.authToken)
      request.headers.addAll({
        'x-access-id':
            (await SharedPreferences.getInstance()).getString('id') ?? '',
        'x-access-token':
            (await SharedPreferences.getInstance()).getString('token') ?? '',
      });
    if (imageByte != null && imageByte.isNotEmpty)
      request.files.add(http.MultipartFile.fromBytes('file', imageByte));
    if (images != null && images.isNotEmpty && profile) {
      for (XFile image in images) {
        request.files.add(
          http.MultipartFile.fromBytes('file', await image.readAsBytes(),
              filename: image.name),
        );
      }
    } else if (images != null && images.isNotEmpty && profile == false) {
      for (XFile image in images) {
        request.files.add(
          http.MultipartFile.fromBytes('file', await image.readAsBytes(),
              filename: image.name),
        );
      }
    }
    request.headers.addAll({'Content-Type': 'multipart/form-data'});
    return await request
        .send()
        .then((response) async => _checkResult(
            response,
            await jsonDecode(await response.stream.bytesToString()),
            request.url))
        .timeout(const Duration(seconds: 5),
            onTimeout: () => throw ExceptionModel(false,
                resultMsg: tr('netErr'), result: 503));
  }

  static http.MultipartRequest _jsonToRequestFormData(
      http.MultipartRequest request, Map<String, dynamic> data) {
    request.files.add(http.MultipartFile.fromString("request", jsonEncode(data),
        contentType: MediaType.parse('application/json')));
    return request;
  }

  Future<(StatusCode, dynamic)> postWithFile(String url,
      {TokenType token = TokenType.none,
      String? param,
      String? query,
      Map<String, dynamic> body = const {},
      List<int>? fileByte,
      List<File>? files,
      String? fileExt}) async {
    log(files.toString() ?? "없음");
    final request = _jsonToRequestFormData(
        http.MultipartRequest('POST', _getUrl(url, param: param, query: query)),
        body);
    if (token == TokenType.authToken){
      request.headers.addAll({
        'x-access-id':
        (await SharedPreferences.getInstance()).getString('id') ?? '',
        'x-access-token':
        (await SharedPreferences.getInstance()).getString('token') ?? '',
        'Content-Type': 'multipart/form-data'
      });
    }
    if (fileByte != null && fileByte.isNotEmpty){
      log('전송');
      print('이미지 전송');
      request.files.add(http.MultipartFile.fromBytes('file', fileByte));
    }
    if (files != null && files.isNotEmpty) {
      log('전송');
      print('이미지 전송');
      for (File file in files) {
        request.files.add(
          http.MultipartFile.fromBytes('file', await file.readAsBytes(),
              filename: file.path, contentType: MediaType('image', 'jpg')),
        );
        request.fields['file_ext'] = fileExt!;
        // .add(http.MultipartFile.fromString('file_ext', fileExt!));
      }

    }
    print(body.toString());
    request.fields['nickname'] = body['nickname'] ?? '';
    request.fields['email'] = body['email'] ?? '';
    request.fields['phone'] = body['phone'] ?? '';
    request.fields['affiliation'] = body['affiliation'] ?? '';
    request.fields['dept'] = body['dept'] ?? '';
    request.fields['position'] = body['position'] ?? '';
    request.fields['research_field'] = body['research_field'] ?? '';
    request.fields['first_social'] = body['first_social'] ?? '';
    request.fields['first_url'] = body['first_url'] ?? '';
    request.fields['second_social'] = body['second_social'] ?? '';
    request.fields['second_url'] = body['second_url'] ?? '';
    request.fields['third_social'] = body['third_social'] ?? '';
    request.fields['third_url'] = body['third_url'] ?? '';
    request.fields['fourth_social'] = body['fourth_social'] ?? '';
    request.fields['fourth_url'] = body['fourth_url'] ?? '';
    request.fields['fifth_social'] = body['fifth_social'] ?? '';
    request.fields['fifth_url'] = body['fifth_url'] ?? '';
    return await request
        .send()
        .then((response) async
    => _checkResult(
            response,
            await jsonDecode(await response.stream.bytesToString()),
            request.url)
    )
        .timeout(const Duration(seconds: 5),
            onTimeout: () => throw ExceptionModel(false,
                resultMsg: tr('netErr'), result: 503));
  }

  // Future<(StatusCode, dynamic)> postWithImage(String url,
  //     {TokenType token = TokenType.none,bool profile = false,String? param, String? query, Map<String, dynamic> body = const {}, List<int>? imageByte, List<XFile>? images}) async {
  //   final request = _jsonToRequestFormData(http.MultipartRequest('POST', _getUrl(url, param: param, query: query)), body);
  //   if (token == TokenType.authToken) request.headers.addAll({'Authorization': (await _getTokenData()).authToken});
  //   if (imageByte != null && imageByte.isNotEmpty) request.files.add(http.MultipartFile.fromBytes('file', imageByte));
  //   if (images != null && images.isNotEmpty && profile) {
  //     for (XFile image in images) {
  //       request.files.add(
  //         http.MultipartFile.fromBytes('profile', await image.readAsBytes(), filename: image.name),
  //       );
  //     }
  //   }else if (images != null && images.isNotEmpty && profile == false){
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
  // static http.MultipartRequest _jsonToRequestFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  //   request.files.add(http.MultipartFile.fromString("request", jsonEncode(data), contentType: MediaType.parse('application/json')));
  //   return request;
  // }
}
