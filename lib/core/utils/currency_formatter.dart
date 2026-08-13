import 'package:intl/intl.dart';

/// Formats monetary amounts respecting per-currency decimal rules.
class CurrencyFormatter {
  CurrencyFormatter._();

  /// Currencies with no decimal places.
  static const Set<String> _noDecimalCurrencies = {
    'BIF', 'UGX', 'RWF',
  };

  /// Currencies with 2 decimal places.
  static const Set<String> _twoDecimalCurrencies = {
    'USD', 'EUR', 'KES', 'TZS',
  };

  /// Returns the number of fraction digits for a given currency.
  static int fractionDigits(String currency) {
    if (_noDecimalCurrencies.contains(currency.toUpperCase())) return 0;
    if (_twoDecimalCurrencies.contains(currency.toUpperCase())) return 2;
    return 2;
  }

  /// Formats [amount] (in minor units for no-decimal currencies, or standard
  /// units for decimal currencies) with the currency code.
  ///
  /// Examples:
  ///   format(5000, 'BIF') → '5,000 BIF'
  ///   format(999, 'USD')  → '9.99 USD'  (if stored in cents)
  ///
  /// This app stores BIF as whole integers.
  static String format(int amount, String currency) {
    final upper = currency.toUpperCase();
    final digits = fractionDigits(upper);
    final formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: digits,
    );
    return '${formatter.format(amount).trim()} $upper';
  }

  /// Formats without the currency code — useful for large displays.
  static String formatNumber(int amount, String currency) {
    final upper = currency.toUpperCase();
    final digits = fractionDigits(upper);
    final formatter = NumberFormat.currency(
      symbol: '',
      decimalDigits: digits,
    );
    return formatter.format(amount).trim();
  }

  /// Returns a compact representation, e.g. '5K BIF', '1.2M BIF'.
  static String formatCompact(int amount, String currency) {
    final formatter = NumberFormat.compact();
    return '${formatter.format(amount)} ${currency.toUpperCase()}';
  }

  /// Parses a user-entered string to an integer amount.
  static int? parse(String input, String currency) {
    final cleaned = input.replaceAll(',', '').replaceAll(' ', '').trim();
    final parsed = double.tryParse(cleaned);
    if (parsed == null) return null;
    return parsed.round();
  }
}
