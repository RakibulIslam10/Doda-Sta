import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../utils/app_storage.dart';

Map<String, String> basicHeaderInfo() {
  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  };
}

Future<Map<String, String>> bearerHeaderInfo() async {
  // final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoSWQiOiI2OGZmNDRjYTYzMmU3ZTQ2MTc5ZjA5MzQiLCJ1c2VySWQiOiI2OGZmNDRjYjYzMmU3ZTQ2MTc5ZjA5MzYiLCJlbWFpbCI6ImRhZGFAeW9wbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTc2MTU1OTc5MSwiZXhwIjoxNzkzMDk1NzkxfQ.5sVWOscrmE--r12nHynDBSnnIAqAexrFqFXzYcLddb4";
 // final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoSWQiOiI2OTAxYjk2ZTgxYjU2Y2FkYzEyNjc5ZTEiLCJ1c2VySWQiOiI2OTAxYjk2ZTgxYjU2Y2FkYzEyNjc5ZTMiLCJlbWFpbCI6InJham9uZG9kYUB5b3BtYWlsLmNvbSIsInJvbGUiOiJQUk9WSURFUiIsImlhdCI6MTc2MTczMDk1NSwiZXhwIjoxNzkzMjY2OTU1fQ.ppS5tAhVWsoj-SwNCHwS-4PWRiBU9t9A5I9dbDq6ePQ";
 final String token = AppStorage.token;
  print(token);

  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $token",
  };
}

Future<Map<String, String>> bearerHeaderInfoForDelete() async {
  // final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoSWQiOiI2OGZmNDRjYTYzMmU3ZTQ2MTc5ZjA5MzQiLCJ1c2VySWQiOiI2OGZmNDRjYjYzMmU3ZTQ2MTc5ZjA5MzYiLCJlbWFpbCI6ImRhZGFAeW9wbWFpbC5jb20iLCJyb2xlIjoiVVNFUiIsImlhdCI6MTc2MTU1OTc5MSwiZXhwIjoxNzkzMDk1NzkxfQ.5sVWOscrmE--r12nHynDBSnnIAqAexrFqFXzYcLddb4";
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoSWQiOiI2OTAxYjk2ZTgxYjU2Y2FkYzEyNjc5ZTEiLCJ1c2VySWQiOiI2OTAxYjk2ZTgxYjU2Y2FkYzEyNjc5ZTMiLCJlbWFpbCI6InJham9uZG9kYUB5b3BtYWlsLmNvbSIsInJvbGUiOiJQUk9WSURFUiIsImlhdCI6MTc2MTczMDk1NSwiZXhwIjoxNzkzMjY2OTU1fQ.ppS5tAhVWsoj-SwNCHwS-4PWRiBU9t9A5I9dbDq6ePQ";

  // final String token = AppStorage.token;
  print(token);

  return {
    HttpHeaders.authorizationHeader: token,
    HttpHeaders.contentTypeHeader: "application/json",
  };
}

class ApiClient {

  static Future<Response> get({
    required String url,
    bool isBasic = false,
    int duration = 30,
  }) async {
    try {
      debugPrint("GET URL: $url");

      final response = await http
          .get(Uri.parse(url), headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo())
          .timeout(Duration(seconds: duration));

      debugPrint("URL: $url : Body => ${response.body}");
      debugPrint("Status Code => ${response.statusCode}");

      var body = jsonDecode(response.body);

      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } on SocketException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: 'Error Alert on Socket Exception',
      );
    } on TimeoutException {
      return const Response(body: {}, statusCode: 400, statusText: 'Time out exception');
    } on http.ClientException catch (_) {
      return const Response(body: {}, statusCode: 400, statusText: 'Error Alert Client Exception');
    } catch (e) {
      return const Response(body: {}, statusCode: 400, statusText: "Something went wrong");
    }
  }

  static Future<Response> post({
    required String url,
    bool isBasic = false,
    required Map<String, dynamic> body,
    int duration = 30,
  }) async {
    try {
      debugPrint("POST URL: $url");
      debugPrint("Body: $body");

      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      debugPrint("URL: $url : Body => ${response.body}");
      debugPrint("Status Code => ${response.statusCode}");

      body = jsonDecode(response.body);

      return Response(
        body: body,
        bodyString: response.body.toString(),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } on SocketException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞',
      );
    } on TimeoutException {
      return Response(body: {}, statusCode: 400, statusText: 'Time out exception $url');
    } on http.ClientException catch (_) {
      return Response(body: {}, statusCode: 400, statusText: 'client exception hit $url');
    } catch (_) {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    }
  }

  static Future<Response> patch({
    required String url,
    bool isBasic = false,
    Map<String, dynamic>? body,
    int duration = 30,
  }) async {
    try {
      debugPrint("PATCH URL: $url");
      debugPrint("PATCH URL: $url AND BODY : $body");

      final response = await http
          .patch(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      debugPrint("URL: $url : Body => ${response.body}");
      debugPrint("Status Code => ${response.statusCode}");

      body = jsonDecode(response.body);

      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } on SocketException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞',
      );
    } on TimeoutException {
      return Response(body: {}, statusCode: 400, statusText: 'Time out exception $url');
    } on http.ClientException catch (_) {
      return Response(body: {}, statusCode: 400, statusText: 'client exception hitted $url');
    } catch (_) {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    }
  }

  static Future<Response> multipartRequest({
    required String url,
    required String reqType,
    bool isBasic = false,
    Map<String, String>? body,
    required List<MultipartBody> multipartBody,
    Function(double progress)? onProgress,
  }) async {
    try {
      debugPrint("$reqType URL: $url");

      final request = http.MultipartRequest(reqType, Uri.parse(url))
        ..fields.addAll(body ?? {})
        ..headers.addAll(isBasic ? basicHeaderInfo() : await bearerHeaderInfo());

      if (multipartBody.isNotEmpty) {
        for (MultipartBody element in multipartBody) {
          if (element.file.path.isEmpty) {
            continue;
          }
          debugPrint("path : ${element.file.path}");

          var mimeType = lookupMimeType(element.file.path);

          debugPrint("MimeType================$mimeType");

          try {
            var multipartImg = await http.MultipartFile.fromPath(
              element.key,
              element.file.path,
              contentType: MediaType.parse(mimeType!),
            );

            request.files.add(multipartImg);
          } catch (e) {
            debugPrint("Error adding file: $e");
          }
        }
      }

      debugPrint('Files added to request: ${request.files.length}');

      final streamedResponse = await request.send();

      final totalBytes = streamedResponse.contentLength;
      int bytesUploaded = 0;

      print('Total bytes to upload: $totalBytes');

      if (totalBytes == null || totalBytes <= 0) {
        print('Content length is invalid. Cannot track progress.');
      }

      final responseStream = streamedResponse.stream.transform<List<int>>(
        StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            bytesUploaded += data.length;
            if (onProgress != null && totalBytes != null && totalBytes > 0) {
              double progress = bytesUploaded / totalBytes;
              onProgress(progress);
              print('Progress: ${(progress * 100).toStringAsFixed(2)}%');
            }
            sink.add(data);
          },
          handleError: (error, stackTrace, sink) {
            print('Stream error: $error');
            sink.addError(error, stackTrace);
          },
          handleDone: (sink) {
            print('Stream completed');
            sink.close();
          },
        ),
      );

      final response = await http.Response.fromStream(
        http.StreamedResponse(responseStream, streamedResponse.statusCode),
      );

      debugPrint("URL: $url : Body => ${response.body}");
      debugPrint("Status Code => ${streamedResponse.statusCode}");

      var decodeBody = jsonDecode(response.body);
      return Response(body: decodeBody, statusCode: response.statusCode);
    } on SocketException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞',
      );
    } on TimeoutException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Error Alert Timeout Exception 🐞🐞🐞',
      );
    } on http.ClientException catch (_) {
      return const Response(body: {}, statusCode: 400, statusText: 'client exception hitted');
    } catch (_) {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    }
  }

  static Future<Response> delete({
    required String url,
    bool isBasic = false,
    int code = 200,
    int duration = 15,
    required Map<String, dynamic> body,
  }) async {
    try {
      var headers = await bearerHeaderInfoForDelete();

      debugPrint("DELETE URL: $url");
      debugPrint(headers.toString());
      debugPrint(body.toString());

      final response = await http
          .delete(
            Uri.parse(url),
            headers: await bearerHeaderInfoForDelete(),
            body: jsonEncode(body),
          )
          .timeout(Duration(seconds: duration));

      debugPrint("URL: $url : Body => ${response.body}");
      debugPrint("Status Code => ${response.statusCode}");

      if (response.statusCode == code || response.statusCode == 200) {
        return Response(body: jsonDecode(response.body), statusCode: response.statusCode);
      } else {
        return Response(
          body: jsonDecode(response.body),
          statusCode: response.statusCode,
          statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
        );
      }
    } on SocketException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    } on TimeoutException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    } on http.ClientException catch (_) {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    } catch (_) {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    }
  }

  static Future<Response> put({
    required String url,
    bool isBasic = false,
    Map<String, dynamic>? body,
    int code = 200,
    int duration = 15,
  }) async {
    try {
      debugPrint("PUT URL: $url");

      final response = await http
          .put(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      debugPrint("URL: $url : Body => ${response.body}");
      debugPrint("Status Code => ${response.statusCode}");

      if (response.statusCode == code) {
        final data = jsonDecode(response.body);
        return Response(body: data, statusCode: response.statusCode, statusText: 'Success');
      } else {
        return Response(
          body: jsonDecode(response.body),
          statusCode: response.statusCode,
          statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
        );
      }
    } on SocketException {
      return const Response(body: {}, statusCode: 400, statusText: 'Success');
    } on TimeoutException {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    } on http.ClientException catch (_) {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    } catch (_) {
      return const Response(
        body: {},
        statusCode: 400,
        statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞',
      );
    }
  }
}

class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}
