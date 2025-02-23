import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sau_layer_app/presentation/model/nasa_history_model.dart';
import 'package:sau_layer_data/domain/usecases/fetch_layer_data.dart';

part 'nasa_history_event.dart';
part 'nasa_history_state.dart';

class NasaHistoryBloc extends Bloc<NasaHistoryEvent, NasaHistoryState> {
  final FetchLayerData fetchLayerData;

  NasaHistoryBloc({required this.fetchLayerData})
      : super(NasaHistoryInitial()) {

    on<NasaHistoryEvent>((event, emit) async {
      // TODO: implement event handler
      emit(NasaHistoryLoading());
      print('NasaHistoryBloc =====> $event');

      try {
        final result = await fetchLayerData();

        result.fold(
          (failure) => emit(NasaHistoryError()),
          (data) {
            final nasaHistoryData = NasaHistoryHasData(
              NasaHistoryModel(
                id: data[0].id,
                title: data[0].title,
                description: data[0].description,
                imageUrl: data[0].imageUrl,
              ),
            );
            emit(nasaHistoryData);
          },
        );
      } catch (e) {
        print('NasaHistoryBloc =====> Error');
        emit(NasaHistoryError());
      }
    });
  }
}
