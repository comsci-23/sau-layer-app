import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sau_layer_app/core/service_locator.dart';
import 'package:sau_layer_app/main.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart';
import 'package:sau_layer_app/presentation/nasa_history/page/nasa_history_page.dart';

class MockNasaHistoryBloc extends MockBloc<NasaHistoryEvent, NasaHistoryState>
    implements NasaHistoryBloc {}

void main() {
  late MockNasaHistoryBloc mockBloc;

  setUp(() {
    mockBloc = MockNasaHistoryBloc();
    getIt.registerFactory<NasaHistoryBloc>(() => mockBloc);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('MyApp shows NasaHistoryPage on start', (tester) async {
    when(() => mockBloc.state).thenReturn(NasaHistoryLoading());

    await tester.pumpWidget(const MyApp());

    expect(find.byType(NasaHistoryPage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
