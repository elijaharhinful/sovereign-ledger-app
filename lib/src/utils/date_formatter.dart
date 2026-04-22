import 'package:intl/intl.dart';

class DateFormatter {
  static final _dateFormat = DateFormat('MM/dd/yyyy');
  static final _monthYear = DateFormat('MMMM yyyy');
  static final _shortDate = DateFormat('MMM d');
  static final _timeFormat = DateFormat('h:mm a');
  static final _fullDate = DateFormat('MMM dd, yyyy');

  static String format(DateTime date) => _dateFormat.format(date);
  static String monthYear(DateTime date) => _monthYear.format(date);
  static String shortDate(DateTime date) => _shortDate.format(date);
  static String time(DateTime date) => _timeFormat.format(date);
  static String full(DateTime date) => _fullDate.format(date);

  static String relative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return shortDate(date);
  }
}
