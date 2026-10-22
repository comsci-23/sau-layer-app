# sau_layer_app — NASA Image History Viewer

[![Flutter Version](https://img.shields.io/badge/flutter-3.x-blue.svg)](https://flutter.dev/) [![Dart Version](https://img.shields.io/badge/dart-3.5+-blue.svg)](https://dart.dev/) ![version](https://img.shields.io/badge/version-v1.0.0-blue)

## About the Project
`sau_layer_app` is a Flutter application that fetches and displays a history of NASA imagery from the [NASA Images API](https://images-api.nasa.gov/), presented as a scrollable feed with a detail view for each item. The app is built with Clean Architecture, splitting the presentation layer (this repo) from the domain/data layer, which lives in the companion [`sau_layer_data`](https://github.com/com-sci-23/sau-layer-data) package.

## Features

- **NASA Image Feed**: Fetches images tagged `earth` from the NASA Images API and renders them as a scrollable, Instagram-style feed (title, thumbnail, description).
- **Image Detail View**: Tapping an item opens a detail page with a Hero image transition, full description, and item ID.
- **State Management with BLoC**: `NasaHistoryBloc` drives Loading / Error / HasData states for the feed.
- **Dependency Injection**: Services, repositories, use cases, and blocs are wired up via `get_it` in `lib/core/service_locator.dart`.
- **Custom Theming**: Centralized color palette in `lib/utils/app_colors.dart`, with `google_fonts` (Poppins/Roboto) for typography.
- **Unit & Widget Test Coverage**: Tests for the bloc, model parsing, page rendering, and color utilities.
- **Static Analysis / Quality Gate**: SonarQube scanning configured via `sonar-project.properties`.

## Structure Architecture
### **Clean Architecture**
This project follows Clean Architecture, split across two repositories:
- **Presentation Layer** (this repo, `sau_layer_app`): Renders the UI and reacts to user input.
    - State Management — BLoC (`NasaHistoryBloc`, `NasaHistoryEvent`, `NasaHistoryState`)
    - Pages/Widgets (`nasa_history_page.dart`, `nasa_detail_page.dart`)
    - Dependency injection (`service_locator.dart`)
- **Domain Layer** (in [`sau_layer_data`](https://github.com/com-sci-23/sau-layer-data)): Business logic decoupled from UI/framework concerns.
    - Entities (`NasaLayerData`)
    - Use Cases (`NasaHistory`)
    - Repository interfaces (`NasaLayerRepository`)
- **Data Layer** (in [`sau_layer_data`](https://github.com/com-sci-23/sau-layer-data)): Connects to external data sources and maps data into domain models.
    - Repository implementation (`NasaLayerRepositoryImpl`)
    - Remote data source (`NasaLayerServiceImpl`, calling the NASA Images API)
    - Error handling (`Failure`)

### **Project Structure**

```
lib/
├── core/
│   └── service_locator.dart     # get_it dependency injection setup
│
├── presentation/
│   ├── model/
│   │   └── nasa_history_model.dart   # Presentation-layer view model + JSON mapping
│   └── nasa_history/
│       ├── bloc/                     # NasaHistoryBloc, Event, State
│       └── page/                     # NasaHistoryPage (feed), NasaDetailPage (detail)
│
├── utils/
│   └── app_colors.dart          # App-wide color palette
│
└── main.dart                    # App entry point
```

- **lib/core/**: Dependency injection setup (`get_it`).
- **lib/presentation/**: Feed and detail pages, bloc, and the presentation-layer model for NASA history items.
- **lib/utils/**: Shared UI utilities (colors).
- **lib/main.dart**: App entry point; wires up `MultiBlocProvider` and launches `NasaHistoryPage`.

## Repository Structure
1. **[sau_layer_app](https://github.com/com-sci-23/sau-layer-app "sau_layer_app")** (this repo): Presentation layer — Flutter UI, blocs, and dependency injection.
2. **[sau_layer_data](https://github.com/com-sci-23/sau-layer-data "sau_layer_data")**: Domain + Data layer — entities, use cases, repositories, and the NASA Images API data source.

## Installation and Setup

### **Installation Steps**

```bash
git clone https://github.com/com-sci-23/sau-layer-app.git
cd sau-layer-app/sau_layer_app
flutter pub get
```

## Dependencies

This project relies on the following main dependencies:

- **Flutter SDK** (Dart SDK `^3.5.4`): For building the cross-platform UI.
- **flutter_bloc**: State management using the BLoC pattern.
- **get_it**: Service locator for dependency injection.
- **provider**: Used alongside BLoC for widget-tree state access.
- **equatable**: Value equality for bloc events/states.
- **dartz**: Functional programming utilities (`Either`) used for error handling in the data layer.
- **http**: REST calls to the NASA Images API.
- **rxdart**: Reactive stream utilities.
- **google_fonts**: Custom typography (Poppins, Roboto).
- **cupertino_icons**: iOS-style icon set.
- **sau_layer_data**: Domain/data layer package, pulled directly from its [git repository](https://github.com/com-sci-23/sau-layer-data).

All dependencies are listed in [`pubspec.yaml`](pubspec.yaml). To install them, run:

```sh
flutter pub get
```

The `sau_layer_data` package is consumed as a git dependency:

```yaml
dependencies:
  sau_layer_data:
    git:
      url: https://github.com/com-sci-23/sau-layer-data
      path: sau_layer_data
      ref: main
```

## Testing and Quality Assurance

This project is scanned with SonarQube; scan settings are defined in [`sonar-project.properties`](sonar-project.properties) (project key `sau_layer_app`, analyzer mode `FLUTTER`).

## Testing Framework

This project uses the following testing frameworks and tools:

- **flutter_test**: Flutter's built-in framework for unit and widget tests.
- **mockito**: Mocking framework for creating mock objects in tests.
- **mocktail**: Null-safety-friendly mocking, used for mocking the bloc in widget tests.
- **bloc_test**: Testing utilities specifically designed for BLoC state management.

Existing tests:

```
test/
├── main_test.dart
├── presentation/
│   ├── model/nasa_history_model_test.dart
│   └── nasa_history/page/page_test.dart
└── utils/app_colors_test.dart
```

### Running Tests

```bash
# Install dependencies
flutter pub get

# Run all tests with coverage
flutter test --coverage

# Generate HTML report for coverage
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
open coverage/html/index.html
```

Note: For macOS you need to have lcov installed (`brew install lcov`).

## Additional Information

- Data is sourced live from the [NASA Images API](https://images-api.nasa.gov/search?q=earth&media_type=image) (search query fixed to `earth`, limited to the first 50 results).
- UI colors are centralized in `lib/utils/app_colors.dart`; typography uses `google_fonts` (Poppins for titles, Roboto for body text).
- Dependency wiring (service → repository → use case → bloc) happens in `lib/core/service_locator.dart` via `get_it`.

### Branch Strategy

Branches observed in this repository:

- `main`: Mainline/production code.
- `develop`: Integration branch.
- `releases/*` (e.g. `releases/releases1.0.0`): Release branches.
- `feature/*` (e.g. `feature/get_use_case`, `feature/unit_test`): Feature development branches.

## Contact

For questions about this project, please contact the repository maintainers at [com-sci-23](https://github.com/com-sci-23).
