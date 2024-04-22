import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetLibrariesCall {
  static Future<ApiCallResponse> call({
    String? token = 'notoken',
  }) async {
    String userId = await FlutterSecureStorage().read(key: 'userId') ?? '';
    print("http://10.101.52.242:8080/api/library/user/$userId");
    return ApiManager.instance.makeApiCall(
      callName: 'GetLibraries',
      apiUrl: 'http://10.101.52.242:8080/api/library/user/$userId',
      callType: ApiCallType.GET,
      headers: {
        'cookie': 'session=$token',
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static Future<ApiCallResponse> callSearch({
    String? token = 'notoken',
    String? search = '',
  }) async {
    print("http://10.101.52.242:8080/api/library/search?string=$search");
    return ApiManager.instance.makeApiCall(
      callName: 'GetLibraries',
      apiUrl: "http://10.101.52.242:8080/api/library/search?string=$search",
      callType: ApiCallType.POST,
      headers: {
        'cookie': 'session=$token',
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class AddImageInLibraryCall {
  static Future call({
    String? token = 'notoken',
    String? image,
    int? libraryId,
    int? size,
    String? name = '',
  }) async {
    final res = await Dio()
        .post(
      "http://10.101.52.242:8080/api/image/",
      data: {
        "image": image,
        "name": name,
        "size": size,
        "library_id": libraryId
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          'cookie': 'session=$token',
        },
      ),
    )
        .onError((DioError error, stackTrace) async {
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: error.response?.statusCode ?? 0,
        data: error.response?.data ?? {},
      );
    });
    return res.data;
  }
}

class UploadNewLibraryCall {
  static Future<ApiCallResponse> call({
    String? name = '',
  }) async {
    String userId = await FlutterSecureStorage().read(key: 'userId') ?? '';
    String username = await FlutterSecureStorage().read(key: 'username') ?? '';
    print({
      'title': name,
      'author': username,
      'user_id': userId,
    });
    return ApiManager.instance.makeApiCall(
      callName: 'upload new library',
      apiUrl:
          'http://10.101.52.242:8080/api/library?user_id=$userId&title=$name&author=$username',
      callType: ApiCallType.POST,
      headers: {
        'cookie': 'session=notoken',
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteImage {
  static Future<ApiCallResponse> call({
    String? imageId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'upload new library',
      apiUrl: 'http://10.101.52.242:8080/api/image/$imageId',
      callType: ApiCallType.DELETE,
      headers: {
        'cookie': 'session=notoken',
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteLibrary {
  static Future<ApiCallResponse> call({
    String? libraryId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'delete library',
      apiUrl: 'http://10.101.52.242:8080/api/library/$libraryId',
      callType: ApiCallType.DELETE,
      headers: {
        'cookie': 'session=notoken',
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class LinkLibraryCall {
  static Future<ApiCallResponse> call({
    String? libraryId = '',
  }) async {
    String userId = await FlutterSecureStorage().read(key: 'userId') ?? '';
    return ApiManager.instance.makeApiCall(
      callName: 'upload new library',
      apiUrl:
          'http://10.101.52.242:8080/api/library/user/$userId/add/$libraryId',
      callType: ApiCallType.POST,
      headers: {
        'cookie': 'session=notoken',
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetImagesCall {
  static Future<ApiCallResponse> call({
    int? id = 0,
    String? token = 'notoken',
  }) async {
    print('http://10.101.52.242:8080/api/images/library/$id');
    print('session=$token');
    return ApiManager.instance.makeApiCall(
      callName: 'getImages',
      apiUrl: 'http://10.101.52.242:8080/api/images/library/$id',
      callType: ApiCallType.GET,
      headers: {
        'cookie': 'session=$token',
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
  static Future<ApiCallResponse> callSearch({
    String search = '',
    String? token = 'notoken',
  }) async {
    print('http://10.101.52.242:8080/api/image/search?string=$search');
    print('session=$token');
    return ApiManager.instance.makeApiCall(
      callName: 'getImages',
      apiUrl: 'http://10.101.52.242:8080/api/image/search?string=$search',
      callType: ApiCallType.POST,
      headers: {
        'cookie': 'session=$token',
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
