import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;

  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = 'fcf7a0d0631e46a894f95615230110';

  WeatherService(this.dio);
  // this is the getcurrentweather to get data from API
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      // we used Dio package to connect to the API
      // Dio is similar to http package
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      // this error message already in the API service when there is no data
      // or bad request there is error message appears
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops there was an error, try later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('oops there was an error, try later');
    }
  }
}
