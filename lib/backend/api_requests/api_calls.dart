import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetLibrariesCall {
  static Future<ApiCallResponse> call({
    String? token = 'notoken',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetLibraries',
      apiUrl: 'https://pictsManager.com/getLibraries',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'token': token,
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
  static Future<ApiCallResponse> call({
    String? token = 'notoken',
    FFUploadedFile? image,
    int? libraryId,
    int? size,
    String? name = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Add image in library',
      apiUrl: 'https://pictsManager.com/putImageInLibrary',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'token': token,
        'image': image,
        'libraryId': libraryId,
        'size': size,
        'name': name,
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

class AddImageInLibraryCopyCall {
  static Future<ApiCallResponse> call({
    String? token = 'notoken',
    FFUploadedFile? name,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Add image in library Copy',
      apiUrl: 'https://pictsManager.com/putImageInLibrary',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'token': token,
        'name': name,
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
    return ApiManager.instance.makeApiCall(
      callName: 'getImages',
      apiUrl: 'https://pictsManager.com/getImage',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'token': token,
        'id': id,
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
