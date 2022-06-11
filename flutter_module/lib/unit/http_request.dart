import 'package:dio/dio.dart';

class HttpConfig {
  static const baseURL = "";
  static const timeOut = 5000;
}

// 官方文档： https://github.com/flutterchina/dio/blob/master/README-ZH.md
class HttpRequest {
  static final BaseOptions options = BaseOptions(
      baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeOut);
  static final Dio dio = Dio(options);

  static Future<T> request<T>(String url,
      {String method = 'get',
      Map<String, dynamic> params,
      Interceptor inter}) async {
    final options = Options(method: method);

    //拦截器
    Interceptor dInter =
        InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 1.在进行任何网络请求的时候, 可以添加一个loading显示

      // 2.很多页面的访问必须要求携带Token,那么就可以在这里判断是有Token

      // 3.对参数进行一些处理,比如序列化处理等
      print("拦截请求");
      print(options);
      return options;
    }, onResponse: (Response response) {
      print("拦截响应");
      print(response);
      return response;
    }, onError: (DioError error) {
      print("拦截错误");
      print(error);
      return error;
    });

    List<Interceptor> inters = [dInter];

    if (inter != null) {
      inters.add(inter);
    }
    dio.interceptors.addAll(inters);

    // 发送网络请求
    try {
      Response response =
          await dio.request<T>(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      print("拦截响应");
      return Future.error(e);
    }
  }
}

// import 'package:dio/dio.dart';

// import 'package:dio/dio.dart';

// void getHttp() async {
//   try {
//     var response = await Dio().get('http://www.google.com');
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }
// class Dio {
// }

// class BaseOptions {}
