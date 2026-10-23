# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get                                   # also fetches sau_layer_data from git
flutter run                                       # launch the app
dart format .                                     # CI fails on any unformatted file
flutter analyze                                   # flutter_lints rules
flutter test                                      # all tests
flutter test test/presentation/nasa_history/bloc/nasa_history_bloc_test.dart   # single file
flutter test --plain-name "emits [Loading, HasData]"                            # single test by name
flutter test --coverage                           # writes coverage/lcov.info
./run.sh                                          # coverage + genhtml HTML report (needs `brew install lcov`)
```

CI (`.github/workflows/ci.yml`, Flutter 3.38.9 stable, triggered on pushes to `main` and on every PR) runs, in order: `dart format --output=none --set-exit-if-changed .`, `flutter analyze`, `flutter test --coverage`, then posts a coverage table to the job summary. Make sure all three pass locally before pushing.

## Architecture

This repo is only the **presentation layer** of a Clean Architecture split. The domain and data layers (entity `NasaLayerData`, use case `NasaHistory`, `NasaLayerRepository`/`NasaLayerRepositoryImpl`, `NasaLayerService`/`NasaLayerServiceImpl`, `Failure`) live in the separate `sau_layer_data` package. It is pulled as a git dependency (`github.com/comsci-23/sau-layer-data`, subdirectory `path: sau_layer_data`, `ref: main`) and is not vendored. Changes to fetching or parsing API data belong in that repo, not here. `pubspec.lock` pins the resolved commit, so new commits on that repo's `main` are only picked up after `flutter pub upgrade sau_layer_data`.

Data flow:
- `main.dart` calls `setup()` in `lib/core/service_locator.dart`, which registers everything in `get_it`: service → repository → use case as lazy singletons, and `NasaHistoryBloc` as a factory.
- `MyApp` provides the bloc via `MultiBlocProvider` using `getIt<NasaHistoryBloc>()`.
- `NasaHistoryPage` dispatches the `NasaHistory` event in `initState`. The bloc calls the use case, which returns `Either<Failure, List<NasaLayerData>>` (dartz). The bloc maps entities into the presentation-layer `NasaHistoryModel`/`NasaHistoryListModel` and emits `Initial → Loading → HasData | Error`. A `Left(Failure)` emits `NasaHistoryError('Failed to fetch data')`, and a thrown exception emits `NasaHistoryError('An error occurred')`. Tests assert on these exact strings.
- `NasaDetailPage` is pushed with `Navigator.push` and receives the model directly.

**Name collision:** the bloc event class and the domain use case are both called `NasaHistory`. Files that need the use case import `sau_layer_data/domain/usecases/fetch_layer_data.dart` `as usecase` and refer to `usecase.NasaHistory`. Keep this alias pattern.

## Testing conventions

- `test/flutter_test_config.dart` disables `GoogleFonts` runtime fetching for all tests, because tests have no network access.
- Mocking uses `mocktail` (not mockito, despite the README). Bloc tests use `bloc_test`'s `blocTest`. Widget tests use `MockBloc<NasaHistoryEvent, NasaHistoryState>` and wrap pumps in `mockNetworkImagesFor` (`network_image_mock`) because the pages render `Image.network`.
- Tests that pump `MyApp` register a mock bloc into `getIt` in `setUp` and call `getIt.reset()` in `tearDown` (see `test/main_test.dart`).

## Other

- SonarQube config is in `sonar-project.properties`, and the `Dockerfile` builds a SonarQube image with the sonar-flutter plugin. Comments in these files are in Thai.
- Branches: `main`, `develop`, `releases/*`, `feature/*`.
