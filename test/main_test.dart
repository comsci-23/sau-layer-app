import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sau_layer_app/core/flavor_config.dart';
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
    FlavorConfig.init(Flavor.dev);
    await getIt.reset();
  });

  testWidgets('MyApp shows NasaHistoryPage on start', (tester) async {
    when(() => mockBloc.state).thenReturn(NasaHistoryLoading());

    await tester.pumpWidget(const MyApp());

    expect(find.byType(NasaHistoryPage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('MyApp shows a flavor banner outside prod', (tester) async {
    when(() => mockBloc.state).thenReturn(NasaHistoryLoading());
    FlavorConfig.init(Flavor.uat);

    await tester.pumpWidget(const MyApp());

    final banner = tester.widget<Banner>(find.byType(Banner));
    expect(banner.message, 'UAT');
  });

  testWidgets('MyApp hides the flavor banner in prod', (tester) async {
    when(() => mockBloc.state).thenReturn(NasaHistoryLoading());
    FlavorConfig.init(Flavor.prod);

    await tester.pumpWidget(const MyApp());

    expect(find.byType(Banner), findsNothing);
  });
}
