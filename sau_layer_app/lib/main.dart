import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart';
import 'package:sau_layer_app/presentation/nasa_history/page/nasa_history_page.dart';
import 'package:sau_layer_app/core/service_locator.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAU Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<NasaHistoryBloc>(
          create: (context) => getIt<NasaHistoryBloc>(),
        ),
      ], child: const NasaHistoryPage()),
    );
  }
}
