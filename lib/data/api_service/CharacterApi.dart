import 'package:api/constants/string.dart';
import 'package:dio/dio.dart';

class CharactersApi {
  late Dio dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 20*1000),
      receiveTimeout: Duration(milliseconds: 20*1000),
    );
    dio=Dio(options);
  }

  Future<List<dynamic>> getAllChars() async {
    try {
      Response response = await dio.get('character/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20');
      print("sofian is here "+response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
