import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Tests cannot download fonts, so fall back to the default font.
  GoogleFonts.config.allowRuntimeFetching = false;
  await testMain();
}
