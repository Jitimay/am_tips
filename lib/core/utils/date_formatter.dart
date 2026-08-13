import 'package:intl/intl.dart';

/// Date/time formatting utilities for amTips.
class DateFormatter {
  DateFormatter._();

  static final _timeFormat = DateFormat('HH:mm');
  static final _dateFormat = DateFormat('MMM d, yyyy');
  static final _dateTimeFormat = DateFormat('MMM d, yyyy • HH:mm');
  static final _shortDateFormat = DateFormat('MMM d');
  static final _dayFormat = DateFormat('EEEE, MMM d');

  static String formatTime(DateTime date) => _timeFormat.format(date.toLocal());
  static String formatDate(DateTime date) => _dateFormat.format(date.toLocal());
  static String formatDateTime(DateTime date) => _dateTimeFormat.format(date.toLocal());
  static String formatShortDate(DateTime date) => _shortDateFormat.format(date.toLocal());
  static String formatDay(DateTime date) => _dayFormat.format(date.toLocal());

  /// Returns a human-readable relative time, e.g. "just now", "5m ago", "2h ago".
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date.toLocal());

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return formatDate(date);
  }

  /// Returns a section header for tip history grouping: "Today", "Yesterday", or date.
  static String sectionHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final localDate = DateTime(date.toLocal().year, date.toLocal().month, date.toLocal().day);

    if (localDate == today) return 'Today';
    if (localDate == yesterday) return 'Yesterday';
    return formatDate(date);
  }

  /// Whether two [DateTime] values are on the same calendar day.
  static bool isSameDay(DateTime a, DateTime b) {
    final la = a.toLocal();
    final lb = b.toLocal();
    return la.year == lb.year && la.month == lb.month && la.day == lb.day;
  }
}
