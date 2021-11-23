part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial() : super();
}

class WeatherFound extends WeatherState {
  final Weather weather;

  const WeatherFound({required this.weather}) : super();

  WeatherFound copyWith({required Weather weather}) {
    return WeatherFound(
      weather: weather,
    );
  }
}

class WeatherSend extends WeatherState {
  const WeatherSend() : super();
}

class WeatherError extends WeatherState {
  const WeatherError() : super();
}

class WeatherSending extends WeatherState {
  const WeatherSending() : super();
}
