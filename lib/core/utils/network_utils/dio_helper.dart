import 'dart:async';
import 'package:dio/dio.dart';
import '../../error/exceptions.dart';
import '../debugging_utils/debugging_helper.dart';
import 'api_endpoints.dart';

abstract class DioHelper {
  Future<dynamic> post({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> patch({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> get({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> delete({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> put({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  });
}

class DioImpl extends DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: '$baseUrl',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
    ),
  );

  @override
  Future post({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut;
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = '$baseUrl';
    }

    dio.options.headers = {
      // 'Accept-Language': isArabic ? 'ar' : 'en',
      // if (isMultipart) 'Content-Type': 'multipart/form-data',
      // if (!isMultipart) 'Content-Type': 'application/json',
      // if (!isMultipart) 'Accept': 'application/json',
      // if (token != null) 'authentication': '${base == null ? 'Bearer' : ''} $token'

      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      'Accept': 'application/json',
      'Authorization': '$token',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrinter('URL => ${dio.options.baseUrl + url}');
    debugPrinter('Header => ${dio.options.headers.toString()}');
    debugPrinter('Body => ${data}');
    debugPrinter('Query => $query');

    return await request(
      () async => await dio.post(
        url,
        data: data,
        queryParameters: query,
        // onSendProgress: progressCallback,
        // cancelToken: cancelToken,
        //   debugPrint(total.toString());
        //   debugPrint(count.toString());
        // },
      ),
    );
  }

  @override
  Future patch({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut;
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = '$baseUrl';
    }

    dio.options.headers = {
      // 'Accept-Language': isArabic ? 'ar' : 'en',
      // if (isMultipart) 'Content-Type': 'multipart/form-data',
      // if (!isMultipart) 'Content-Type': 'application/json',
      // if (!isMultipart) 'Accept': 'application/json',
      // if (token != null) 'authentication': '${base == null ? 'Bearer' : ''} $token'
      // if (token != null) 'Authorization': '$token'

      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      'Accept': 'application/json',
      'Authorization': '$token',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrinter('URL => ${dio.options.baseUrl + url}');
    debugPrinter('Header => ${dio.options.headers.toString()}');
    debugPrinter('Body => ${data}');
    debugPrinter('Query => $query');

    return await request(
      () async => await dio.patch(
        url,
        data: data,
        queryParameters: query,
        // onSendProgress: progressCallback,
        // cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future get({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut;
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = '$baseUrl';
    }

    dio.options.headers = {
      // 'Accept-Language': isArabic ? 'ar' : 'en',
      // if (isMultipart) 'Content-Type': 'multipart/form-data',
      // if (!isMultipart) 'Content-Type': 'application/json',
      // if (!isMultipart) 'Accept': 'application/json',
      // if (token != null) 'authentication': '${base == null ? 'Bearer' : ''} $token'
      // if (token != null) 'Authorization': '$token'

      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      'Accept': 'application/json',
      'Authorization': '$token',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrinter('URL => ${dio.options.baseUrl + url}');
    debugPrinter('Header => ${dio.options.headers.toString()}');
    debugPrinter('Body => ${data}');
    debugPrinter('Query => $query');

    return await request(
      () async => await dio.get(
        url,
        queryParameters: query,
        // cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future delete({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut;
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = '$baseUrl';
    }

    dio.options.headers = {
      // 'Accept-Language': isArabic ? 'ar' : 'en',
      // if (isMultipart) 'Content-Type': 'multipart/form-data',
      // if (!isMultipart) 'Content-Type': 'application/json',
      // if (!isMultipart) 'Accept': 'application/json',
      // if (token != null) 'authentication': '${base == null ? 'Bearer' : ''} $token'
      // if (token != null) 'Authorization': '$token'

      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      'Accept': 'application/json',
      'Authorization': '$token',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrinter('URL => ${dio.options.baseUrl + url}');
    debugPrinter('Header => ${dio.options.headers.toString()}');
    debugPrinter('Body => ${data}');
    debugPrinter('Query => $query');

    return await request(
      () async => await dio.delete(
        url,
        queryParameters: query,
        data: data,
        // cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future put({
    String? base,
    required String url,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    Duration? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut;
    }

    if (base != null) {
      dio.options.baseUrl = base;
    } else {
      dio.options.baseUrl = '$baseUrl';
    }

    dio.options.headers = {
      // 'Accept-Language': isArabic ? 'ar' : 'en',
      // if (isMultipart) 'Content-Type': 'multipart/form-data',
      // if (!isMultipart) 'Content-Type': 'application/json',
      // if (!isMultipart) 'Accept': 'application/json',
      // 'APP-VERSION': appVersion,
      // if (token != null) 'authentication': '${base == null ? 'Bearer' : ''} $token'

      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      'Accept': 'application/json',
      'Authorization': '$token',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }

    debugPrinter('URL => ${dio.options.baseUrl + url}');
    debugPrinter('Header => ${dio.options.headers.toString()}');
    debugPrinter('Body => ${data}');
    debugPrinter('Query => $query');

    return await request(
      () async => await dio.put(
        url,
        queryParameters: query,
        data: data,
        // cancelToken: cancelToken,
      ),
    );
  }
}

extension on DioHelper {
  Future request(Future<Response> Function() request) async {
    try {
      final r = await request.call();
      debugPrinter("Response => ${r.data}");
      return r;
    } on DioError catch (e) {
      debugPrinter("Error Message => ${e.message}");
      debugPrinter("Error => ${e.error.toString()}");

      if (e.response != null) {
        debugPrinter("Error Response => ${e.response}");
        debugPrinter("Error Response Message => ${e.response!.statusMessage}");
        debugPrinter("Error Response Status Code => ${e.response!.statusCode}");
        debugPrinter("Error Response Data => ${e.response!.data}");

        throw ServerException(
          code: e.response!.statusCode!,
          // message: e.response!.data['msg'],
          message: e.response!.data,
        );
      } else {
        throw ServerException(
          code: 500,
          message: e.message!,
        );
      }
    } catch (e) {
      throw Exception();
    }
  }
}