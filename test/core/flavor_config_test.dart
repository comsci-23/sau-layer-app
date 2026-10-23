import 'package:flutter_test/flutter_test.dart';
import 'package:sau_layer_app/core/flavor_config.dart';

void main() {
  tearDown(() => FlavorConfig.init(Flavor.dev));

  test('defaults to dev', () {
    expect(FlavorConfig.instance.flavor, Flavor.dev);
  });

  test('fromFlavor sets title for each flavor', () {
    expect(FlavorConfig.fromFlavor(Flavor.dev).appTitle, 'SAU Demo DEV');
    expect(FlavorConfig.fromFlavor(Flavor.uat).appTitle, 'SAU Demo UAT');
    expect(FlavorConfig.fromFlavor(Flavor.prod).appTitle, 'SAU Demo');
  });

  test('init replaces the current instance', () {
    FlavorConfig.init(Flavor.uat);

    expect(FlavorConfig.instance.flavor, Flavor.uat);
    expect(FlavorConfig.instance.bannerLabel, 'UAT');
    expect(FlavorConfig.instance.isProd, isFalse);
  });

  test('prod is marked as prod', () {
    FlavorConfig.init(Flavor.prod);

    expect(FlavorConfig.instance.isProd, isTrue);
  });
}
