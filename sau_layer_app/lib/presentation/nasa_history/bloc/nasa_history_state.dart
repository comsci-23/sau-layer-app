// filepath: /Users/chaiwat.dev/Documents/sau-layer-app/sau_layer_app/lib/presentation/nasa_history/bloc/nasa_history_state.dart
part of 'nasa_history_bloc.dart';

abstract class NasaHistoryState extends Equatable {
  const NasaHistoryState();

  @override
  List<Object> get props => [];
}

class NasaHistoryInitial extends NasaHistoryState {}

class NasaHistoryLoading extends NasaHistoryState {}

class NasaHistoryError extends NasaHistoryState {
  final String message;

  const NasaHistoryError(this.message);

  @override
  List<Object> get props => [message];
}

class NasaHistoryHasData extends NasaHistoryState {
  final NasaHistoryListModel model;

  const NasaHistoryHasData(this.model);

  @override
  List<Object> get props => [model];
}