import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
