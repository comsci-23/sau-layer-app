part of 'nasa_history_bloc.dart';

@immutable
sealed class NasaHistoryEvent extends Equatable {
  const NasaHistoryEvent();

  @override
  List<Object?> get props => [];
}

class NasaHistory extends NasaHistoryEvent {
  final String? test1;
  final String? test2;
  final String? test3;
  final String? test4;
  final bool? test5;

  const NasaHistory({
    this.test1,
    this.test2,
    this.test3,
    this.test4,
    this.test5 = false,
  });

  @override
  List<Object?> get props => [test1, test1, test1, test1, test5];
}
