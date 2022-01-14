import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;

  final baseUrl = "http://127.0.0.1:5001/";

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await Dio().get("http://127.0.0.1:5001/peoples");
      print(response);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, errorInterceptorHandler) {
        print(error.message);
      },
      onRequest: (request, requestInterceptorHandler) {
        print("${request.method} ${request.path}");
      },
      onResponse: (response, responseInterceptorHandler) {
        print(response.data);
      },
    ));
  }
}