import 'package:breaking_bad/constants/strings.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:dio/dio.dart';

class CharactersWebServices { //كانها Dio Helper
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        // بقوله ان ف 20 ثانية تحاول توصل للسيرفر فيهم وبعدها تطلع ايرور لليوزر لو معرفتش توصله
        receiveTimeout: 20 * 1000,
      ),
    );
  }

  /// doing webCallServices
  /// list of model

  Future<dynamic> getAllCharacters() async {
    try {
      Response response = await dio!.get('characters');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  Future<dynamic> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio!.get('quote' , queryParameters: {'author':charName});
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
