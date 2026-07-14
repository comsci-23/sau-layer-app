import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart';
import 'package:sau_layer_data/core/error/failure.dart';
import 'package:sau_layer_data/domain/entities/nasa_layer_data.dart';
import 'package:sau_layer_data/domain/usecases/fetch_layer_data.dart'
    as usecase;

class MockNasaHistory extends Mock implements usecase.NasaHistory {}

void main() {
  late MockNasaHistory mockNasaHistory;

  setUp(() {
    mockNasaHistory = MockNasaHistory();
  });

  final tEntities = [
    NasaLayerData(
      id: '1',
      title: 'Title1',
      description: 'Desc1',
      imageUrl: 'http://example.com/1.jpg',
    ),
  ];

  NasaHistoryBloc buildBloc() =>
      NasaHistoryBloc(nasaHistory: mockNasaHistory);

  test('initial state is NasaHistoryInitial', () {
    expect(buildBloc().state, isA<NasaHistoryInitial>());
  });

  group('NasaHistory event', () {
    blocTest<NasaHistoryBloc, NasaHistoryState>(
      'emits [Loading, HasData] when usecase returns data successfully',
      build: () {
        when(() => mockNasaHistory.call())
            .thenAnswer((_) async => Right(tEntities));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const NasaHistory()),
      expect: () => [
        isA<NasaHistoryLoading>(),
        isA<NasaHistoryHasData>()
            .having((s) => s.model.items.length, 'items length', 1)
            .having((s) => s.model.items.first.id, 'first id', '1'),
      ],
      verify: (_) {
        verify(() => mockNasaHistory.call()).called(1);
      },
    );

    blocTest<NasaHistoryBloc, NasaHistoryState>(
      'emits [Loading, Error] when usecase returns a failure',
      build: () {
        when(() => mockNasaHistory.call())
            .thenAnswer((_) async => Left(ServerFailure()));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const NasaHistory()),
      expect: () => [
        isA<NasaHistoryLoading>(),
        const NasaHistoryError('Failed to fetch data'),
      ],
    );

    blocTest<NasaHistoryBloc, NasaHistoryState>(
      'emits [Loading, Error] when usecase throws an exception',
      build: () {
        when(() => mockNasaHistory.call()).thenThrow(Exception('boom'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const NasaHistory()),
      expect: () => [
        isA<NasaHistoryLoading>(),
        const NasaHistoryError('An error occurred'),
      ],
    );
  });
}
