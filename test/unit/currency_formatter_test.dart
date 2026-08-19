import 'package:flutter_test/flutter_test.dart';
import 'package:am_tips/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter', () {
    test('formats BIF without decimal places', () {
      expect(CurrencyFormatter.format(5000, 'BIF'), '5,000 BIF');
      expect(CurrencyFormatter.formatNumber(5000, 'BIF'), '5,000');
    });

    test('formats RWF and UGX without decimal places', () {
      expect(CurrencyFormatter.format(10000, 'RWF'), '10,000 RWF');
      expect(CurrencyFormatter.format(25000, 'UGX'), '25,000 UGX');
    });

    test('formats USD with 2 decimal places', () {
      expect(CurrencyFormatter.format(50, 'USD'), '50.00 USD');
      expect(CurrencyFormatter.formatNumber(50, 'USD'), '50.00');
    });

    test('parses input correctly', () {
      expect(CurrencyFormatter.parse('5,000', 'BIF'), 5000);
      expect(CurrencyFormatter.parse(' 12 500 ', 'BIF'), 12500);
      expect(CurrencyFormatter.parse('invalid', 'BIF'), isNull);
    });

    test('formats compact amounts', () {
      expect(CurrencyFormatter.formatCompact(5000, 'BIF'), '5K BIF');
    });
  });
}
