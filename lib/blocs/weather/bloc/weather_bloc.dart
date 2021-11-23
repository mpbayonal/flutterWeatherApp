import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logysto_app/blocs/weather/models/weather.dart';
import 'package:logysto_app/blocs/weather/resources/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _WeatherRepository = WeatherRepository();
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is SendWeather) {
      yield* _mapSendWeather(event, state);
    }
    if (event is InitWeather) {
      yield WeatherInitial();
    }
  }

  /// Mapea el evento de creat el usuario
  Stream<WeatherState> _mapSendWeather(
      SendWeather event, WeatherState state) async* {
    try {
      yield const WeatherSending();
      print("send");
      dynamic response =
          await _WeatherRepository.getWeather(event.latitude, event.longitude);
      print(response);
      Weather varTemp = Weather.fromMap(response);
      print(varTemp);
      yield WeatherFound(weather: varTemp);
    } on Exception catch (e) {
      print(e);
      yield const WeatherError();
    }
  }
}
