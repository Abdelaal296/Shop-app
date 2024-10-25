import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio ;
  static init(){
    dio=Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl:'https://student.valuxapps.com/api/',

      ),
    );
  }
  static Future<Response> getData({
  required String url ,
   Map<String,dynamic>? query ,
    String lang ='en',
    String? token ,
})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return await dio!.get(url,
      queryParameters: query,
    );
  }
  static Future<Response> postData({
  required String url,
  Map<String, dynamic>? query,
  required Map<String, dynamic> data,
  String lang = 'en',
  String? token,
}) async {
  print("Request data: $data");
  print("Dio instance: $dio");
  print("Token type: ${token.runtimeType}");
  
  // Ensure token is a String before setting in headers
  dio!.options.headers = {
    'Content-Type': 'application/json',
    'lang': lang,
    'Authorization': token is String ? token : '',
  };
  
  return await dio!.post(
    url,
    queryParameters: query,
    data: data,
  );
}



  static Future<Response> putData({
    required String url ,
    Map<String,dynamic>? query ,
    required Map<String,dynamic> data,
    String lang ='en',
    String? token ,
  })async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}