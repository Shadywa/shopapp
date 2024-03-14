import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;

  static init(){
    dio =Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true ,
         headers: {
           'Content-Type':'application/json'
         }
      ),
    );
  }


  static Future<Response> getAllData({
    required String url,
    Map<String,dynamic>? query,
    String lang='en',
    dynamic token,
  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json'
    };
    return await dio.get(url,queryParameters: query);
  }



  static Future<Response>PostData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang='en',
    String? token,

  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json'
    };
    return await dio.post(
        url,
      queryParameters: query,
      data: data,

    );
}
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
































//اللي تحت بدون تعديل تبع ال news app

// import 'package:dio/dio.dart';
//
// class DioHelper{
//   static late Dio dio;
//
//   static init(){
//    dio =Dio(
//      BaseOptions(
//        baseUrl: 'https://newsapi.org/',
//        receiveDataWhenStatusError: true,
//      ),
//    );
//   }
//
//   static Future<Response> getAllData({
//   required String url,
//     required Map<String,dynamic> query
// })async{
//     return await dio.get(url,queryParameters: query);
// }
//
// }