import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:universal_html/html.dart" as html;

import '../../env/env.dart';
import '../enum/enums.dart';
import '../model/exception_model.dart';
import '../model/secure_model.dart';
import '../util/logger.dart';

mixin CommonRepository {
  checkStatus(http.StreamedResponse response, dynamic body, url, bool? loginRequest) {
    logger.d('$url \n===============================================================\n ${jsonEncode(body)}');
    if (response.statusCode == 200) {
      return (StatusCode.success, body);
    } else if (response.statusCode == 201) {
      return (StatusCode.success, body);
    } else if (response.statusCode == 400) {
      final exceptionModel = ExceptionModel.fromJson(body);
      return (StatusCode.badRequest, exceptionModel.exceptionMessage);
    } else if (response.statusCode == 401) {
      final exceptionModel = ExceptionModel.fromJson(body);
      // navigatorKey.currentContext!.pushReplacement('/');
      return (StatusCode.unAuthorized, exceptionModel.exceptionMessage);
    } else if (response.statusCode == 403) {
      final exceptionModel = ExceptionModel.fromJson(body);
      return (StatusCode.forbidden, exceptionModel.exceptionMessage);
    } else if (response.statusCode == 404) {
      final exceptionModel = ExceptionModel.fromJson(body);
      return (StatusCode.notFound, exceptionModel.exceptionMessage);
    } else {
      final exceptionModel = ExceptionModel.fromJson(body);
      return (StatusCode.error, exceptionModel.exceptionMessage);
    }
  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  setToken(String? accessToken, String? refreshToken, bool isGuest) async {
    if (kIsWeb) {
      var prefs = await SharedPreferences.getInstance();
      final tokenKey = enc.Key.fromUtf8(Env.tokenPrivateKey);
      final tokenIv = enc.IV.fromUtf8(Env.tokenPrivateIv);
      var secureString = prefs.getString('secureInfo');
      if (secureString != null && accessToken != null && refreshToken != null) {
        var secureModel = SecureModel.fromJson(jsonDecode(secureString));
        secureModel.loginStatus = LoginStatus.login;
        secureModel.tokenData.accessToken = accessToken;
        secureModel.tokenData.refreshToken = refreshToken;
        var data = jsonEncode(secureModel.toJson());
        await prefs.setString('secureInfo', jsonEncode(data));
      } else {
        throw UnimplementedError();
      }
    } else {
      const storage = FlutterSecureStorage();
      var secureString = await storage.read(key: 'secureInfo');
      if (secureString != null && accessToken != null && refreshToken != null) {
        var secureModel = SecureModel.fromJson(jsonDecode(secureString));
        secureModel.loginStatus = LoginStatus.login;
        secureModel.tokenData.accessToken = accessToken;
        secureModel.tokenData.refreshToken = refreshToken;
        await storage.write(key: 'secureInfo', value: jsonEncode(secureModel.toJson()));
        return secureModel;
      } else {
        throw UnimplementedError();
      }
    }
  }

  Future<String> getToken() async {
    var token = "";
    if (kIsWeb) {
      var prefs = await SharedPreferences.getInstance();
      final tokenKey = enc.Key.fromUtf8(Env.tokenPrivateKey);
      final tokenIv = enc.IV.fromUtf8(Env.tokenPrivateIv);
      final encrypted = prefs.getString('accessToken');
      token = enc.Encrypter(enc.AES(tokenKey, mode: enc.AESMode.cbc)).decrypt64(encrypted ?? "", iv: tokenIv);
    } else {
      const storage = FlutterSecureStorage();
      var secureString = await storage.read(key: 'secureInfo');
      if (secureString != null) {
        token = SecureModel.fromJson(jsonDecode(secureString)).tokenData.accessToken;
      } else {
        logger.d('aa');
        token = await storage.read(key: "accessToken") ?? "";
      }
    }

    return token;
  }

  Future<String> getRefreshToken() async {
    var token = "";
    if (kIsWeb) {
      var prefs = await SharedPreferences.getInstance();
      final tokenKey = enc.Key.fromUtf8(Env.tokenPrivateKey);
      final tokenIv = enc.IV.fromUtf8(Env.tokenPrivateIv);
      final encrypted = prefs.getString('refreshToken');
      token = enc.Encrypter(enc.AES(tokenKey, mode: enc.AESMode.cbc)).decrypt64(encrypted ?? "", iv: tokenIv);
    } else {
      const storage = FlutterSecureStorage();
      var secureString = await storage.read(key: 'secureInfo');
      if (secureString != null) {
        token = SecureModel.fromJson(jsonDecode(secureString)).tokenData.refreshToken;
      } else {
        token = await storage.read(key: "refreshToken") ?? "";
      }
    }
    return token;
  }

  Future<(StatusCode, dynamic)> get(String url) async {
    var request = http.Request('GET', Uri.parse(url));

    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> getWithParameter(String url, String parameter) async {
    var request = http.Request('GET', Uri.parse("$url?$parameter"));

    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> getWithTokenParameter(String url, String parameter) async {
    var headers = {
      'Authorization': 'Bearer ${await getToken()}',
    };
    var request = http.Request('GET', Uri.parse("$url?$parameter"));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> getWithBody(String url, String bodyData) async {
    var request = http.Request('GET', Uri.parse(url));

    request.body = bodyData;
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> getWithToken(String url) async {
    var headers = {
      'Authorization': 'Bearer ${await getToken()}',
    };
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> excelDownload(String url) async {
    var headers = {
      'Authorization': 'Bearer ${await getToken()}',
    };
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final rawData = response.bodyBytes;
    final content = base64Encode(rawData);
    html.AnchorElement(href: "data:application/octet-stream;charset=utf-8;base64,$content")
      ..setAttribute("download", "조합원명부.xlsx")
      ..click();
    return (StatusCode.success, true);
  }

  Future<(StatusCode, dynamic)> getFile(String url) async {
    var headers = {
      'Authorization': 'Bearer ${await getToken()}',
    };
    var request = http.MultipartRequest('GET', Uri.parse(url));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> getWithCustomToken(String url, String token) async {
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> postWithCustomTokenField(String url, String token, Map<String, dynamic> field) async {
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = jsonEncode(field);

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> postWithToken(String url) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> postWithTokenFile(String url, http.MultipartFile file) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'application/json'};
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.files.add(file);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> checkToken(String url) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, url, false);
  }

  Future<(StatusCode, dynamic)> postRefreshToken(String url) async {
    var headers = {'Authorization': 'Bearer ${await getRefreshToken()}', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));

    request.body = jsonEncode({'token': await getToken()});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, false);
  }

  Future<(StatusCode, dynamic)> postField(String url, Map<String, dynamic> field) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));

    request.body = jsonEncode(field);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> post(String url, Map<String, dynamic> bodyData) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.body = jsonEncode(bodyData);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> postWithImage(String url, Map<String, String> field, List<int> bytes) async {
    var headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request = jsonToFormData(request, field);

    request.fields.addAll(field);
    request.files.add(http.MultipartFile.fromBytes('file', bytes));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> postWithImages(String url, Map<String, dynamic> field, List<http.MultipartFile> files) async {
    var headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request = jsonToFormData(request, field);

    request.files.addAll(files);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> postWithTokenField(String url, Map<String, dynamic> field) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = jsonEncode(field);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> postWithField(String url, Map<String, dynamic> field) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));

    request.body = jsonEncode(field);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> patchWithToken(String url) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'application/json'};
    var request = http.Request('PATCH', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> patchWithTokenField(String url, Map<String, dynamic> field) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'application/json'};
    var request = http.Request('PATCH', Uri.parse(url));
    request.body = jsonEncode(field);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> patchWithImage(String url, List<int> bytes) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest('PATCH', Uri.parse(url));

    request.files.add(http.MultipartFile.fromBytes('file', bytes, filename: 'image.jpg', contentType: MediaType('file', 'brandImage')));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }

  Future<(StatusCode, dynamic)> delete(String url) async {
    var headers = {'Authorization': 'Bearer ${await getToken()}', 'Content-Type': 'application/json'};
    var request = http.Request('DELETE', Uri.parse(url));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    var body = await jsonDecode(result);
    return checkStatus(response, body, request.url, true);
  }
}
