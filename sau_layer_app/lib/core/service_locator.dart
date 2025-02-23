import 'package:get_it/get_it.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart';
import 'package:sau_layer_data/domain/usecases/fetch_layer_data.dart';
import 'package:sau_layer_data/data/datasources/nasa_layer_service.dart';
import 'package:sau_layer_data/domain/repositories/nasa_layer_repository.dart';
import 'package:sau_layer_data/data/repositories/nasa_layer_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<NasaLayerService>(() => NasaLayerServiceImpl());

  getIt.registerLazySingleton<NasaLayerRepository>(
    () => NasaLayerRepositoryImpl(getIt()), 
  );

  getIt.registerLazySingleton<FetchLayerData>(() => FetchLayerData(getIt()));

  getIt.registerFactory(() => NasaHistoryBloc(fetchLayerData: getIt()));
}
