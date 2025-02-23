part of 'nasa_history_bloc.dart';

@immutable
sealed class NasaHistoryState extends Equatable {
  const NasaHistoryState();

  @override
  List<Object> get props => [];
}

final class NasaHistoryInitial extends NasaHistoryState {}

final class NasaHistoryLoading extends NasaHistoryState {}

final class NasaHistoryError extends NasaHistoryState {}

final class NasaHistoryHasData extends NasaHistoryState {
  final NasaHistoryModel model;

  const NasaHistoryHasData(this.model);

  @override
  List<Object> get props => [model];
}
