import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sau_layer_app/presentation/model/nasa_history_model.dart';
import 'package:sau_layer_data/domain/usecases/fetch_layer_data.dart'
    as usecase;

part 'nasa_history_event.dart';
part 'nasa_history_state.dart';

class NasaHistoryBloc extends Bloc<NasaHistoryEvent, NasaHistoryState> {
  final usecase.NasaHistory nasaHistory;

  NasaHistoryBloc({required this.nasaHistory}) : super(NasaHistoryInitial()) {
    on<NasaHistoryEvent>((event, emit) async {
      // TODO: implement event handler
      emit(NasaHistoryLoading());
      debugPrint('NasaHistoryBloc =====> $event');

      try {
        final result = await nasaHistory();

        result.fold(
          (failure) {
            return emit(const NasaHistoryError('Failed to fetch data'));
          },
          (data) {
            final nasaHistoryData = NasaHistoryHasData(
              NasaHistoryListModel(
                items: data
                    .map((item) => NasaHistoryModel(
                          id: item.id,
                          title: item.title,
                          description: item.description,
                          imageUrl: item.imageUrl,
                        ))
                    .toList(),
              ),
            );
            return emit(nasaHistoryData);
          },
        );
      } catch (e) {
        debugPrint('NasaHistoryBloc =====> Error: $e');
        return emit(const NasaHistoryError('An error occurred'));
      }
    });
  }
}
