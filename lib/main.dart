import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sau_layer_app/core/flavor_config.dart';
import 'package:sau_layer_app/presentation/nasa_history/bloc/nasa_history_bloc.dart';
import 'package:sau_layer_app/presentation/nasa_history/page/nasa_history_page.dart';
import 'package:sau_layer_app/core/service_locator.dart';

// Default entry point (`flutter run`) runs the dev flavor.
// Use lib/main_dev.dart, lib/main_uat.dart or lib/main_prod.dart to pick one.
void main() => bootstrap(Flavor.dev);

void bootstrap(Flavor flavor) {
  FlavorConfig.init(flavor);
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: config.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) => config.isProd
          ? child!
          : Banner(
              message: config.bannerLabel,
              location: BannerLocation.topEnd,
              textDirection: TextDirection.ltr,
              layoutDirection: TextDirection.ltr,
              child: child!,
            ),
      home: MultiBlocProvider(providers: [
        BlocProvider<NasaHistoryBloc>(
          create: (context) => getIt<NasaHistoryBloc>(),
        ),
      ], child: const NasaHistoryPage()),
    );
  }
}
