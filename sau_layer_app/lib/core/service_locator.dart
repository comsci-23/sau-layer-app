import 'package:get_it/get_it.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart' as bloc;
import 'package:sau_layer_data/domain/usecases/fetch_layer_data.dart' as usecase;
import 'package:sau_layer_data/data/datasources/nasa_layer_service.dart';
import 'package:sau_layer_data/domain/repositories/nasa_layer_repository.dart';
import 'package:sau_layer_data/data/repositories/nasa_layer_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<NasaLayerService>(() => NasaLayerServiceImpl());

  getIt.registerLazySingleton<NasaLayerRepository>(
    () => NasaLayerRepositoryImpl(getIt()), 
  );
  // register usecase
  getIt.registerLazySingleton<usecase.NasaHistory>(() => usecase.NasaHistory(getIt()));


  // register bloc
  getIt.registerFactory(() => bloc.NasaHistoryBloc(nasaHistory: getIt()));
}