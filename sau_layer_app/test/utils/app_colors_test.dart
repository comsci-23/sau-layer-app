import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sau_layer_app/utils/app_colors.dart';

void main() {
  group('AppColors', () {
    test('primaryColor should be Colors.blue', () {
      expect(AppColors.primaryColor, Colors.blue);
    });

    test('backgroundColor should be Colors.black', () {
      expect(AppColors.backgroundColor, Colors.black);
    });

    test('cardBackgroundColor should be Colors.grey', () {
      expect(AppColors.cardBackgroundColor, Colors.grey);
    });

    test('textColor should be Colors.white', () {
      expect(AppColors.textColor, Colors.white);
    });

    test('secondaryTextColor should be Colors.grey', () {
      expect(AppColors.secondaryTextColor, Colors.grey);
    });

    test('shadowColor should be Colors.blue with 0.3 opacity', () {
      final expected = Colors.blue.withOpacity(0.3);
      expect(AppColors.shadowColor, expected);
    });

    test('gradientStartColor should be Colors.black', () {
      expect(AppColors.gradientStartColor, Colors.black);
    });

    test('gradientEndColor should be grey.shade900', () {
      final expected = Colors.grey.shade900;
      expect(AppColors.gradientEndColor, expected);
    });

    test('cardGradientStartColor should be black with 0.8 opacity', () {
      final expected = Colors.black.withOpacity(0.8);
      expect(AppColors.cardGradientStartColor, expected);
    });

    test('cardGradientEndColor should be transparent', () {
      expect(AppColors.cardGradientEndColor, Colors.transparent);
    });

    test('imageGradientStartColor should be black with 0.2 opacity', () {
      final expected = Colors.black.withOpacity(0.2);
      expect(AppColors.imageGradientStartColor, expected);
    });

    test('imageGradientEndColor should be transparent', () {
      expect(AppColors.imageGradientEndColor, Colors.transparent);
    });
  });
}