import 'package:logysto_app/blocs/api.dart';

class WeatherRepository {
  final Api _apiInstance = Api.getInstance();
  static final _instance = WeatherRepository._internal();

  factory WeatherRepository() {
    return _instance;
  }

  WeatherRepository._internal();
  Future<dynamic> getWeather(String latitude, String longitude) async {
    print(latitude);
    final response = await _apiInstance.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=');

    return response;
  }
}
