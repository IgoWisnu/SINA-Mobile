import 'package:intl/intl.dart';

class DateFormatter {
  /// Format default: `26 Mei 2025, 15:40`
  static String format(DateTime dateTime) {
    return DateFormat('d MMMM yyyy, HH:mm', 'id_ID').format(dateTime);
  }

  /// Format hanya tanggal: `26 Mei 2025`
  static String formatTanggalOnly(DateTime dateTime) {
    return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
  }

  /// Format hanya jam: `15:40`
  static String formatJamOnly(DateTime dateTime) {
    return DateFormat('HH:mm', 'id_ID').format(dateTime);
  }
}
