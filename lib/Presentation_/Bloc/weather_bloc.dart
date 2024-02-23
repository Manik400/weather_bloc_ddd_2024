import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Domain_/Repo/weather_repo.dart';
import '../../Domain_/entities/weather.dart';
import '../../Infrastructure_/weather_repo_impl.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = WeatherRepoImpl();

  WeatherBloc() : super(WeatherInitialState()) {
    on<GetWeatherByCityEvent>((event, emit) => _mapGetWeatherByCityEventToState(event, emit));
    on<GetWeatherByLocationEvent>((event, emit) => _mapGetWeatherByLocationEventToState(event, emit));
  }

  Future<void> _mapGetWeatherByCityEventToState(GetWeatherByCityEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    try {
      Weather weather = await weatherRepository.getWeatherByCity(event.cityName);
      emit(WeatherLoadedState(weather));
    } catch (e) {
      emit(WeatherErrorState("Failed to get weather data"));
    }
  }

  Future<void> _mapGetWeatherByLocationEventToState(GetWeatherByLocationEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    try {
      Weather weather = await weatherRepository.getWeatherByLocation();
      emit(WeatherLoadedState(weather));
    } catch (e) {
      emit(WeatherErrorState("Failed to get weather data"));
    }
  }
}


abstract class WeatherEvent {}

class GetWeatherByCityEvent extends WeatherEvent {
  final String cityName;
  GetWeatherByCityEvent(this.cityName);
}

class GetWeatherByLocationEvent extends WeatherEvent {}

// States
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final Weather weather;
  WeatherLoadedState(this.weather);
}

class WeatherErrorState extends WeatherState {
  final String errorMessage;
  WeatherErrorState(this.errorMessage);
}
