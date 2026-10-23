enum Flavor { dev, uat, prod }

class FlavorConfig {
  final Flavor flavor;
  final String appTitle;

  const FlavorConfig._(this.flavor, this.appTitle);

  factory FlavorConfig.fromFlavor(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        return const FlavorConfig._(Flavor.dev, 'SAU Demo DEV');
      case Flavor.uat:
        return const FlavorConfig._(Flavor.uat, 'SAU Demo UAT');
      case Flavor.prod:
        return const FlavorConfig._(Flavor.prod, 'SAU Demo');
    }
  }

  static FlavorConfig _instance = FlavorConfig.fromFlavor(Flavor.dev);

  static FlavorConfig get instance => _instance;

  static void init(Flavor flavor) {
    _instance = FlavorConfig.fromFlavor(flavor);
  }

  bool get isProd => flavor == Flavor.prod;

  String get bannerLabel => flavor.name.toUpperCase();
}
