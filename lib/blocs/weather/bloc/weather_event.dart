part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class InitWeather extends WeatherEvent {
  const InitWeather();
}

class SendWeather extends WeatherEvent {
  final String latitude;
  final String longitude;

  const SendWeather({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Send Weather';
}
