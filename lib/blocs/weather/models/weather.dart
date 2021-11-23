class Weather {
  String temp;

  String feels_like;

  String temp_min;
  String temp_max;
  String pressure;
  String humidity;
  String visibility;

  Weather(
      {required this.feels_like,
      required this.humidity,
      required this.pressure,
      required this.temp,
      required this.temp_max,
      required this.temp_min,
      required this.visibility});

  factory Weather.fromMap(Map<String, dynamic> weather) {
    return Weather(
        feels_like: weather['main']['feels_like'].toString(),
        humidity: weather['main']['humidity'].toString(),
        pressure: weather['main']['pressure'].toString(),
        temp: weather['main']['temp'].toString(),
        temp_max: weather['main']['temp_max'].toString(),
        visibility: weather['main']['visibility'].toString(),
        temp_min: weather['main']['temp_min'].toString());
  }
}
