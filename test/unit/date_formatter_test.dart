import 'package:flutter_test/flutter_test.dart';
import 'package:am_tips/core/utils/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    test('sectionHeader returns Today for today', () {
      final now = DateTime.now();
      expect(DateFormatter.sectionHeader(now), 'Today');
    });

    test('sectionHeader returns Yesterday for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(DateFormatter.sectionHeader(yesterday), 'Yesterday');
    });

    test('formatRelative returns just now for recent dates', () {
      final now = DateTime.now().subtract(const Duration(seconds: 10));
      expect(DateFormatter.formatRelative(now), 'just now');
    });

    test('isSameDay checks day match', () {
      final d1 = DateTime(2026, 8, 19, 10, 0);
      final d2 = DateTime(2026, 8, 19, 18, 30);
      final d3 = DateTime(2026, 8, 20, 10, 0);
      expect(DateFormatter.isSameDay(d1, d2), isTrue);
      expect(DateFormatter.isSameDay(d1, d3), isFalse);
    });
  });
}
