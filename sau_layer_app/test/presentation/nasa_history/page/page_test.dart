import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart';
import 'package:sau_layer_app/presentation/nasa_history/page/nasa_history_page.dart';
import 'package:sau_layer_app/presentation/model/nasa_history_model.dart';

class MockNasaHistoryBloc extends MockBloc<NasaHistoryEvent, NasaHistoryState>
    implements NasaHistoryBloc {}

void main() {
  late MockNasaHistoryBloc mockBloc;

  setUp(() {
    mockBloc = MockNasaHistoryBloc();
  });

  Future<void> _buildWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<NasaHistoryBloc>(
          create: (_) => mockBloc,
          child: const NasaHistoryPage(),
        ),
      ),
    );
  }

  testWidgets('displays data list when NasaHistoryHasData', (tester) async {
    await mockNetworkImagesFor(() async {
      when(() => mockBloc.state).thenReturn(
        NasaHistoryHasData(
          NasaHistoryListModel(
            items: [
              NasaHistoryModel(
                title: 'Apollo 11',
                description: 'Moon landing mission',
                id: '1',
                imageUrl:
                    'https://mars.nasa.gov/system/news_items/main_images/10440_PIA25681-FigureA-web.jpg',
              ),
            ],
          ),
        ),
      );

      await _buildWidget(tester);

      expect(find.text('Test Develop Change'), findsOneWidget);
    });
  });
  testWidgets('displays loading indicator when NasaHistoryLoading',
      (tester) async {
    when(() => mockBloc.state).thenReturn(NasaHistoryLoading());
    await _buildWidget(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays error message when NasaHistoryError', (tester) async {
    when(() => mockBloc.state).thenReturn(const NasaHistoryError('Test Error'));
    await _buildWidget(tester);
    expect(find.textContaining('Error: Test Error'), findsOneWidget);
  });
}
