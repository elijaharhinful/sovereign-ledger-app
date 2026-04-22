import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(
    double amount, {
    String currencyCode = 'USD',
    String? symbol,
    bool showSign = false,
    bool isNegative = false,
  }) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: symbol ?? _symbolFor(currencyCode),
      decimalDigits: 2,
    );

    final formatted = formatter.format(amount.abs());

    if (showSign) {
      return isNegative ? '-$formatted' : '+$formatted';
    }
    return formatted;
  }

  static String formatCompact(double amount, {String currencyCode = 'USD'}) {
    final symbol = _symbolFor(currencyCode);
    if (amount >= 1000000) {
      return '$symbol${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '$symbol${(amount / 1000).toStringAsFixed(1)}k';
    }
    return format(amount, currencyCode: currencyCode);
  }

  static String _symbolFor(String code) {
    const symbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'GHS': '₵',
      'NGN': '₦',
      'JPY': '¥',
      'CAD': 'CA\$',
      'AUD': 'A\$',
    };
    return symbols[code] ?? '\$';
  }
}
